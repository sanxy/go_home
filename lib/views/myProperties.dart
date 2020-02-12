import 'package:flutter/material.dart';

import 'dart:convert';
import '../components/propertyList.dart';
import '../components/myPropertiesComponent.dart';
import './eachProperty.dart';
import 'package:async/async.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyProperties extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPropertiesState();
}

class _MyPropertiesState extends State<MyProperties> {
  Map data;

  String furnValue = "Furnished";
  String regionValue = "Any Region";
  String statusValue = "Sale";
  String bedroomValue = "Bedrooms";
  String bathroomValue = "Bathrooms";
  String minAmountValue = "Min Amount";
  String maxAmountValue = "Max Amount";

  List userData;

  static List updatedData;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  // initData() async{

  //   SharedPreferences shared_User = await SharedPreferences.getInstance();

  // }

  getData() async {
    return this._memoizer.runOnce(() async {
      var response = await http.get(
          Uri.encodeFull(
              "http://www.gohome.ng/getMyProperties.php?user_id='18'"),
          headers: {"Accept": "application/json"});

      // var response = await http.get("http://www.gohome.ng/get_all_api.php");
      userData = json.decode(response.body);

      // setState(() {
      //   updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
      // });

      debugPrint(userData.toString());
      return userData;
    });
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Filter Property type",
                style: TextStyle(fontSize: 30),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: regionValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      regionValue = newValue;
                    });
                  },
                  items: <String>['Any Region', 'Oyo', 'Abuja', 'Imo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: furnValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: (String newValue) {
                    setState(() {
                      furnValue = newValue;
                    });
                  },
                  items: <String>['Furnished', 'Unfurnished']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(5),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: statusValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      statusValue = newValue;
                    });
                  },
                  items: <String>['Sale', 'Rent']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: bedroomValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      bedroomValue = newValue;
                    });
                  },
                  items: <String>['Bedrooms', '1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: bathroomValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      bathroomValue = newValue;
                    });
                  },
                  items: <String>['Bathrooms', '1', '2', '3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: minAmountValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      minAmountValue = newValue;
                    });
                  },
                  items: <String>['Min Amount', '1,000', '10,000', '100,000']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: maxAmountValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 0,
                    color: Colors.black,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      maxAmountValue = newValue;
                    });
                  },
                  items: <String>['Max Amount', '1,000', '10,000', '100,000']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              MaterialButton(
                onPressed: null,
                child: Text("Apply Filter"),
                color: Color(0xFF79c942),
              )
            ],
          ))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Properties for rent"),
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
                        "Showing all available Properties for rent",
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
                child: Text(
                  "Filter",
                  style: TextStyle(color: Color(0xFF79c942)),
                ),
                elevation: 10,
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
                            child: MyPropertiesComponent(
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
