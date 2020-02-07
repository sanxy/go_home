import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network/network.dart' as network;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart';
import 'package:quiver/async.dart';
import 'dart:async';
import 'dart:io';
import '../classes/success.dart';
import '../dashboard.dart';

import 'dart:convert';

/// HTTP 400
class BadRequestException<T extends network.BinaryResponse>
    extends network.NetworkException<T> {
  BadRequestException(T response) : super(response);
}

/// HTTP 404
class NotFoundException<T extends network.BinaryResponse>
    extends network.NetworkException<T> {
  NotFoundException(T response) : super(response);
}

/// No connection to internet
class NoInternetConnection<T extends network.BinaryResponse>
    extends network.NetworkException<T> {
  NoInternetConnection(T response) : super(response);
}

class MakeRequest extends StatefulWidget {
  final String id;

  MakeRequest({this.id});

  @override
  State<StatefulWidget> createState() => _MakeRequestState(id: id);
}

class _MakeRequestState extends State<MakeRequest> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  bool isLoading = true;

  final String id;


  _MakeRequestState({this.id});

  sendMessage() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);
    String senderId = user[0].toString();

    String receiverId = id.toString();

    String body;

    String title = titleController.text;
    String message = messageController.text;

    if (title.length > 0 && message.length > 0) {
      setState(() {
        isLoading = true;
      });

      // set up POST request arguments
      String url = 'https://www.gohome.ng/send_message.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = '{"sender_id" : "${senderId}", "receiver_id" : "${receiverId}", "title" : "${title}", "message" : "${message}" }';
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("Application for House"),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
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
                controller: messageController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Message'),
              ),
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            minWidth: double.infinity,
            child: Text(
              "Request",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: sendMessage,
            color: Color(0xFF79c942),
          )
        ],
      ),
    );
  }
}
