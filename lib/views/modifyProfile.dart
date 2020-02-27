import 'package:flutter/material.dart';
import 'package:go_home/views/profile.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_home/classes/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';

import '../components/labelledInput.dart';

class ModifyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyProfileState();
}

class _ModifyProfileState extends State<ModifyProfile> {
  Future<File> file;

  List user;
  String user_id, user_email;

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

  // getUserDetails() async {
  //   SharedPreferences shared_User = await SharedPreferences.getInstance();
  //   // Map userMap = jsonDecode(shared_User.getString('user'));
  //   user = shared_User.getStringList('user');
  //   debugPrint(user.toString());
  //   debugPrint(user[2]);

  //   setState(() {
  //     user_id = user[0];
  //     user_email = user[1];
  //     print(user_email);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  static final String uploadEndPoint =
      'https://gohome.ng/uploadProperty_image_api.php';
  String status = '';
  String base64String;
  File tmpFile;
  String errMessage = "Error uploading Image";

  String propertyValue = "House";
  String saleOrRent = "Sale";
  String bedroom = "Bedroom";
  String yesNo = "Yes"; //Garages
  String stateValue = "Lagos"; //State
  String lgaValue = "Any LGA";

  //Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController bathCountController = TextEditingController();
  TextEditingController storeyController = TextEditingController();
  TextEditingController plotController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  List<String> features = List();
  List<Future<File>> fileList = List();
  List<File> tmpList = List();

  List bsList = [];

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

  String myString, userId;

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

  _updateUserProfile(String filename) async {
    String username = userController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String password = passController.text;
    SharedPreferences shared_User = await SharedPreferences.getInstance();

    String body;

    if (email.length > 0 && password.length > 0) {
      setState(() {
        // isLoading = true;
      });

      // set up POST request arguments
      String url = 'https://www.gohome.ng/_update_user_api.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json =
          '{"name" : "${username}", "email" : "${email}", "phone" : "${phone}", "password" : "${password}", "user_id" : "${userId}", "img_name": "${filename}" }';
      // make POST request
      Response response = await post(url, headers: headers, body: json);
      // Response response = await post(url, body: json);
      // check the status code for the result
      int statusCode = response.statusCode;
      // this API passes back the id of the new item added to the body
      body = response.body;

      print(body.toString());

      Success success = Success.fromJson(jsonDecode(body));
      if (success.status == "OK") {
        debugPrint(success.message);
        Map decode_options = jsonDecode(body);
        String uploadUrl = "https://www.gohome.ng/upload_image_api.php";
        
        http.post(uploadUrl,
          body: {"image": base64String, "img_name": filename, "email": email}).then((result) {
          // setStatus(result.statusCode == 200 ? result.body : errMessage);
          setStatus(result.body);
        }).catchError((error) {
          setStatus(error.toString());
          print(error.toString());
        });
        setState(() {
          // isLoading = false;
        });
      } else {
        print('error connecting' + success.status);
      }
      // debugPrint(user.toString());
    } else {
      print("error");
    }
  }

  List<bool> arr_check = [for (int i = 0; i < 14; i++) false];

  setStatus(String message) {
    setState(() {
      // message.length != 0?
      // status = message.substring(0,20)
      // :
      status = message;
    });
  }

  checkValue(String val, List arr) {
    if (arr.length == 0) {
      return false;
    } else if (arr.contains(val)) {
      return true;
    } else {
      return false;
    }
  }

  List<String> fileNameList = List();
  startUpload() {
    setStatus("Uploading...");
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    // String filename;
    // for(int i = 0; i < tmpList.length; i++){
    //   filename = tmpList[i].path.split('/').last;
    //   fileNameList.add(filename);
    // }
    // upload(fileNameList);
    String filename = tmpFile.path.split('/').last;
    _updateUserProfile(filename);
  }

  // upload(String filename) async {
  //   String featureToString = features.join(',');
  //   String body;
  //   String title = titleController.text;
  //   String desc = descController.text;
  //   String bath = bathCountController.text;
  //   String storey = storeyController.text;
  //   String plot = plotController.text;
  //   String price = priceController.text;
  //   String address = addressController.text;
  //   String zip = zipController.text;
  //   Map<String, String> headers = {"Content-type": "application/json"};
  //   String url = "https://gohome.ng/api/upload_property_data.php";
  //   String json = 
  //   // make POST request
  //   // print(json);
  //   Response response = await post(url, headers: headers, body: json);
  //   // check the status code for the result
  //   int statusCode = response.statusCode;
  //   // this API passes back the id of the new item added to the body
  //   body = response.body;

  //   Success success = Success.fromJson(jsonDecode(body));
  //   if (success.status == "OK") {
  //     titleController.text = null;
  //     descController.text = null;
  //     bathCountController.text = null;
  //     bathCountController.text = null;
  //     storeyController.text = null;
  //     plotController.text = null;
  //     priceController.text = null;
  //     addressController.text = null;
  //     zipController.text = null;

  //     debugPrint(success.message);
  //     Map decode_options = jsonDecode(body);
  //     http.post(uploadEndPoint,
  //         body: {"image": base64String, "name": filename}).then((result) {
  //       setStatus(result.statusCode == 200 ? result.body : errMessage);
  //     }).catchError((error) {
  //       // setStatus(error.toString());
  //       print(error.toString());
  //     });
  //   } else {
  //     print('error connecting' + success.status);
  //   }
  // }

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
            width: MediaQuery.of(context).size.width * 0.85,
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: ClipOval(
              child: Image.file(
                snapshot.data,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 200,
              ),
            ),
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

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );

  }

  @override
  Widget build(BuildContext context) {
    bool is_checked = true;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("Modify Profile"),
          //   backgroundColor: Color(0xFF79c942),
          // ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Color(0xFF79c942),
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 18, left: 20),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  // Card(
                  //   child: Container(
                  //     child:
                  //   ),
                  // ),
                  // Card(
                  //   child:

                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            showImage(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                OutlineButton(
                                  onPressed: chooseImage,
                                  child: Text("Choose Image"),
                                ),
                              ],
                            ),
                            Text(
                              status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                        // Column(
                        //   children: <Widget>[
                        //     Container(
                        //       child: IconButton(
                        //         onPressed: null,
                        //         icon: Icon(
                        //           Icons.add,
                        //           size: 45,
                        //         ),
                        //       ),
                        //     ),
                        //     Text("Add Images"),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  // ),
                  Card(
                      elevation: 20,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextFormField(
                                controller: userController,
                                decoration:
                                    InputDecoration(hintText: 'Username'),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration:
                                      InputDecoration(hintText: 'Email'),
                                )),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextFormField(
                                controller: passController,
                                decoration:
                                    InputDecoration(hintText: 'Password'),
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
                                decoration:
                                    InputDecoration(hintText: 'Website'),
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
                              onPressed: startUpload,
                              color: Color(0xFF79c942),
                              disabledColor: Color(0xFF79c942),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
