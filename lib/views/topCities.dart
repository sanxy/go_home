import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/propertyList.dart';
import './cityContent.dart';

class TopCities extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TopCitiesState();

}


class TopCitiesState extends State<TopCities> {

  String location;

  sendToEach() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("location", location);
  }

  arraySeacrch(List haystack, String needle){
    if(haystack.length == 0){
      return false;
    }else{
      for(int i = 0; i <= haystack.length; i++ ){
        if (haystack[i] == needle){
          return true;
        }else{
          return false;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     location = "lagos"; 
    });
    sendToEach();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Top Cities"),
          backgroundColor: Color(0xFF79c942),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.priority_high),
                      Text(
                        "Here you find top cities in Nigeria",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                     location = "lagos"; 
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityContent("lagos"),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF79c942),
                          image: DecorationImage(
                              image: AssetImage("assets/lagos.jpg"),
                              fit: BoxFit.cover)),
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Text(
                                  "Lagos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityContent("abuja"),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/abuja.jpg"),
                              fit: BoxFit.cover)),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Text(
                                  "Abuja",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                     location = "abuja";  
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CityContent("port")));
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/port.jpg"),
                              fit: BoxFit.cover)),
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Text(
                                  "Port Harcourt",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                     location = "oyo"; 
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CityContent("oyo")));
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/oyo.png"),
                              fit: BoxFit.cover)),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Text(
                                  "Oyo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                     location = "imo"; 
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityContent("imo"),
                      ),
                    );
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF79c942),
                          image: DecorationImage(
                              image: AssetImage("assets/lagos.jpg"),
                              fit: BoxFit.cover)),
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: Text(
                                  "Imo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
