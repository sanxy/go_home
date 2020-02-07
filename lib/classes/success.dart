class Success {

  String message;
  String status;

  Success(this.message, this.status);

  factory Success.fromJson(dynamic json) {
    return Success(
        json['message'] as String,
        json['status'] as String);
  }

  @override
  String toString() {
    return '{${this.message}, ${this.status} }';
  }
}