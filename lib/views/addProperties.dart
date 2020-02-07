import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProperties extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AddPropertiesState();
}

class _AddPropertiesState extends State<AddProperties>{

  Future<File> file;

  static final String uploadEndPoint = 'https://gohome.ng/uploadProperty.php';
  String status = '';
  String base64String;
  File tmpFile;
  String errMessage = "Error uploading Image";

  chooseImage(){
    setState((){
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  setStatus(String message) {
    setState(() {
     status = message; 
    });
  }

  startUpload(){
    setStatus("Uploading...");
    if(null == tmpFile){
      setStatus(errMessage);
      return;
    }
    String filename = tmpFile.path.split('/').last;
    upload(filename);
  }

  upload(String filename){
    http.post(uploadEndPoint, body: {
      "image": base64String,
      "name": filename
    }).then((result){
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error){
      setStatus(error);
    });
  }

  Widget showImage(){
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot){
        if (snapshot.connectionState == ConnectionState.done && null !=snapshot.data){
          tmpFile =snapshot.data;
          base64String = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(snapshot.data,
            fit: BoxFit.fill,
            ),
          );
        }else if (null != snapshot.error){
          return const Text(
            "Error selecting image",
            textAlign: TextAlign.center,
          );
        }else{
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Properties"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              OutlineButton(
                onPressed: chooseImage,
                child: Text("Choose Image"),
              ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

}