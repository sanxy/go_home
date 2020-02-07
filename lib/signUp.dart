import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './dashboard.dart';
import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'dart:async';

import 'dart:convert';

import './classes/user.dart';
import './classes/success.dart';
import './login.dart';


class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignUpState();
}




class _SignUpState extends State<SignUp>{

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


  bool isLoading = false;
  bool displayMessage = false;

  final emailController =TextEditingController();
  final usernameController = TextEditingController();
  final phoneController =TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passController.dispose();
  }

  void authUser() {
    usernameController.text;
    passController.text;
  }

  login(BuildContext context, String email, String password) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();

    String body;

    if (email.length > 0 && password.length > 0) {
      setState(() {
        isLoading = true;
      });

      // set up POST request arguments
      String url = 'https://www.gohome.ng/_auth_user.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      var s = '{"email": ' +
          " \"" +
          email +
          "\"" +
          ', "password": ' +
          "\"" +
          password +
          "\"" +
          ' }';
      String json = s;
      // make POST request
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      body = response.body;

      User user = User.fromJson(jsonDecode(body));
      if (user.status == "OK") {
        debugPrint(user.email);
        Map decode_options = jsonDecode(body);
        // String userData = user.email;
        shared_User.setStringList('user', [
          user.id,
          user.email,
          user.avatar,
          user.name,
          user.message,
          user.password,
          user.phone,
          user.status
        ]);
        // shared_User.setString('user', userData);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              user: user,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
      // debugPrint(user.toString());
    } else {
      print("error");
    }
  }


  _makeAuth(BuildContext context) async {
    String username =usernameController.text;
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
      String url = 'https://www.gohome.ng/_auth_signup.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"name" : "${username}", "email" : "${email}", "phone" : "${phone}", "password" : "${password}" }';
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
        login(context, email, password);
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
    super.initState();
    isLoading = false;
    displayMessage = false;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Image(
                image: AssetImage("assets/gohome.png"),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  displayMessage ?
                    Text("User credentials invalid")
                  :
                  Card(
                    child: RichText(
                      text: TextSpan(),
                    )
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
                            focusColor: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            focusColor: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            focusColor: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    ),
                  ),
                  !isLoading && _current > 0
                      ? MaterialButton(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          minWidth: double.infinity,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _makeAuth(context);
                          },
                          color: Color(0xFF79c942),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xFF79c942),
                          ),
                        ),

                        Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text("Click here to Sign in.", style: TextStyle(color: Color(0xFF79c942),),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}