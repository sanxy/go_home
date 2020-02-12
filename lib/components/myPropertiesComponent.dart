import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import './pills.dart';

class MyPropertiesComponent extends StatelessWidget {
  final String id;
  final String amount;
  final String location;
  final String propId;
  final String state;
  final String region;
  final String imagePath;
  final String saleOrRent;
  final String title;

  MyPropertiesComponent(
      {this.id,
      this.amount,
      this.location,
      this.propId,
      this.region,
      this.state,
      this.imagePath,
      this.saleOrRent,
      this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 180,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            // Image(
            //   image: CachedNetworkImageProvider("http://gohome.ng/assets/upload/" + propId + "/" + imagePath,),
            //   fit: BoxFit.cover,
            //   width:MediaQuery.of(context).size.width * 0.4,
            // ),
            Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: "http://gohome.ng/assets/upload/" +
                      propId +
                      "/" +
                      imagePath,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Pill("For " + saleOrRent),
                          ),
                          Container(
                            child: Icon(
                            Icons.share,
                            color: Colors.cyan,
                          ),
                          )
                        ],
                      ),
                      
                      ),
                      
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
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "\u20A6 " + amount,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(region + ", " + state),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            Text(
                              location.length > 20
                                  ? location.substring(0, 20) + "..."
                                  : location,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Color(0xFF79c942),
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Edit Property",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.home,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("View Details"),
                      )
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
