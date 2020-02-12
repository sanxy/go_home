import 'package:flutter/material.dart';

import '../components/notificationPill.dart';

class NotificationPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/bul2_clear.jpg",
            ),
            backgroundColor: Colors.white30,
            foregroundColor: Colors.white38,
            maxRadius: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Attractive 4-Storey building at Gwarinpa", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
              Text("Check recommendations for you!"),
              Text("16:43 on Feb 10, 2020", style: TextStyle(fontWeight: FontWeight.w300),)
            ],
          ),
          )
        ],
      ),
    );
  }
}
