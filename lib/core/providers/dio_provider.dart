import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/dio_logging_interceptor.dart';
import '../network/error_interceptor.dart';
import 'app_config_provider.dart';
import 'logger_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final logger = ref.watch(loggerProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: const {
        Headers.acceptHeader: Headers.jsonContentType,
      },
    ),
  );

  dio.interceptors
    ..add(ErrorInterceptor())
    ..add(DioLoggingInterceptor(logger));

  return dio;
});
