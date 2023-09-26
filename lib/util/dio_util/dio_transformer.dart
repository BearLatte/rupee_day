import 'package:dio/dio.dart';

class DioTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) {
    if (options.data is List<String>) {
      throw DioException(
          requestOptions: options,
          error: 'Cannot send list directly to the server!');
    } else {
      return super.transformRequest(options);
    }
  }

  @override
  Future transformResponse(RequestOptions options, ResponseBody responseBody) {
    options.extra['options'] = 'abc';
    return super.transformResponse(options, responseBody);
  }
}
