import 'package:dio/dio.dart';
import 'package:gowagr_mobile_assessment/core/services/network/api_response.dart';
import 'package:gowagr_mobile_assessment/core/services/network/network_service_abstract.dart';

class NetworkServiceImpl implements NetworkServiceAbstract {
  final Dio _dio;

  NetworkServiceImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://api.gowagr.app/pm/', // TODO: to be extracted out
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        ),
      ) {
    // Optional: Logging interceptor
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  @override
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParams, Options? options}) async {
    late final ApiResponse apiResponse;
    try {
      final Response<dynamic> response = await _dio.get(path, queryParameters: queryParams);
      apiResponse = ApiResponse(statusCode: response.statusCode, data: response.data);
    } on DioException catch (e) {
      apiResponse = _handleDioError(e);
    } on Error catch (e) {
      apiResponse = _handleError(e);
    }
    return apiResponse;
  }

  ApiResponse _handleError(Error e) {
    return ApiResponse(statusCode: null, error: <String, dynamic>{'error': 'An Error Occurred'});
  }

  ApiResponse _handleDioError(DioException e) {
    late final ApiResponse apiResponse;
    if (e.response != null && e.response!.data != null) {
      Map<String, dynamic> data = <String, dynamic>{};
      if (e.response!.data is Map<String, dynamic>) {
        data = e.response!.data as Map<String, dynamic>;
      } else {
        data['error'] = e.response!.data;
      }
      apiResponse = ApiResponse(statusCode: e.response?.statusCode, error: data);
    } else {
      apiResponse = ApiResponse(statusCode: e.response?.statusCode, error: <String, dynamic>{'error': 'An Error Occurred'});
    }
    return apiResponse;
  }
}
