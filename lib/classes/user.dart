class User {

  String id;
  String name;
  String email;
  String password;
  String phone;
  String avatar;
  String website;
  String message;
  String status;

  User(this.id, this.name, this.email, this.password, this.phone, this.avatar,
      this.website, this.message, this.status);

  factory User.fromJson(dynamic json) {
    return User(
        json['id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['password'] as String,
        json['phone'] as String,
        json['avatar'] as String,
        json['website'] as String,
        json['message'] as String,
        json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.message}, ${this.status} }';
  }
}