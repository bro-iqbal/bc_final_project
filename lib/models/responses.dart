enum Status { success, loading, error, timeout, internetError }

class APIResponse {
  final Status status;
  final Map<String, dynamic>? data;
  final String? message;

  APIResponse(this.status, this.data, this.message);

  static APIResponse success(data) {
    return APIResponse(Status.success, data, null);
  }

  static APIResponse error(data, String? message) {
    return APIResponse(Status.error, data, message);
  }

  static APIResponse internetError() {
    return APIResponse(Status.internetError, null, null);
  }
}
