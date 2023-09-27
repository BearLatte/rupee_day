// ignore_for_file: constant_identifier_names, non_constant_identifier_names, depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rupee_day/util/dio_util/dio_cache_interceptors.dart';
import 'package:rupee_day/util/dio_util/dio_interceptors.dart';
import 'package:rupee_day/util/dio_util/dio_method.dart';
import 'package:rupee_day/util/dio_util/dio_transformer.dart';

class DioUtil {
  /// 连接超时时间
  static const Duration CONNECTION_TIMEOUT = Duration(milliseconds: 1000 * 60);

  /// 响应超时时间
  static const Duration RECEIVE_TIMEOUT = Duration(milliseconds: 60 * 1000);

  /// 统一 url 前缀
  static const String BASE_URL = 'http://149.129.217.31:1360/';

  /// 是否开启网络缓存，默认 false
  static bool CACHE_ENABLE = false;

  /// 最大缓存时间（单位：秒），默认 7 天，可自行配置
  static int MAX_CACHE_AGE = 60 * 60 * 24 * 7;

  /// 最大缓存条数
  static int MAX_CACHE_COUNT = 100;

  final CancelToken _cancelToken = CancelToken();

  late Dio _dio;

  factory DioUtil() => _getInstance();
  static DioUtil get instance => _getInstance();
  static DioUtil? _instance;

  DioUtil._init() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: CONNECTION_TIMEOUT,
      receiveTimeout: RECEIVE_TIMEOUT,
    );

    // 初始化 dio
    _dio = Dio(baseOptions);
    // 添加拦截器
    _dio.interceptors.add(DioInterceptors());
    // 添加缓存拦截器
    _dio.interceptors.add(DioCacheInterceptors());
    // dio 格式化输出
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    // 添加转换器
    _dio.transformer = DioTransformer();
  }

  static DioUtil _getInstance() {
    _instance ??= DioUtil._init();
    return _instance!;
  }

  // 统一请求方法
  Future request(String path,
      {DioMethod method = DioMethod.get, Map<String, dynamic>? params, data, CancelToken? cancelToken, Options? options, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress}) async {
    const methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head',
    };

    options ??= Options(method: methodValues[method]);
    try {
      Response response;
      response = await _dio.request(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel('cancelled');
  }
}
