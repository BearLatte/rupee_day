import 'package:dio/dio.dart';
import 'package:rupee_day/util/dio_util/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheObject {
  Response response;
  int timestamp;
  CacheObject(this.response)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class DioCacheInterceptors extends Interceptor {
  var cache = <String, CacheObject>{};
  late SharedPreferences preferences;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!DioUtil.CACHE_ENABLE) return super.onRequest(options, handler);
    bool refresh = options.extra['refresh'] == true;
    if (refresh) {
      _delete(options.uri.toString());
    }

    // 只有 get 请求才开启缓存
    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        if ((DateTime.now().millisecondsSinceEpoch - ob.timestamp) / 1000 <
            DioUtil.MAX_CACHE_AGE) {
          return handler.resolve(cache[key]!.response);
        } else {
          cache.remove(key);
        }
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (DioUtil.CACHE_ENABLE) {
      _saveCache(response);
    }
    super.onResponse(response, handler);
  }

  void _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      // 如果缓存数量超过最大数量限制，删除最早的一条缓存
      if (cache.length == DioUtil.MAX_CACHE_COUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }

  void _delete(String key) {
    cache.remove(key);
  }
}
