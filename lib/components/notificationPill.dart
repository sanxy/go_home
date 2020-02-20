import 'package:flutter/material.dart';

import '../components/notificationPill.dart';

class NotificationPill extends StatelessWidget {

  final String title;
  final String time;
  final Widget goto;

  NotificationPill({this.title, this.time, this.goto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      color: Colors.black12,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => goto),
                    );
                  },
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
              Flexible(
                child: Text(title.length > 30 ? title.substring(0,30) + "\n" + title.substring(31,60): title, overflow: TextOverflow.visible, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
              ),              
              Text("Check recommendations for you!"),
              Text(time, style: TextStyle(fontWeight: FontWeight.w300),)
            ],
          ),
          )
        ],
      ),
      ),
      
      
    );
  }
}
