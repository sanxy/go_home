import 'package:flutter/material.dart';

import '../components/propertyList.dart';

import '../views/makeRequest.dart';

class EachProperty extends StatelessWidget {
  final dynamic items;

  EachProperty({this.items});

  request() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(items["title"]),
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
                        items["prop_id"] +
                        "/" +
                        items["img1"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child:SingleChildScrollView(
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
                  ),),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      child: Text(
                        "\u20A6 " + items["amount"] + "/year",
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
                padding: EdgeInsets.all(10),
                child: Text(items["description"]),
              ),
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
                        Text(" " + items["user_email"]),
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
                                  decoration:
                                      InputDecoration(hintText: 'Username'),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Email'),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(hintText: 'Phone Number'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: TextField(
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                      hintText: "Enter your text here"),
                                ),
                              ),
                              MaterialButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Color(0xFF79c942), fontSize: 25),
                                ),
                                onPressed: null,
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
