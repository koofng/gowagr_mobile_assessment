import 'package:dio/dio.dart';
import 'package:gowagr_mobile_assessment/core/services/network/api_response.dart';

abstract class NetworkServiceAbstract {
  Future<ApiResponse> get(String path, {Map<String, dynamic>? queryParams, Options? options});
}
