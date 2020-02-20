import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'dart:async';
import 'dart:convert';

import '../classes/success.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>{
  var user;
  var myString;
  bool isLoading;
  var userId;

  TextEditingController userController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController webController =TextEditingController();

  getUserDetails() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    // Map userMap = jsonDecode(shared_User.getString('user'));
    user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);

    setState(() {
      myString = user[3];
      userController.text =user[3];
      emailController.text = user[1];
      phoneController.text = user[6];
      userId =user[0];
    });
  }

  _updateUserProfile() async{
    String username =userController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passController.text;
    SharedPreferences shared_User = await SharedPreferences.getInstance();

    String body;

    if (email.length > 0 && password.length > 0) {
      setState(() {
        isLoading = true;
      });
      
        // set up POST request arguments
      String url = 'https://www.gohome.ng/_update_user_api.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"name" : "${username}", "email" : "${email}", "phone" : "${phone}", "password" : "${password}", "user_id" : "${userId}" }';
      // make POST request
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      body = response.body;

      Success success = Success.fromJson(jsonDecode(body));
      if (success.status == "OK") {
        debugPrint(success.message);
        Map decode_options = jsonDecode(body);
        // String userData = user.email;
        // shared_Success.setString('user', userData);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Dashboard(),
        //   ),
        // );
        setState(() {
          isLoading = false;
        });

      }else{
        print('error connecting' + success.status);
      }
      // debugPrint(user.toString());
    } else {
      print("error");
    } 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        backgroundColor: Color(0xFF79c942),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bul2.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    Text(
                      "Edit Image",
                      style: TextStyle(color: Color(0xFF79c942)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: userController,
                        decoration: InputDecoration(hintText: 'Username'),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(hintText: 'Email'),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: passController,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(hintText: 'phone'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        controller: webController,
                        decoration: InputDecoration(hintText: 'Website'),
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (){
                        _updateUserProfile();
                      },
                      color: Color(0xFF79c942),
                      disabledColor: Color(0xFF79c942),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
