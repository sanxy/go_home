import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/customAppBar.dart';
import '../components/profileComponents.dart';
import '../dashboard.dart';
import './myProperties.dart';
import '../views/editProfile.dart';
import 'addProperties.dart';
import './inspectionRequest.dart';
import 'messages.dart';
import 'notifications.dart';
import 'favorites.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  var myString;

  getUserDetails() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    // Map userMap = jsonDecode(shared_User.getString('user'));
    user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);

    setState(() {
      myString = user[3];
    });
  }

  _logout() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.setStringList('user', []);
    shared_User.setBool("isAuth", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  void showSimpleCustomDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 150.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Are you sure you want to log out?",
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
                        _logout();
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

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account", style: TextStyle(color: Colors.black,)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          color: Color(0xFF79c942),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[

                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/person.png",
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white38,
                        maxRadius: 60,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            myString,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Color(0xFF79c942),
                              ),
                              Text( " " + user[6]),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Color(0xFF79c942),
                              ),
                              Text(" " + user[1]),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProperties(user[0]),
                      ),
                    );
                  },
                  child: ProfileComponents(
                    listIcon: Icons.edit,
                    listText: "My Properties",
                    clr: Colors.black12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  child: ProfileComponents(
                      listIcon: Icons.edit, listText: "Edit Profile"),
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
                  child: ProfileComponents(
                    listIcon: Icons.add,
                    listText: "Add Properties",
                    clr: Colors.black12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorites(),
                      ),
                    );
                  },
                  child: ProfileComponents(
                    listIcon: Icons.star,
                    listText: "Favorites",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InspectionRequest(),
                      ),
                    );
                  },
                  child: ProfileComponents(
                    listIcon: Icons.edit,
                    listText: "Inspection Request",
                    clr: Colors.black12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Messages(),
                      ),
                    );
                  },
                  child: ProfileComponents(
                      listIcon: Icons.trending_up, listText: "Messages"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notifications(),
                      ),
                    );
                  },
                  child: ProfileComponents(
                    listIcon: Icons.notifications,
                    listText: "Notifications",
                    clr: Colors.black12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showSimpleCustomDialog(context);
                  },
                  child: ProfileComponents(
                      listIcon: Icons.power_settings_new, listText: "Log out"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
