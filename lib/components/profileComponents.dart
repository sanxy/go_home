import 'package:flutter/material.dart';

class ProfileComponents extends StatelessWidget{
  final IconData listIcon;
  final String listText;

  ProfileComponents({this.listIcon, this.listText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
      padding: EdgeInsets.all(5),
      child:Row(
        children: <Widget>[
          Icon(
            listIcon,
            color: Color(0xFF79c942),
            size: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(listText, style: TextStyle(fontSize: 20),),
          )
        ],
      )
    ),
    );
  }

}