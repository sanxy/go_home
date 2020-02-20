class Property {

  String id;
  String amount;
  String propType;
  String bedroom;
  String bathroom;
  String prop_id;
  String user_id;
  String user_email;
  String name;
  String phone;
  String address;
  String region;
  String state;
  String title;
  String description;
  String img1;
  String img2;
  String status;

  Property({this.id, this.amount, this.propType, this.bedroom, this.bathroom, this.prop_id, this.user_id, this.user_email, this.name, this.phone, this.address,
      this.region, this.state, this.title, this.description, this.img1, this.img2, this.status});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
        id: json['id'] as String,
        amount: json['amount'] as String,
        propType: json['type'] as String,
        bedroom: json['bedrooms'] as String,
        bathroom: json['bathrooms'] as String,
        prop_id: json['prop_id'] as String,
        user_id: json['user_id'] as String,
        user_email: json['user_email'] as String,
        phone: json['phone'] as String,
        name: json['username'] as String,
        address: json['address'] as String,
        region: json['region'] as String,
        state: json['state'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        img1: json['img1'] as String,
        img2: json['img2'] as String,
        status: json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.amount}, ${this.phone}, ${this.name}, ${this.title}, ${this.status} }';
  }
}