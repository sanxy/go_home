import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'dart:async';
import 'dart:convert';

import '../components/labelledInput.dart';
import '../classes/success.dart';

class InquiryForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  int _start = 3;
  int _current = 3;

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
  bool isSuccess = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  _makeInquiries() async {
    String username = usernameController.text;
    String email = emailController.text;
    String message = messageController.text;

    isLoading =true;

    String body;

    // set up POST request arguments
    String url = 'https://www.gohome.ng/send_mail_api.php';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{"headers" : "${username}", "email" : "${email}", "message" : "${message}"}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    body = response.body;

    print(body);

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
       showSimpleCustomDialog(context, "Success", "Message sent successfully");

       usernameController.text = "";
       emailController.text = "";
       messageController.text = "";
      
      setState(() {
        isLoading = false;
        isSuccess = true;
      });
    } else {
      showSimpleCustomDialog(context, "Error", "Message not sent");
      print('error connecting' + success.status);
    }
    // debugPrint(user.toString());
  }

  void showSimpleCustomDialog(BuildContext context, String messageHead, String messageBody) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      messageHead,
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        messageBody,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color(0xFF79c942), fontSize: 20),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel!',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
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
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
    // _showSnackBar() {
    //   final snackBar = new SnackBar(
    //     content: new Text("Show snackBar"),
    //     duration: new Duration(seconds: 3),
    //   );
    //   _scaffold.currentState.showSnackBar(snackBar);
    // }

    return Scaffold(
      // key: _scaffold,
      appBar: AppBar(
        backgroundColor: Color(0xFF79c942),
        title: Text("Inquiry form"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                LabelledInput(
                  hint: "Username",
                  controller: usernameController,
                ),
                LabelledInput(
                  hint: "Email",
                  controller: emailController,
                ),
                LabelledInput(
                  hint: "Enter your message here",
                  maxLines: 8,
                  controller: messageController,
                ),
                SizedBox(
                  height: 20,
                ),
                !isLoading && _current > 0 ?
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () {
                    _makeInquiries();
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Color(0xFF79c942),
                )
                :
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
