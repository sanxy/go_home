import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/customAppBar.dart';
import '../components/searchBar.dart';
import '../components/propertyList.dart';
import '../components/newsLetter.dart';
import '../components/pills.dart';
import '../views/eachProperty.dart';
import '../components/imageButton.dart';
import '../views/houses.dart';
import '../views/allHouses.dart';
import '../signUp.dart';
import '../views/rentHouses.dart';
import '../views/saleHouses.dart';
import '../views/blogDisplay.dart';
import '../views/topCities.dart';


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

  final User user;

  _DashboardTabState({this.user});


  Map data;

  List userData; //Property data

  static List updatedData;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://www.gohome.ng/get_all_api.php"),
        headers: {"Accept": "application/json"});

    userData = json.decode(response.body);

    setState(() {
      updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
    });
  }

  // Future<String> getUserDetails () async{
  //   SharedPreferences shared_User = await SharedPreferences.getInstance();
  //           // Map userMap = jsonDecode(shared_User.getString('user'));
  //           var user = shared_User.getStringList('user');
  //           debugPrint(user.toString());
  //           debugPrint(user[0]);
  // }

  @override
  void initState() {
    super.initState();
    getData();
    // getUserDetails();
  }

  @override
  void dispose() {
    super.dispose();
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
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ImageButton(label: "House for \n    rent", imageLink: "assets/rent.png", widget: RentHouses(),),
                            ImageButton(label: "   View all \n Properties", imageLink: "assets/properties.png", widget: AllHouses()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ImageButton(label: "House for \n    sale", imageLink: "assets/sale.png", widget: SaleHouses(),),
                            ImageButton(label: "Become an \n    agent", imageLink: "assets/cus_sup.png", widget: SignUp()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ImageButton(label: "Top cities \n   ", imageLink: "assets/building.png", widget: TopCities()),
                            ImageButton(label: "Blog Posts \n    ", imageLink: "assets/blog.png", widget: BlogDisplay(),),
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
                  updatedData == null ?
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: <Widget>[
                            Card()
                          ],
                        )
                      )
                    ),
                  )
                  :
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: updatedData == null ? 0 : updatedData.length,
                    itemBuilder: (context, index) {
                      final item = updatedData[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EachProperty(items: item),
                            ),
                          );
                        },
                        child: PropertyList(
                          amount: item["amount"],
                          location: item["address"],
                          propId: item["prop_id"],
                          region: item["region"],
                          state: item["state"],
                          imagePath: item["img1"],
                          saleOrRent: item["status"],
                          title: item["title"],
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
