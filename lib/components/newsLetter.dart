import 'package:flutter/material.dart';

class NewsLetter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Text("Subscribe to our news letter"),
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.only(right: 0, top: 0, bottom: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              color: Color(0xFF79c942),
              child: Container(
                padding: EdgeInsets.all(8),
                child: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
