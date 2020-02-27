import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_home/classes/success.dart';
import 'package:go_home/views/modifyPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard.dart';
import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'dart:async';

import 'dart:convert';

import '../classes/user.dart';
import '../signUp.dart';

class ConfCode extends StatefulWidget {
  final String email;

  ConfCode({this.email});

  @override
  State<StatefulWidget> createState() => _ConfCodeState(email: email);
}

class _ConfCodeState extends State<ConfCode> with WidgetsBindingObserver {
  final String email;

  _ConfCodeState({this.email});

  void login() {
    print("Next");
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

  bool isLoading = false;
  bool displayMessage = false;

  final codeController = TextEditingController();

  _makeAuth(BuildContext context) async {
    String code = codeController.text;
    SharedPreferences shared_User = await SharedPreferences.getInstance();

    String body;

    if (code.length > 0) {
      setState(() {
        isLoading = true;
      });

      // set up POST request arguments
      String url = 'https://www.gohome.ng/api/password_reset_api.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"code" : "${code}"}';
      // make POST request
      Response response = await post(url, headers: headers, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      body = response.body;

      print(body.toString());

      Success success = Success.fromJson(jsonDecode(body));
      if (success.status == "OK") {
        debugPrint(success.message);
        Map decode_options = jsonDecode(body);
        // String userData = user.email;
        // shared_Success.setString('user', userData);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifyPassword(
              email: email,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } else {
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
    WidgetsBinding.instance.addObserver(this);
    isLoading = false;
    displayMessage = false;
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfCode(
            email: email,
          ),
        ),
      );
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive

    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
      WidgetsBinding.instance.attachRootWidget(ConfCode(email: email,));
      
    } else if (state == AppLifecycleState.detached) {
      // app suspended (not used in iOS)
    }
  }

  bool is_checked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.white30,
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child:
                        Text("Please kindly enter the code sent to your email"),
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
                        controller: codeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password reset code',
                            focusColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _makeAuth(context);
                          },
                          color: Color(0xFF79c942),
                        )
                      : _current <= 0
                          ?
                          // (){
                          //   setState(() {
                          //     displayMessage = true;
                          //     isLoading = false;
                          //   });
                          // }
                          MaterialButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              minWidth: double.infinity,
                              child: Text(
                                "SignIn",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Click here to register.",
                          style: TextStyle(color: Color(0xFF79c942)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
