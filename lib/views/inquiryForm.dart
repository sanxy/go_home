import 'package:flutter/material.dart';

class InquiryForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {


  // _make Inquiries() async{

  // }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inquiry form"),
        ),
        body: Container(
            child: Card(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text("Inquiry"),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Username'),
                  
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Email'),
                ),
                TextField(
                maxLines: 8,
                decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
              ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
