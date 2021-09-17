import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  var _image;
  var _output;

  ditectimage(String path) async {
    var output = await Tflite.runModelOnImage(
      path: path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadmodel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickimage() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = image;
    });
    ditectimage(image.path);
  }

  pickgallaryimage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = image;
    });
    ditectimage(image.path);
  }

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: GestureDetector(
                onTap: () => pickimage(),
                child: Text('take picture'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => pickgallaryimage(),
                child: Text('take picture'),
              ),
            ),
            Center(
              child: _loading
                  ? Container(
                      child: Center(
                        child: Text('Hi'),
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 250,
                            child: _image != null
                                ? Image.file(File(_image.path))
                                : Container(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Text('${_output[0]['label']}')
                              : Container(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
