import 'package:flutter/material.dart';


class NoInternet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
                    "assets/noInternet.gif",
                    height: MediaQuery.of(context).size.height,
                  )
          ],
        ),
      ),
    );
  }

}