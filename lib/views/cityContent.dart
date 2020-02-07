import 'package:flutter/material.dart';

import 'dart:async';

import 'package:async/async.dart';

import 'dart:convert';
import '../components/propertyList.dart';
import '../views/eachProperty.dart';

import 'package:http/http.dart' as http;

class CityContent extends StatefulWidget {

  final String location;

  CityContent(this.location);

  @override
  State<StatefulWidget> createState() => _CityContentState(location);
}

class _CityContentState extends State<CityContent> with WidgetsBindingObserver {

  final String location;

  _CityContentState(this.location);

  Map data;

  List userData;

  static List updatedData;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  getData() async {
    return this._memoizer.runOnce(() async {
      var response = await http.get(
          Uri.encodeFull(
              "http://www.gohome.ng/getProperties.php?state='${location}'"),
          headers: {"Accept": "application/json"});

      // var response = await http.get("http://www.gohome.ng/get_all_api.php");
      userData = json.decode(response.body);

      setState(() {
        updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
      });

      debugPrint(userData.toString());
      return userData;
    });
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Properties for ${location}"),
          backgroundColor: Color(0xFF79c942),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Showing all available Properties for ${location}",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EachProperty(items: item),
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
                        itemCount: myData.length,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
