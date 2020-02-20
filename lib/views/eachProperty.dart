import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network/network.dart' as network;
import 'package:http/http.dart';
import 'dart:convert';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/propertyList.dart';

import '../views/makeRequest.dart';
import '../classes/property.dart';
import '../classes/success.dart';

class EachProperty extends StatefulWidget {
  final Property item;
  EachProperty({this.item});

  @override
  State<StatefulWidget> createState() => _EachPropertyState(item: item);
}

class _EachPropertyState extends State<EachProperty> {
  // GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  final Property item;

  _EachPropertyState({this.item});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  sendMessage() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);
    String senderId = user[0].toString();

    String receiverId = item.id;

    String body;

    String title = "Request to view property";
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String message = messageController.text;

    if (title.length > 0 && message.length > 0) {
      setState(() {
        // isLoading = true;
      });

      // set up POST request arguments
      String url = 'https://www.gohome.ng/send_message.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String json =
          '{"sender_id" : "${senderId}", "receiver_id" : "${receiverId}", "name" : "${name}", "email" : "${email}", "phone_no" : "${phone}", "title" : "${title}", "message" : "${message}" }';
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
        // setState(() {
        //   isLoading = false;
        // });
      }
      // debugPrint(user.toString());
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Color(0xFF79c942),
        elevation: 0,
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.shopping_cart,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MakeRequest(
          //           id: items["id"],
          //         ),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("http://gohome.ng/assets/upload/" +
                        item.prop_id +
                        "/" +
                        item.img1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bul2.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bul4.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bul2_clear.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bul4.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/bul2.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Text(
                        "\u20A6 " + item.amount + "/year",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFF79c942),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10), child: Text(item.description)),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Color(0xFF79c942),
                        ),
                        Text(" 08023456780"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color: Color(0xFF79c942),
                        ),
                        Text(" " + item.user_email),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Make a request",
                                style: TextStyle(fontSize: 20),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  controller: nameController,
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
                                  controller: phoneController,
                                  decoration:
                                      InputDecoration(hintText: 'Phone Number'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: TextField(
                                  controller: messageController,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                      hintText: "Enter your text here"),
                                ),
                              ),
                              MaterialButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                onPressed: () {
                                  sendMessage();
                                },
                                color: Color(0xFF79c942),
                              ),
                              // MaterialButton(
                              //   padding: EdgeInsets.all(15),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(20),
                              //     ),
                              //   ),
                              //   child: Text(
                              //     "Send",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   onPressed: null,
                              //   color: Color(0xFF79c942),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // //Map goes here
              // Container(
              //   child: GoogleMap(
              //     onMapCreated: _onMapCreated,
              //     initialCameraPosition: CameraPosition(
              //       target: _center,
              //       zoom: 11.0,
              //     ),
              //   ),
              // ),
              Container(
                child: Text("Nearby areas"),
                margin: EdgeInsets.only(bottom: 10),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/property_location.jpg"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("Property location")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/gym.png"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("Gym")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/school.png"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("School")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/hospital.png"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("Hospitals")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/eatery.png"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("Eatery")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/hotel.png"),
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                            Text("Hotel")
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
