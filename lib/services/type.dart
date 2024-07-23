class ServiceResponse {
  bool success;
  String message;
  dynamic data;
  dynamic errors;

  ServiceResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> map) {
    return ServiceResponse(
      success: map['success'] ?? false,
      message: map['message'],
      data: map['data'],
      errors: map['errors'],
    );
  }
}
