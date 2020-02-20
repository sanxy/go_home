import 'package:flutter/material.dart';
import 'package:go_home/services/salesServices.dart';
import 'dart:async';
import '../services/rentServices.dart';
import '../classes/property.dart';
import '../components/propertyList.dart';
import 'eachProperty.dart';

class SaleHouses extends StatefulWidget {
  SaleHouses() : super();

  @override
  State<StatefulWidget> createState() => _SaleHousesState();
}

class _SaleHousesState extends State<SaleHouses> {
  List<Property> properties = List();
  List<Property> filteredProperties = List();

  String typeValue = "House";
  String furnValue = "Furnished";
  String regionValue = "Any Region";
  String statusValue = "Sale";
  String bedroomValue = "Bedrooms";
  String bathroomValue = "Bathrooms";
  String minAmountValue = "Min Amount";
  String maxAmountValue = "Max Amount";

  String number = "5";

  bool isButtonDisabled;
  bool isInitFilter;


  @override
  void initState() {
    super.initState();
    isButtonDisabled = true;
    SalesServices.getProperties().then((propertiesFromServer) {
      setState(() {
        properties = propertiesFromServer;
        filteredProperties = properties;
        print(properties);
      });
    });
  }

  void filter() {
    setState(() {
      filteredProperties = properties
          .where((p) =>
              p.state.toLowerCase().contains(regionValue.toLowerCase()) &&
              p.propType.toLowerCase().contains(typeValue.toLowerCase()) &&
              p.status.toLowerCase().contains(statusValue.toLowerCase()) &&
              p.bedroom.contains(bedroomValue) && 
              // int.parse(p.bathroom) == int.parse(bathroomValue)
              p.bathroom.contains(bathroomValue) &&
              int.parse(p.amount) > int.parse(minAmountValue) &&
              int.parse(p.amount) < int.parse(maxAmountValue))
          .toList();
    });
  }

  Future<void> refresh() async {
    setState(() {
      filteredProperties = properties;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Properties for Sale"),
        backgroundColor: Color(0xFF79c942),
        key: GlobalKey(debugLabel: "sca"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: <Widget>[
            Container(
                child: Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: MaterialButton(
                  disabledColor: Colors.grey,
                  color: Colors.white,
                  elevation: 0,
                  key: GlobalKey(debugLabel: "sca"),
                  onPressed: () {
                    setState(() {
                      _settingModalBottomSheet(context);
                    });
                    print(filteredProperties);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.filter_list),
                      Text(
                        "Filter",
                        style: TextStyle(
                          color: Color(0xFF79c942),
                        ),
                      ),
                    ],
                  )),
            )),
            filteredProperties.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: filteredProperties.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = filteredProperties[index];
                        return PropertyList(
                          amount: filteredProperties[index].amount,
                          imagePath: filteredProperties[index].img1,
                          location: filteredProperties[index].address,
                          propId: filteredProperties[index].prop_id,
                          region: filteredProperties[index].region,
                          saleOrRent: filteredProperties[index].status,
                          title: filteredProperties[index].title,
                          phone: filteredProperties[index].phone,
                          state: filteredProperties[index].state,
                          name: filteredProperties[index].name,
                          email: filteredProperties[index].user_email,
                          goto: EachProperty(
                            item: item,
                          ),
                        );
                      },
                    ),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Color(0xFF79c942),
                  ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    print(typeValue);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                            items: <String>[
                              'Any Region',
                              'Lagos',
                              'Oyo',
                              'Abuja',
                              'Imo'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                            value: typeValue,
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
                                typeValue = newValue;
                              });
                            },
                            items: <String>['House', 'Office', 'Store', 'Land']
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(5),
                          child: DropdownButton<String>(
                            isExpanded: true,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(5),
                          child: DropdownButton<String>(
                            isExpanded: true,
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
                            items: <String>[
                              'Min Amount',
                              '0',
                              '10000',
                              '100000'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                            items: <String>[
                              'Max Amount',
                              '1000',
                              '10000',
                              '100000'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              maxAmountValue = newValue;
                              setState(() {
                                maxAmountValue = newValue;
                              });
                            },
                          ),
                        ),
                        MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            // setState(() {
                            //   filteredProperties = properties
                            //       .where((p) => p.amount.contains("5"))
                            //       .toList();
                            // });
                            setState(() {
                              isButtonDisabled = false;
                              number = "3";
                            });
                            Navigator.pop(context);
                            filter();
                          },
                          child: Text(
                            "Apply Filter",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color(0xFF79c942),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}

class isButtonDisabled {}
