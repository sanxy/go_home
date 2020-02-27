import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TestPicker extends StatefulWidget {
  @override
  _TestPickerState createState() => _TestPickerState();
}

class _TestPickerState extends State<TestPicker> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future<void> retrieveLostData() async {
  final LostDataResponse response =
      await ImagePicker.retrieveLostData();
  if (response == null) {
    return;
  }
  if (response.file != null) {
    setState(() {
      if (response.type == RetrieveType.video) {
        // _handleVideo(response.file);
      } else {
        // _handleImage(response.file);
      }
    });
  } else {
    // _handleError(response.exception);
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveLostData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}