import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plant_care/symptoms.dart';
import 'package:http/http.dart'as http;


import 'home public.dart';


class plants extends StatefulWidget {
  const plants({Key? key}) : super(key: key);
  @override
  State<plants> createState() => _plantsState();
}

class _plantsState extends State<plants> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  late final _filename;
  File? imageFile;
  late String storedImage;
  String predict='';
  String description = '';
  Future<void> submitForm() async {

    var uri = Uri.parse('https://a23b-117-243-136-188.ngrok-free.app/api/plant_detection'); // Replace with your API endpoint

    var request = http.MultipartRequest('POST', uri);

    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'image',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
   // print(_filename2);
    request.files.add(multipartFile);

    final response = await request.send();
    print(response);

    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      var data = jsonResponse['data'];


      predict = data['class_name'];

      if (predict == "Tulsi") {
        description = "ulsi's broad-spectrum antimicrobial activity, which includes activity against a range of "
            "human and animal pathogens, suggests it can be used as a hand sanitizer, mouthwash and water purifier as"
            " well as in animal rearing, wound healing, the preservation of food stuffs and herbal raw materials and"
            " traveler's health";
      } else if (predict == "Curry") {
        description = "Curry leaves (Murraya koenigii) or sweet neem leaves...";
      } else if (predict == "Drumstick") {
        description = "Drumstick leaves are rich in antioxidants, such as vitamin C...";
      } else if (predict == "Mint") {
        description = "Mint leaves create a cool sensation in the mouth...";
      } else if (predict == "Mango") {
        description = "Mango leaves have antibacterial properties that help treat...";
      } else if (predict == "Lemon") {
        description = "Lemon leaves can be wrapped around seafood and meats...";
      } else if (predict == "Indian Mustard") {
        description = "May help boost immunity- Mustard leaves are loaded with...";
      } else if (predict == "Neem") {
        description = "All parts of the neem tree- leaves, flowers, seeds...";
      } else if (predict == "Jackfruit") {
        description = "It is a very effective anti-ageing herb since it slows...";
      } else if (predict == "Rasna") {
        description = "Laden with plant-based compounds that showcase strong Ushna...";
      } else {
        description = "Invalid";
      }

      if(description == "Invalid"){
        Fluttertoast.showToast(
          msg:'Not Found',
          backgroundColor: Colors.grey,
        );
      }else{

        Navigator.push(this.context, MaterialPageRoute(builder: (context)=>symptoms( name: predict, symptm: description, )));

      }








      print('Response: $responseBody');
      print('Form submitted successfully');

    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }

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
                  SizedBox(height: 10),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("capture"),
        backgroundColor: Colors.teal[900],
        leading: IconButton( onPressed: (){ Navigator.pop(
            context); }, icon:Icon(Icons. arrow_back),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "Select image to upload",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              /* decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/bg.jpg')
                        )
                      ),*/
              child: imageFile == null
                  ? Container(
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        //    _getFromGallery();
                        _showChoiceDialog(context);
                      },
                      child: Text("Upload Image"),
                    ),
                    Container(
                      height: 40.0,
                    ),
                  ],
                ),
              )
                  : Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      //    _getFromGallery();
                      _showChoiceDialog(context);

                    },
                    child: Text("Upload Image"),
                  ),
                ],
              ),
            ),
          ),   Padding(
            padding: const EdgeInsets.only(top: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[900],
              ),
              onPressed: () {
               /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => symptoms()),
                );*/
                submitForm();
              },
              child: Text("submit",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );

}

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(()  {

        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
      });
    }
  }

}
