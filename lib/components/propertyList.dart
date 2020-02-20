import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import './pills.dart';

class PropertyList extends StatefulWidget {
  final String id;
  final String amount;
  final String location;
  final String propId;
  final String state;
  final String region;
  final String imagePath;
  final String saleOrRent;
  final String title;
  final String phone;
  final String name;
  final String email;
  final Widget goto;

  PropertyList(
      {this.id,
      this.amount,
      this.location,
      this.propId,
      this.region,
      this.state,
      this.imagePath,
      this.saleOrRent,
      this.title,
      this.phone,
      this.name,
      this.email,
      this.goto,});

  @override
  State<StatefulWidget> createState() => _PropertyListState(
      id: id,
      amount: amount,
      location: location,
      propId: propId,
      region: region,
      state: state,
      imagePath: imagePath,
      saleOrRent: saleOrRent,
      title: title,
      phone: phone,
      name: name,
      email: email,
      goto: goto,);
}

class _PropertyListState extends State<PropertyList> {
  final String id;
  final String amount;
  final String location;
  final String propId;
  final String state;
  final String region;
  final String imagePath;
  final String saleOrRent;
  final String title;
  final String phone;
  final String name;
  final String email;
  final Widget goto;

  _PropertyListState(
      {this.id,
      this.amount,
      this.location,
      this.propId,
      this.region,
      this.state,
      this.imagePath,
      this.saleOrRent,
      this.title,
      this.phone,
      this.name,
      this.email,
      this.goto,});

  String a;

  void showSimpleCustomDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "User Details",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        name,
                        style:
                            TextStyle(color: Color(0xFF79c942), fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("E-mail: " + email),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Phone number: " + phone),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    color: Color(0xFF79c942),
                    onPressed: () => launch("tel:${phone}"),
                    child: Text(
                      'Call Contact',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  void addToFavorites(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add " + title + " to favorites",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          isActive = true;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Icon(
                        Icons.check,
                        color: Color(0xFF79c942),
                      )),
                  MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  bool isActive = false;

  FlutterMoneyFormatter fAmount;

  @override
  void initState() {
    super.initState();
    isActive = false;
    a = amount;
    fAmount =
        FlutterMoneyFormatter(amount: double.parse(a));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 144.0,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            // Image(
            //   image: CachedNetworkImageProvider("http://gohome.ng/assets/upload/" + propId + "/" + imagePath,),
            //   fit: BoxFit.cover,
            //   width:MediaQuery.of(context).size.width * 0.4,
            // ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onLongPress: () {
                    addToFavorites(context);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => goto),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: "http://gohome.ng/assets/upload/" +
                            propId +
                            "/" +
                            imagePath,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  saleOrRent.length > 1 ?
                                  Container(
                                    child: Pill("For " + saleOrRent),
                                  )
                                  :
                                  null,
                                  isActive
                                      ? Container(
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        )
                                      : Container(child: Text(""))
                                ],
                              ),
                            ),

                            Container(
                              child: Text(
                                title.length > 20
                                    ? title.substring(0, 28) + "..."
                                    : title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF79c942),
                                ),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.only(left: 5),
                            //   child: Text(region + ", " + state),
                            // ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  Text(
                                    location.length > 20
                                        ? location.substring(0, 20) + "..."
                                        : location,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "\u20A6 " + fAmount.output.nonSymbol.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF79c942),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showSimpleCustomDialog(context);
                  },
                  child: Container(
                    color: Color(0xFF79c942),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "View Contact",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => goto),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 25, right: 25),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("View Property"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
