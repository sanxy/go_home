class Message {

  String message;
  String status;
  String title;
  String body;
  String senderName;
  String propTitle;
  String location;
  String propId;
  String img1;

  Message(this.message, this.status, this.title, this.body, this.senderName, this.propTitle, this.location, this.propId, this.img1);

  factory Message.fromJson(dynamic json) {
    return Message(
        json['message'] as String,
        json['status'] as String,
        json['title'] as String,
        json['body'] as String,        
        json['senderName'] as String,
        json['propTitle'] as String,
        json['location'] as String,
        json['propId'] as String,
        json['img1'] as String,
        );
  }

  @override
  String toString() {
    return '{${this.message}, ${this.status} }';
  }
}