class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class UnAuthenticatedException implements Exception {
  UnAuthenticatedException(
    this.message,
  );

  final String message;
}
