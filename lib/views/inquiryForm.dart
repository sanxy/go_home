import 'package:flutter/material.dart';

import '../components/labelledInput.dart';

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
          backgroundColor: Color(0xFF79c942),
          title: Text("Inquiry form"),
        ),
        body: Container(
            child: Card(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text("Inquiry"),
                LabelledInput(hint: "Username",),
                LabelledInput(hint: "Email",),
                LabelledInput(hint: "Enter your message here", maxLines: 8,),
                MaterialButton(
                  onPressed: null,
                  child: Text("Submit"),
                  color: Color(0xFF79c942),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
