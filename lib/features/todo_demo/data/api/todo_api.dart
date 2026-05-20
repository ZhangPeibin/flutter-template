import 'package:dio/dio.dart';

import '../../../../core/network/api_exception.dart';

class TodoApi {
  const TodoApi(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchTodo(int id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/todos/$id');
      final data = response.data;

      if (data == null) {
        throw const ApiException(
          type: ApiExceptionType.badResponse,
          message: 'Todo response was empty',
        );
      }

      return data;
    } on DioException catch (error) {
      final apiException = error.error;

      if (apiException is ApiException) {
        throw apiException;
      }

      throw ApiException.fromDioException(error);
    }
  }
}
