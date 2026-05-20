import 'package:dio/dio.dart';

import 'api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(
      err.copyWith(error: ApiException.fromDioException(err)),
    );
  }
}
