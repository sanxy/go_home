import 'package:flutter/material.dart';

import 'dart:async';

import 'package:async/async.dart';

import 'dart:convert';
import '../components/propertyList.dart';
import '../views/eachProperty.dart';

import 'package:http/http.dart' as http;

class SaleHouses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaleHousesState();
}

class _SaleHousesState extends State<SaleHouses> with WidgetsBindingObserver {
  Map data;
    String dropdownValue = "Price";
  String dropResult = "100";

  List userData;

  static List updatedData;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  getData() async {
    return this._memoizer.runOnce(() async {
      var response = await http.get(
          Uri.encodeFull(
              "http://www.gohome.ng/fetch_selected.php?status='Sale'"),
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
          title: Text("All Properties for Sale"),
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
                        "Showing all available Properties for sale",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Text("Filter: "),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Price', 'Location', 'Type', 'Status']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: DropdownButton<String>(
                          value: dropResult,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropResult = newValue;
                            });
                          },
                          items: <String>['100', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )
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
