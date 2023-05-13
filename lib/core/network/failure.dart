class Failure {
  String? message;

  Failure({
    this.message,
  });

  Failure.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "Something went wrong.";
  }
}
