import 'package:flutter/material.dart';
import 'package:go_home/views/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';

import '../components/searchBar.dart';
import '../components/propertyList.dart';
import '../components/newsLetter.dart';
import '../views/eachProperty.dart';
import '../components/imageButton.dart';
import '../signUp.dart';
import '../views/rentHouses.dart';
import '../views/saleHouses.dart';
import '../views/blogDisplay.dart';
import '../views/topCities.dart';
import '../views/allProperties.dart';
import '../dashboard.dart';

import '../services/services.dart';
import '../services/featuredServices.dart';
import '../classes/property.dart';

import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../classes/user.dart';

class DashboardTab extends StatefulWidget {
  final User user;

  DashboardTab({this.user});

  @override
  State<StatefulWidget> createState() => _DashboardTabState(user: user);
}

class _DashboardTabState extends State<DashboardTab> {
  int _start = 10;
  int _current = 10;
  bool isAuth = false;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      if (properties.length < 1 && _current < 1 ){
        internetDialog(context);
      }
      sub.cancel();
    });
  }

  final User user;
  List<Property> properties = List();
  List<Property> filteredProperties = List();

  _DashboardTabState({this.user});

  Map data;

  List userData; //Property data

  static List updatedData;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("https://www.gohome.ng/api/fetch_featured_api.php"),
        headers: {"Accept": "application/json"});

    userData = json.decode(response.body);

    // setState(() {
    //   updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
    // });
  }
  getUserState() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    bool isAuthenticated = shared_User.getBool("isAuth");
    var user = shared_User.getStringList('user');
    debugPrint(user.toString());
    // debugPrint(user[2]);

    setState(() {
      isAuth = isAuthenticated;
    });

    // String senderId = user[0].toString();

    // if (senderId.length > 0) {
    //   return true;
    // }
    // return false;
  }

  @override
  void initState() {
    super.initState(); 
    FeaturedServices.getProperties().then((propertiesFromServer) {
      setState(() {
        properties = propertiesFromServer;
        filteredProperties = properties;
      });
    });    
    startTimer();
    getUserState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  reload(){
    Navigator.pushReplacement(
      context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              user: user,
            ),
          ),
    );
  }

  void internetDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        color: Colors.transparent,
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
                      "Having issues viewing properties?",
                      style: TextStyle(fontSize: 18,),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                    "assets/noInternet.gif",
                    height: 100,
                  ),
                    Text(
                      "Please check your internet connection",
                      style: TextStyle(fontSize: 15), textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          reload();
                        },
                        icon: Icon(
                          Icons.refresh
                        ),
                      )
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // CustomAppBar(),
                  Text("Find Properties around you"),
                  SearchBox(),
                  // Text(User.fromJson(user["name"])),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(right: 10),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                label: "Property for \n       rent",
                                imageLink: "assets/rent.png",
                                widget: RentHouses(),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                label: "   View all \n Properties",
                                imageLink: "assets/properties.png",
                                widget: AllProperties(),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                label: "Property for \n        sale",
                                imageLink: "assets/sale.png",
                                widget: SaleHouses(),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            !isAuth?
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                  label: "Become an \n    agent",
                                  imageLink: "assets/cus_sup.png",
                                  widget: SignUp()),
                            )
                            :
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                  label: "Go to \n profile",
                                  imageLink: "assets/person.png",
                                  widget: Profile()),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                  label: "Top cities \n   ",
                                  imageLink: "assets/building.png",
                                  widget: TopCities()),
                            ),
                            Flexible(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Flexible(
                              flex: 5,
                              child: ImageButton(
                                label: "Blog Posts \n    ",
                                imageLink: "assets/blog.png",
                                widget: BlogDisplay(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: NewsLetter(),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      Text("Top featured properties"),
                    ],
                  ),
                  filteredProperties.length < 1 && _current > 0
                      ? Container(
                          height: 100,
                          width: double.infinity,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey,
                            highlightColor: Colors.white,
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                children: <Widget>[Card()],
                              ),
                            ),
                          ),
                        )
                      : filteredProperties.length < 1 && _current == 0
                          ? Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Icon(Icons.error,
                                      size: 70, color: Colors.red),
                                  Container(
                                    padding: EdgeInsets.all(30),
                                    child: Center(
                                      child: Text(
                                        "Could not fetch data from server. This is possibly due to the absence of internet connection",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: filteredProperties.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = filteredProperties[index];
                                return PropertyList(
                                  amount: filteredProperties[index].amount,
                                  imagePath: filteredProperties[index].img1,
                                  location: filteredProperties[index].address,
                                  propId: filteredProperties[index].prop_id,
                                  region: filteredProperties[index].region,
                                  saleOrRent: filteredProperties[index].status,
                                  title: filteredProperties[index].title,
                                  phone: filteredProperties[index].phone,
                                  state: filteredProperties[index].state,
                                  name: filteredProperties[index].name,
                                  email: filteredProperties[index].user_email,
                                  goto: EachProperty(
                                    item: item,
                                  ),
                                );
                              },
                            )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}
