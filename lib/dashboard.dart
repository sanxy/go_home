import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './tabs/dashboardTab.dart';
import './tabs/favoritesTab.dart';
import './tabs/messagesTab.dart';
import './tabs/blogTab.dart';
import './views/profile.dart';
import './classes/user.dart';
import './views/allhouses.dart';
import './views/inquiryForm.dart';
import './Login.dart';
import './views/addProperties.dart';

class Dashboard extends StatefulWidget {
  final User user;

  Dashboard({this.user});

  @override
  _DashboardState createState() => _DashboardState(user: user);
}

class _DashboardState extends State<Dashboard> {
  final User user;

  bool isAuth = false;

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
    getUserState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _DashboardState({this.user});

  int _currentIndex = 0;

  final tabs = [DashboardTab(), FavoritesTab(), MessagesTab(), BlogTab()];

  bool boolTrue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/bul2.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllHouses(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      "Properties",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InquiryForm()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      "Inquiry Form",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProperties(),
                      ),
                    );
                  },
                  
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      "Add Property",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                !isAuth
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          child: Text(
                            "Sign in",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : Text("")
              ],
            ),
          ),
        ],
      )),
      // appBar:  AppBar(...) : null
      appBar: boolTrue ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image(
          image: AssetImage('assets/gohome.png'),
          width: 100,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xFF79c942),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          isAuth
              ? Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF79c942),
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Text("")
        ],
      )
      :
      null,
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF79c942),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            title: Text("Blog"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
