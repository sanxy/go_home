import 'package:flutter/material.dart';

class LabelledInput extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  LabelledInput({this.label, this.hint, this.maxLines, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Text(label, textAlign: TextAlign.start,),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,              
            ),
            maxLines: maxLines,
          )
        ],
      ),
    );
  }
}
