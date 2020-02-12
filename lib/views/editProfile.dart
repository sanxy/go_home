import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
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
                        decoration: InputDecoration(hintText: 'Username'),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        decoration: InputDecoration(hintText: 'phone'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
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
                      onPressed: null,
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
