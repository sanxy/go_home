import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/notificationPill.dart';
import '../services/cityContentServices.dart';
import '../classes/property.dart';
import '../components/propertyList.dart';
import '../views/eachProperty.dart';

class NotificationsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationsTab> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  String locator;

  getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString("geoLocation");
    setState(() {
      locator = location;
    });
  }

  List<Property> properties = List();
  List<Property> filteredProperties = List();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              // if (_currentPosition != null) Text(_currentAddress),
              filteredProperties.length > 0
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredProperties.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = filteredProperties[index];
                        return NotificationPill(
                          title: item.title,
                          time: "14:35",
                          goto: EachProperty(item: item,),
                        );
                      })
                  : Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Color(0xFF79c942),
                          ),
                          Container(
                            child: Text("Fetching new notifications"),
                          )
                        ],
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF79c942),
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }

  void _getCurrentLocation() async {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
        locator = "${place.locality}";
      });
      CityContentServices.getProperties().then((propertiesFromServer) {
        setState(() {
          properties = propertiesFromServer;
          filteredProperties = properties
              .where(
                  (p) => p.state.toLowerCase().contains(locator.toLowerCase()))
              .toList();
        });
      });
      print(filteredProperties);
      print("locator1: " + locator);
    } catch (e) {
      print(e);
    }
  }
}
