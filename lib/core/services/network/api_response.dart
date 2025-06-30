class ApiResponse {
  const ApiResponse({this.data, required this.statusCode, this.error});

  final dynamic data;
  final int? statusCode;
  final Map<String, dynamic>? error;
}
