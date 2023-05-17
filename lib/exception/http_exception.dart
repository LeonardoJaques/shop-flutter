class HttpExceptionWidget implements Exception {
  final String message;
  final int statusCode;

  HttpExceptionWidget({required this.message, required this.statusCode});

  @override
  String toString() {
    return message;
  }
}
