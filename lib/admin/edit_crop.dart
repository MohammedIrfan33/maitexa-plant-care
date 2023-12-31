import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/admin/admin%20crop%20desc.dart';

class EditCrop extends StatefulWidget {
  const EditCrop(
      {Key? key,
      required this.name,
      required this.scName,
      required this.orginName,
      required this.soilname,
      required this.cliHumdity,
      required this.image,
      required this.id})
      : super(key: key);

  final String name;
  final String scName;
  final String orginName;
  final String soilname;
  final String cliHumdity;

  final String image;
  final String id;

  @override
  State<EditCrop> createState() => _EditCropState();
}

class _EditCropState extends State<EditCrop> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  File? imageFile;
  File? file;
  late String storedImage;
  DocumentReference? crops;

  String imageUrl = '';
  TextEditingController cropname = TextEditingController();
  TextEditingController sciname = TextEditingController();
  TextEditingController orginname = TextEditingController();
  TextEditingController soil = TextEditingController();
  TextEditingController climate = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  updateCrop() async {
    if (crops != null) {
      await crops?.update({
        "climate": climate.text,
        "name": cropname.text,
        "orgin": orginname.text,
        "scientificname": sciname.text,
        "soil": soil.text,
     
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => cropdesc_admin()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Not Found')));
    }
  }

  @override
  void initState() {
    crops = FirebaseFirestore.instance.collection('crop').doc(widget.id);

    cropname.text = widget.name;
    climate.text = widget.cliHumdity;
    sciname.text = widget.scName;
    orginname.text = widget.orginName;
    imageUrl = widget.image;
    soil.text = widget.soilname;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crops"),
        backgroundColor: Colors.teal[900],
      ),
      body: ListView(children: [
        const SizedBox(
          height: 20,
        ),

        /* Padding(
        padding: const EdgeInsets.only(left: 50,right: 50,),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[900],
              fixedSize: Size(150, 80),
            ),
            onPressed: () async {
            */ /*  image = await picker.pickImage(source: ImageSource.gallery);
              setState(() {
                //update UI
              });*/ /*
              ImagePicker imagePicker=ImagePicker();
              XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);
              print('${file?.path}');

              String uniquename=DateTime.now().microsecondsSinceEpoch.toString();
              Reference refrenceroot = FirebaseStorage.instance.ref();
              Reference referenceDirImages=refrenceroot.child('images');

              Reference referenceImageToUpload=referenceDirImages.child(uniquename);

              try {
                await referenceImageToUpload.putFile(File(file!.path));
                imageUrl= await  referenceImageToUpload.getDownloadURL();

              }catch(error){

              }
            },
            child: Text("Pick from gallery",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
      ),
      SizedBox(height: 10,),
      image == null ? Container() : Image.file(File(image!.path)),
      Padding(
        padding: const EdgeInsets.only(bottom: 30,left: 50,right: 50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal[900],
            fixedSize: Size(150, 80),
          ),
          onPressed: () async {
          */ /*  image = await picker.pickImage(source: ImageSource.camera);
            setState(() {
              //update UI
            });*/ /*
            ImagePicker imagePicker=ImagePicker();
            XFile? file= await imagePicker.pickImage(source: ImageSource.camera);
            print('${file?.path}');

            String uniquename=DateTime.now().microsecondsSinceEpoch.toString();
            Reference refrenceroot = FirebaseStorage.instance.ref();
            Reference referenceDirImages=refrenceroot.child('images');

            Reference referenceImageToUpload=referenceDirImages.child(uniquename);

            try {
              await referenceImageToUpload.putFile(File(file!.path));
              imageUrl= await  referenceImageToUpload.getDownloadURL();

            }catch(error){

            }
          },
          child: Text("Pick from camera",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      image == null ? Container() : Image.file(File(image!.path)),*/
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: cropname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter crop name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: sciname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter scientific name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: orginname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter origin',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: soil,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter suitable soil',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: climate,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter climate and humidity',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          /* decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg.jpg')
                      )
                    ),*/
          child: imageUrl == ''
              ?  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('Upload image'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[900]),
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: const Text("Upload Image"),
                    ),
                  ],
                )
              : Column(
                  children: [
                   imageFile != null ? Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(imageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )  : Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[900]),
                      onPressed: () async {
                        await _showChoiceDialog(context);
                        setState(() {});
                      },
                      child: const Text("Change Image"),
                    ),
                  ],
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[900],
            ),
            onPressed: () async {
              if (imageFile != null) {
                String uniquename =
                    DateTime.now().microsecondsSinceEpoch.toString();
                Reference refrenceroot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = refrenceroot.child('images');

                Reference referenceImageToUpload =
                    referenceDirImages.child(uniquename);

                try {
                  await referenceImageToUpload.putFile(imageFile!);
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (error) {}
              }
              if (imageUrl != '') {
                await crops?.update({"image": imageUrl});
              }
              updateCrop();
            },
            child: Text("submit",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ),
      ]),
    );
  }

  /// Get from gallery
  Future<void> _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  /// Get from Camera
  Future<void> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }

    /*   PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      */ /*  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);*/ /*
      });
    }*/
  }
}
