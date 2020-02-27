import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

// Native classes
import './login.dart';
import './views/noInternet.dart';
import './dashboard.dart';

// class SplashPage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() => _SplashPageState();
// }

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashPageState();
  
}

class _SplashPageState extends State<SplashPage> {

  _AuthPref() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    if (shared_User.getBool("isAuth") != true){
      shared_User.setBool("isAuth", false);
    } else if (shared_User.getBool("isAuth") == true){
      shared_User.setBool("isAuth", true); 
    }else{
      shared_User.setBool("isAuth", false);
    }
    
  }

  checkConnection() async {
    try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print(result.toString());
          return 1;
        }else{
          return 0;
        }
      } on SocketException catch (_) {
        print("false");
        return 0;
      }
    }

    @override
  void initState() {
    super.initState();
    _AuthPref();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      photoSize: 100.0,
      image: Image(
        image: new AssetImage('assets/gohome.png'),
        alignment: Alignment.center,  
      ),
      
      loaderColor: Color(0xFF79c942),
      navigateAfterSeconds: 
      Dashboard()
    );
  }
  
}
