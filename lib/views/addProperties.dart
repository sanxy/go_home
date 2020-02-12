import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../components/labelledInput.dart';

class AddProperties extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties> {
  Future<File> file;

  static final String uploadEndPoint = 'https://gohome.ng/uploadProperty.php';
  String status = '';
  String base64String;
  File tmpFile;
  String errMessage = "Error uploading Image";

  String dropdownValue = "House";
  String dropdownStatus = "Sale";
  String bedroom = "Bedroom";
  String yesNo = "Yes";
  String stateValue = "Lagos";
  String lgaValue = "Any LGA";

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus("Uploading...");
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String filename = tmpFile.path.split('/').last;
    upload(filename);
  }

  upload(String filename) {
    http.post(uploadEndPoint,
        body: {"image": base64String, "name": filename}).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64String = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
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
                          hint: "Enter Property title",
                        ),
                        LabelledInput(
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
                                    value: dropdownValue,
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
                                        dropdownValue = newValue;
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
                                    value: dropdownStatus,
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
                                        dropdownStatus = newValue;
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
                            hint: "How many bathrooms",
                          ),
                        ),
                        Container(
                          child: LabelledInput(
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
                            hint: "Plots or Acres",
                          ),
                        ),
                        Container(
                          child: LabelledInput(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: Color(0xFF79c942),
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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
                                  value: is_checked,
                                  onChanged: (bool value) {
                                    this.setState(() {
                                      is_checked = value;
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

                // OutlineButton(
                //   onPressed: chooseImage,
                //   child: Text("Choose Image"),
                // ),
                Card(
                  child: Container(
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
                            OutlineButton(
                              onPressed: startUpload,
                              child: Text("Upload Image"),
                            ),
                            Text(
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
                        Column(
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.add,
                                  size: 45,
                                ),
                              ),
                            ),
                            Text("Add Images"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
                                hint: "Enter the ZIP/Postal code",
                              ),
                              MaterialButton(
                                onPressed: null,
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
