import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/details.dart';
class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text("Upload"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ))),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(child: Text("Upload your Crop Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[900],
              ),
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  //update UI
                });
              },
              child: Text("Pick from gallery",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            image == null ? Container() : Image.file(File(image!.path)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[900],
              ),
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.camera);
                setState(() {
                  //update UI
                });
              },
              child: Text("Pick from camera",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            image == null ? Container() : Image.file(File(image!.path)),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal[900],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => details()),
                  );
                },
                child: Text("submit",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            image == null ? Container() : Image.file(File(image!.path)),
          ]),
    );

  }
}
