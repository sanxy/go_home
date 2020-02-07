import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  
  final String text;

  Pill(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF79c942),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.all(3),
      ),
    );
  }
}
