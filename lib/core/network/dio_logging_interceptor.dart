import 'package:dio/dio.dart';

import '../logging/app_logger.dart';

class DioLoggingInterceptor extends Interceptor {
  const DioLoggingInterceptor(this._logger);

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _logger.debug(
      '${response.requestOptions.method} ${response.requestOptions.uri} '
      '-> ${response.statusCode}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      '${err.requestOptions.method} ${err.requestOptions.uri} failed',
      error: err.error ?? err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
