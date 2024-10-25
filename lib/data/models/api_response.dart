class ApiResponse {
  final int statusCode;
  final bool isSuccess;
  dynamic responseBody;
  String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseBody,
    this.errorMessage = 'Something went wrong!',
  });
}
