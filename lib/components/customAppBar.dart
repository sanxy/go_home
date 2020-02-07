import 'package:flutter/material.dart';

import '../search.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 0,
              left: 20,
              right: 0,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/gohome.png'),
                  width: 100,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                        ),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.person,
                        ),
                        onPressed: () {
                          Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) =>  Search()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

