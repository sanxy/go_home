import 'package:flutter/material.dart';

import '../components/InspectionView.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        backgroundColor: Color(0xFF79c942),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text("You have 3 new messages."),
          ),
          InspectionView(
            amount: "1000",
            id: "1",
            location: "Lagos",
            propId: "123",
            requestQuestion: "Request to inspect house",
            saleOrRent: "null",
            state: "Lagos",
            title: "John Doe",
            followUp: "When sholud I come?",
          ),
          InspectionView(
            amount: "1000",
            id: "1",
            location: "Lagos",
            propId: "123",
            requestQuestion: "Request to inspect house",
            saleOrRent: "null",
            state: "Lagos",
            title: "Jane Doe",
            followUp: "I would love a rose garden.",
          ),
          InspectionView(
            amount: "1000",
            id: "1",
            location: "Lagos",
            propId: "123",
            requestQuestion: "Request to inspect house",
            saleOrRent: "null",
            state: "Lagos",
            title: "John Dee",
            followUp: "I would be free by 2pm.",
          )
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
