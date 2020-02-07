import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String label;
  final String imageLink;
  final Widget widget;

  ImageButton({this.label, this.imageLink, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage(imageLink),
              width: 70,
              height: 80,
            ),
            Center(
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }
}
