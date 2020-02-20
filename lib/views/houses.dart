import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:quiver/async.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../views/eachProperty.dart';
import '../components/propertyList.dart';
import '../components/pills.dart';

class Houses extends StatefulWidget {
  final String dataKind;

  Houses({this.dataKind});

  @override
  State<StatefulWidget> createState() => _HousesState(dataKind: dataKind);
}

class _HousesState extends State<Houses> {
  Map data;
  List userData;
  static List updatedData;

  final String dataKind;

  _HousesState({this.dataKind});

  Future getData() async {
    var response;

    if (dataKind != "all") {
      response = await http.get(
          Uri.encodeFull("http://www.gohome.ng/fetch_selected.php?status=" +
              '"' +
              dataKind +
              '"'),
          headers: {"Accept": "application/json"});
    } else {
      response = await http.get(
          Uri.encodeFull("http://www.gohome.ng/get_all_api.php"),
          headers: {"Accept": "application/json"});
    }

    userData = json.decode(response.body);

    if (userData.isEmpty) {
      return null;
    } else {
      setState(() {
        updatedData = [for (var i = 0; i <= 2; i += 1) userData[i]];
      });

      debugPrint(userData.toString());
      return userData;
    }
  }

  int _start = 10;
  int _current = 10;

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
      sub.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Houses for " + dataKind),
        backgroundColor: Color(0xFF79c942),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Houses displayed here are for " + dataKind,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
            ),
            updatedData[0] == null && _current > 0
                ? SafeArea(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 110,
                              margin: EdgeInsets.all(10),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white60,
                                child: Card(),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.all(10),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white60,
                                child: Card(),
                              ),
                            ),
                            Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.all(10),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white60,
                                child: Card(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : _current <= 0 && updatedData[0] == null
                    ? Container(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            margin: EdgeInsets.only(top: 170),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.notification_important,
                                  size: 80,
                                ),
                                Text(
                                  "No property found for this instance",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
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
                                  builder: (context) =>
                                      EachProperty(item: item),
                                ),
                              );
                            },
                            child: PropertyList(
                              id: item["id"],
                              amount: item["amount"],
                              location: item["address"],
                              propId: item["prop_id"],
                              region: item["region"],
                              state: item["state"],
                              imagePath: item["img1"],
                            ),
                          );
                        },
                      )
          ],
        ),
      )),
    );
  }
}
