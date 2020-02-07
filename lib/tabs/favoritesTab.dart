import 'package:flutter/material.dart';

import 'dart:async';

import 'dart:convert';
import '../components/propertyList.dart';

import 'package:http/http.dart' as http;

class FavoritesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  Map data;

  List userData;

  static List updatedData;

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull("http://www.gohome.ng/get_all_api.php"),
        headers: {"Accept": "application/json"});

    // var response = await http.get("http://www.gohome.ng/get_all_api.php");
    userData = json.decode(response.body);

    setState(() {
      updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
    });

    debugPrint(userData.toString());
    return userData;
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(
                        " Properties added to favorites",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: new FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var myData = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = myData[index];
                                return PropertyList(
                                  amount: item["amount"],
                                  location: item["address"],
                                  propId: item["prop_id"],
                                  region: item["region"],
                                  state: item["state"],
                                  imagePath: item["img1"],
                                );
                              },
                              itemCount: myData.length,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      )

                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: ClampingScrollPhysics(),
                      //   itemCount: updatedData == null ? 0 : updatedData.length,
                      //   itemBuilder: (context, index) {
                      //     final item = updatedData[index];
                      //     return PropertyList(
                      //       amount: item["amount"],
                      //       location: item["address"],
                      //       propId: item["prop_id"],
                      //       region: item["region"],
                      //       state: item["state"],
                      //       imagePath: item["img1"],
                      //     );
                      //   },
                      // ),
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
