class ApiErrorException implements Exception {
  final String message;
  final Map<String,String>? _errors;

  ApiErrorException(
    this.message,
    this._errors
  );

  Map<String,String>? get errors => _errors;

  @override
  String toString() {
    return message;
  }
}