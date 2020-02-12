import 'package:flutter/material.dart';

import '../components/notificationPill.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color(0xFF79c942),
      ),
      body: Column(
        children: <Widget>[
          NotificationPill(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF79c942),
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
