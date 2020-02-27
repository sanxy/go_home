import 'package:flutter/material.dart';
import 'package:go_home/components/InspectionView.dart';

class EachMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 160.0,
          backgroundColor: Color(0xFF79c942),
          flexibleSpace: FlexibleSpaceBar(
              title: Text('Message'),
              background: Image(
                image: AssetImage("assets/abuja.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
