import 'package:flutter/material.dart';

class ProfileComponents extends StatelessWidget{
  final IconData listIcon;
  final String listText;
  final Color clr;

  ProfileComponents({this.listIcon, this.listText, this.clr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: clr,
      padding: EdgeInsets.all(5),
      child:Row(
        children: <Widget>[
          // Icon(
          //   listIcon,
          //   color: Color(0xFF79c942),
          //   size: 30,
          // ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(listText, style: TextStyle(fontSize: 17),),
          )
        ],
      )
    );
  }

}