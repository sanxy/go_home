import 'package:flutter/material.dart';


class FilterComponent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent>{

   String furnValue = "Furnished";
  String regionValue = "Any Region";
  String statusValue = "Sale";
  String bedroomValue = "Bedrooms";
  String bathroomValue = "Bathrooms";
  String minAmountValue = "Min Amount";
  String maxAmountValue = "Max Amount";

  @override
  Widget build(BuildContext context) {
    return null;
  }

  void settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Filter Property type",
                  style: TextStyle(fontSize: 30),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: regionValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        regionValue = newValue;
                      });
                    },
                    items: <String>['Any Region', 'Oyo', 'Abuja', 'Imo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: furnValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (String newValue) {
                      setState(() {
                        furnValue = newValue;
                      });
                    },
                    items: <String>['Furnished', 'Unfurnished']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(5),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: statusValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        statusValue = newValue;
                      });
                    },
                    items: <String>['Sale', 'Rent']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: bedroomValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        bedroomValue = newValue;
                      });
                    },
                    items: <String>['Bedrooms', '1', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: bathroomValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        bathroomValue = newValue;
                      });
                    },
                    items: <String>['Bathrooms', '1', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black45,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    value: minAmountValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        minAmountValue = newValue;
                      });
                    },
                    items: <String>['Min Amount', '1,000', '10,000', '100,000']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black45,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.all(5),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: maxAmountValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    underline: Container(
                      height: 0,
                      color: Colors.black,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        maxAmountValue = newValue;
                      });
                    },
                    items: <String>['Max Amount', '1,000', '10,000', '100,000']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                MaterialButton(
                  onPressed: null,
                  child: Text("Apply Filter"),
                  color: Color(0xFF79c942),
                )
              ],
            ))),
          );
        });
  }

}