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
  String saleOrRent;
  String img1;
  String img2;
  String img3;
  String img4;
  String img5;
  String img6;
  String img7;
  String img8;
  String img9;
  String img10;
  String img11;
  String img12;
  String img13;
  String img14;
  String img15;
  String status;

  Property(
      {this.id,
      this.amount,
      this.propType,
      this.bedroom,
      this.bathroom,
      this.prop_id,
      this.user_id,
      this.user_email,
      this.name,
      this.phone,
      this.address,
      this.region,
      this.state,
      this.title,
      this.saleOrRent,
      this.description,
      this.img1,
      this.img2,
      this.status,
      this.img3,
      this.img4,
      this.img5,
      this.img6,
      this.img7,
      this.img8,
      this.img9,
      this.img10,
      this.img11,
      this.img12,
      this.img13,
      this.img14,
      this.img15});

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
        saleOrRent: json['status'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        img1: json['img1'] as String,
        img2: json['img2'] as String,
        img3: json['img3'] as String,
        img4: json['img4'] as String,
        img5: json['img5'] as String,
        img6: json['img6'] as String,
        img7: json['img7'] as String,
        img8: json['img8'] as String,
        img9: json['img9'] as String,
        img10: json['img10'] as String,
        img11: json['img11'] as String,
        img12: json['img12'] as String,
        img13: json['img13'] as String,
        img14: json['img14'] as String,
        img15: json['img15'] as String,
        status: json['status'] as String);
  }

  @override
  String toString() {
    return '{ ${this.amount}, ${this.phone}, ${this.name}, ${this.title}, ${this.status} }';
  }
}
