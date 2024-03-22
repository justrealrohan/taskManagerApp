class ResponseObject {
  final int statusCode;
  final dynamic responseBody;
  final String? errorMessage;
  final bool isSuccess;

  ResponseObject({
    required this.statusCode,
    required this.responseBody,
    this.errorMessage = '',
    required this.isSuccess,
  });

  @override
  String toString() {
    return 'ResponseObject: {isSuccess: $isSuccess, responseBody: $responseBody}';
  }
}