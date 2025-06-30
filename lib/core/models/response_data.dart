class ResponseData<T> {
  ResponseData({required this.success, this.message, this.data, this.statusCode});
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;
}
