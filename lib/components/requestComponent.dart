import 'package:flutter/material.dart';
import 'package:go_home/components/pills.dart';

class RequestComponent extends StatelessWidget {
  final String propTitle;
  final String location;
  final String propId;
  final String imagePath;

  RequestComponent(
      {this.propTitle, this.location, this.propId, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                child: FadeInImage.assetNetwork(
                  height: 100,
                  placeholder: "assets/person.png",
                  image: "http://gohome.ng/assets/upload/" +
                      propId +
                      "/" +
                      imagePath,
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      propTitle.length > 30
                          ? propTitle.substring(0, 30) + "..."
                          : propTitle,
                      style: TextStyle(
                          color: Color(
                            0xFF79c942,
                          ),
                          fontSize: 18),
                    ),
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                      left: 10,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              Text(location),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Pill("7"),
                              Text("requests"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
