import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_home/classes/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/async.dart';

import '../components/labelledInput.dart';

class AddProperties extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties> {
  Future<File> file;

  List user;
  String user_id, user_email;

  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  getUserDetails() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    // Map userMap = jsonDecode(shared_User.getString('user'));
    user = shared_User.getStringList('user');
    debugPrint(user.toString());
    debugPrint(user[2]);

    setState(() {
      user_id = user[0];
      user_email = user[1];
      print(user_email);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  static final String uploadEndPoint =
      'https://gohome.ng/uploadProperty_image_api.php';
  String status = '';
  String base64String;
  File tmpFile;
  String errMessage = "Error uploading Image";

  String propertyValue = "House";
  String saleOrRent = "Sale";
  String bedroom = "Bedroom";
  String yesNo = "Yes"; //Garages
  String stateValue = "Lagos"; //State
  String lgaValue = "Any LGA";

  //Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController bathCountController = TextEditingController();
  TextEditingController storeyController = TextEditingController();
  TextEditingController plotController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  List<String> features = List();
  List<Future<File>> fileList = List();
  List<File> tmpList = List();

  List bsList = [];

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  List<bool> arr_check = [for (int i = 0; i < 14; i++) false];

  setStatus(String message) {
    setState(() {
      // message.length != 0?
      // status = message.substring(0,20)
      // :
      status = message;
    });
  }

  checkValue(String val, List arr) {
    if (arr.length == 0) {
      return false;
    } else if (arr.contains(val)) {
      return true;
    } else {
      return false;
    }
  }

  List<String> fileNameList = List();
  startUpload() {
    setStatus("Uploading...");
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    // String filename;
    // for(int i = 0; i < tmpList.length; i++){
    //   filename = tmpList[i].path.split('/').last;
    //   fileNameList.add(filename);
    // }
    // upload(fileNameList);
    String filename = tmpFile.path.split('/').last;
    upload(filename);
  }

  upload(String filename) async {
    String featureToString = features.join(',');
    String body;
    String title = titleController.text;
    String desc = descController.text;
    String bath = bathCountController.text;
    String storey = storeyController.text;
    String plot = plotController.text;
    String price = priceController.text;
    String address = addressController.text;
    String zip = zipController.text;
    Map<String, String> headers = {"Content-type": "application/json"};
    String url = "https://gohome.ng/api/upload_property_data.php";
    String json =
        '{"user_id" : "${user_id}", "user_email" : "${user_email}", "title" : "${title}", "desc" : "${desc}", "type" : "${propertyValue}", "status" : "${saleOrRent}", "bedroom" : "${bedroom}", "bathroom" : "${bath}", "storey" : "${storey}", "garages" : "${yesNo}", "size" : "${plot}", "price" : "${price}", "features" : "${featureToString}", "address" : "${address}", "region" : "${lgaValue}", "state" : "${stateValue}", "zip" : "${zip}", "featured" : "0", "offered" : "0", "approved" : "no", "img1" : "${filename}"}';
    // make POST request
    print(json);
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    body = response.body;

    Success success = Success.fromJson(jsonDecode(body));
    if (success.status == "OK") {
      titleController.text = null;
      descController.text = null;
      bathCountController.text = null;
      bathCountController.text = null;
      storeyController.text = null;
      plotController.text = null;
      priceController.text = null;
      addressController.text = null;
      zipController.text = null;

      debugPrint(success.message);
      Map decode_options = jsonDecode(body);
      http.post(uploadEndPoint,
          body: {"image": base64String, "name": filename}).then((result) {
        setStatus(result.statusCode == 200 ? result.body : errMessage);
      }).catchError((error) {
        // setStatus(error.toString());
        print(error.toString());
      });
    } else {
      print('error connecting' + success.status);
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64String = base64Encode(snapshot.data.readAsBytesSync());
          // return Container(
          //   child: Text(snapshot.data.toString())
          // );
          return Flexible(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.file(
                snapshot.data,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.5,
                height: 200,
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            "Error selecting image",
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            "No image found",
            textAlign: TextAlign.center,
          );
        }
      },
    );
    //  }
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool is_checked = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Property"),
          backgroundColor: Color(0xFF79c942),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.black12,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Property Description",
                          style: TextStyle(fontSize: 25),
                        ),
                        LabelledInput(
                          controller: titleController,
                          hint: "Enter Property title",
                        ),
                        LabelledInput(
                          controller: descController,
                          hint: "Enter Property Description",
                          maxLines: 8,
                        ),
                        Text("Property Features"),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: propertyValue,
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
                                        propertyValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'House',
                                      'Office',
                                      'Store',
                                      'Land'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: saleOrRent,
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
                                        saleOrRent = newValue;
                                      });
                                    },
                                    items: <String>['Sale', 'Rent']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    value: bedroom,
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
                                        bedroom = newValue;
                                      });
                                    },
                                    items: <String>['Bedroom', '1', '2', '3']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: LabelledInput(
                            controller: bathCountController,
                            hint: "How many bathrooms",
                          ),
                        ),
                        Container(
                          child: LabelledInput(
                            controller: storeyController,
                            hint: "How many Storey",
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Garage"),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: yesNo,
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
                                    yesNo = newValue;
                                  });
                                },
                                items: <String>[
                                  'Yes',
                                  'No'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: LabelledInput(
                            controller: plotController,
                            hint: "Plots or Acres",
                          ),
                        ),
                        Container(
                          child: LabelledInput(
                            controller: priceController,
                            hint: "Sale or Rent Price",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text("Property Features",
                            style: TextStyle(fontSize: 25)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[0],
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      arr_check[0] = value;
                                      checkValue("Center cooling", features)
                                          ? features.remove("Center cooling")
                                          : features.add("Center cooling");
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Center cooling"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[1],
                                  onChanged: (bool value) {
                                    String val = "Balcony";
                                    this.setState(() {
                                      arr_check[1] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Balcony"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[2],
                                  onChanged: (bool value) {
                                    String val = "Pet Friendly";
                                    this.setState(() {
                                      arr_check[2] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Pet Friendly"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[3],
                                  onChanged: (bool value) {
                                    String val = "Fire Alarm";
                                    this.setState(() {
                                      arr_check[3] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Fire alarm"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[4],
                                  onChanged: (bool value) {
                                    String val = "Storage";
                                    this.setState(() {
                                      arr_check[4] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Storage"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[5],
                                  onChanged: (bool value) {
                                    String val = "Dryer";
                                    this.setState(() {
                                      arr_check[5] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Dryer"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[6],
                                  onChanged: (bool value) {
                                    String val = "Heating";
                                    this.setState(() {
                                      arr_check[6] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Heating"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[7],
                                  onChanged: (bool value) {
                                    String val = "Pool";
                                    this.setState(() {
                                      arr_check[7] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Pool"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[8],
                                  onChanged: (bool value) {
                                    String val = "Laundry";
                                    this.setState(() {
                                      arr_check[8] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Laundry"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[9],
                                  onChanged: (bool value) {
                                    String val = "Sauna";
                                    this.setState(() {
                                      arr_check[9] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Sauna"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[10],
                                  onChanged: (bool value) {
                                    String val = "Gym";
                                    this.setState(() {
                                      arr_check[10] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Gym"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[11],
                                  onChanged: (bool value) {
                                    String val = "Elevator";
                                    this.setState(() {
                                      arr_check[11] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Elevator"),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[12],
                                  onChanged: (bool value) {
                                    String val = "Dish washer";
                                    this.setState(() {
                                      arr_check[12] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Dish washer"),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: arr_check[13],
                                  onChanged: (bool value) {
                                    String val = "Emergency Exit";
                                    this.setState(() {
                                      arr_check[13] = value;
                                      checkValue(val, features)
                                          ? features.remove(val)
                                          : features.add(val);
                                      print(features);
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text("Emergency Exit"),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Card(
                //   child: Container(
                //     child:
                //   ),
                // ),

                OutlineButton(
                  onPressed: chooseImage,
                  child: Text("Choose Image"),
                ),
                // Card(
                //   child:

                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          showImage(),
                          SizedBox(
                            height: 20.0,
                          ),
                          // OutlineButton(
                          //   onPressed: null,
                          //   child: Text("Upload Image"),
                          // ),
                          Text(
                            // status.length > 0 ?
                            // status.substring(0,20)
                            // :
                            status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: <Widget>[
                      //     Container(
                      //       child: IconButton(
                      //         onPressed: null,
                      //         icon: Icon(
                      //           Icons.add,
                      //           size: 45,
                      //         ),
                      //       ),
                      //     ),
                      //     Text("Add Images"),
                      //   ],
                      // )
                    ],
                  ),
                ),
                // ),
                Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Property Location",
                          style: TextStyle(fontSize: 25),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              LabelledInput(
                                controller: addressController,
                                hint: "Enter Property address",
                              ),
                              DropdownButton<String>(
                                value: stateValue,
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    stateValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Lagos',
                                  'Abuja',
                                  'Imo',
                                  'Port Harcourt'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<String>(
                                value: lgaValue,
                                icon: Icon(Icons.arrow_drop_down),
                                isExpanded: true,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 0,
                                  color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    lgaValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Any LGA',
                                  '',
                                  '',
                                  ''
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              LabelledInput(
                                controller: zipController,
                                hint: "Enter the ZIP/Postal code",
                              ),
                              MaterialButton(
                                color: Color(0xFF79c942),
                                onPressed: startUpload,
                                child: Text("Submit"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
