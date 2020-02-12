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

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                    ),
                    onPressed: null,
                  ),
                  Text(
                    "My Account",
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/cus_sup.png",
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white38,
                      maxRadius: 70,
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
                            Text("08023454545"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              color: Color(0xFF79c942),
                            ),
                            Text(user[1]),
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
                      builder: (context) => MyProperties(),
                    ),
                  );
                },
                child: ProfileComponents(
                    listIcon: Icons.edit, listText: "My Properties", clr: Colors.black12,),
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
                child: ProfileComponents(listIcon: Icons.edit, listText: "Edit Profile"),
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
                  listIcon: Icons.add, listText: "Add Properties", clr: Colors.black12,),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Favorites(),
                    ),
                  );
                },
                child: ProfileComponents(listIcon: Icons.star, listText: "Favorites",),
              ),
              
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InspectionRequest(),
                    ),
                  );
                },
                child: ProfileComponents(
                  listIcon: Icons.edit, listText: "Inspection Request", clr: Colors.black12,),
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
                child:  ProfileComponents(
                  listIcon: Icons.trending_up, listText: "Messages"),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Notifications(),
                    ),
                  );
                },
                child: ProfileComponents(
                  listIcon: Icons.notifications, listText: "Notifications", clr: Colors.black12,),
              ),
              GestureDetector(
                onTap: _logout,
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
