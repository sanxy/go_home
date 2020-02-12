import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import './pills.dart';

class InspectionView extends StatelessWidget {
  final String id;
  final String amount;
  final String location;
  final String propId;
  final String state;
  final String requestQuestion;
  final String imagePath;
  final String saleOrRent;
  final String title;
  final String followUp;

  InspectionView(
      {this.id,
      this.amount,
      this.location,
      this.propId,
      this.requestQuestion,
      this.state,
      this.imagePath,
      this.saleOrRent,
      this.title,
      this.followUp,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 95,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/cus_sup.png",
                  ),
                  backgroundColor: Colors.white30,
                  foregroundColor: Colors.white38,
                  maxRadius: 30,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          title.length > 20
                              ? title.substring(0, 17) + "..."
                              : title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF79c942),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Pill("Request"),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(requestQuestion),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              followUp
                            ),
                            Pill("1"),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
