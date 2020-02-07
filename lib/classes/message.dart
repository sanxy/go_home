class Message {

  String message;
  String status;
  String title;
  String body;
  String senderName;

  Message(this.message, this.status, this.title, this.body, this.senderName);

  factory Message.fromJson(dynamic json) {
    return Message(
        json['message'] as String,
        json['status'] as String,
        json['title'] as String,
        json['body'] as String,        
        json['senderName'] as String,
        );
  }

  @override
  String toString() {
    return '{${this.message}, ${this.status} }';
  }
}