import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';

import '../classes/success.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var user;
  var myString;
  bool isLoading;
  var userId;

  Future<File> file;
  String base64String;
  File tmpFile;

//   Future<void> retrieveLostData() async {
//   final LostDataResponse response =
//       await ImagePicker.retrieveLostData();
//   if (response == null) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       if (response.type == RetrieveType.video) {
//         _handleVideo(response.file);
//       } else {
//         _handleImage(response.file);
//       }
//     });
//   } else {
//     _handleError(response.exception);
//   }
// }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController webController = TextEditingController();

  getUserDetails() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    // Map userMap = jsonDecode(shared_User.getString('user'));
    user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);

    setState(() {
      myString = user[3];
      userController.text = user[3];
      emailController.text = user[1];
      phoneController.text = user[6];
      userId = user[0];
    });
  }

  Future<void> retrieveLostData() async {
  final LostDataResponse response =
      await ImagePicker.retrieveLostData();
  if (response == null) {
    return;
  }
  if (response.file != null) {
    setState(() {
      if (response.type == RetrieveType.video) {
        // _handleVideo(response.file);
      } else {
        // _handleImage(response.file);
      }
    });
  } else {
    // _handleError(response.exception);
  }
}

  _updateUserProfile() async {
    String username = userController.text;
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
      String json =
          '{"name" : "${username}", "email" : "${email}", "phone" : "${phone}", "password" : "${password}", "user_id" : "${userId}" }';
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
    // TODO: implement initState
    super.initState();
    getUserDetails();
    retrieveLostData();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64String = base64Encode(snapshot.data.readAsBytesSync());
          // return Container(
          //   child: Text(snapshot.data.toString())
          // );
          return Container(
              padding: EdgeInsets.all(20),
              child: Image.file(
                snapshot.data,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 200,
              ),
            // ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            "Error selecting image",
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            "No image found",
            textAlign: TextAlign.center,
          );
        }
      },
    );
    //  }
    // );
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
                  child: GestureDetector(
                    onTap: chooseImage,
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
                  )),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: showImage(),
                      width: double.infinity,
                      height: 300,
                    ),
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
                      onPressed: () {
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
