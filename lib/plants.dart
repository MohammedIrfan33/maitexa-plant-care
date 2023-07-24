import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plant_care/symptoms.dart';
import 'package:http/http.dart' as http;

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
  String predict = '';
  String description = '';
  Future<void> submitForm() async {
    var uri = Uri.parse(
        'https://a23b-117-243-136-188.ngrok-free.app/api/plant_detection'); // Replace with your API endpoint

    var request = http.MultipartRequest('POST', uri);

    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'image', imageStream, imageLength,
      filename: _filename,
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

      predict = data['class_name'].replace('\n','');

      if (predict == "Healthy") {
        description = "Healthy Leaf";
      } else if (predict == "Bacterial_spot") {
        description =
            " Copper fungicides are the most commonly recommended treatment for bacterial leaf spot. Use copper fungicide as a preventive measure after you’ve planted your seeds but before you’ve moved the plants into their permanent homes. You can use copper fungicide spray before or after a rain, but don’t treat with copper fungicide while it is raining. If you’re seeing signs of bacterial leaf spot, spray with copper fungicide for a seven- to 10-day period, then spray again for one week after plants are moved into the field Perform maintenance treatments every 10 days in dry weather and every five to seven days in rainy weather Leaf spots turn from yellow or light green to black or dark brown. Older spots are black, slightly raised, superficial and measure up to 0.3 inch (7.5 mm) in diameter. Larger leaf blotches may also occur, especially on the margins of leaves.";
      } else if (predict == "Early_blight") {
        description =
            "Tomatoes that have early blight require immediate attention before the disease takes over the plants. Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable. Both of these treatments are organiEarly blight is primarily a disease of stressed or senescing plants. Symptoms appear first on the oldest foliage. Affected leaves develop circular to angular dark brown lesions 0.12 to 0.16 inch (3–4 mm) in diameter. ";
      } else if (predict == "Late_blight") {
        description =
            "Tomatoes that have early blight require immediate attention before the disease takes over the plants. Thoroughly spray the plant (bottoms of leaves also) with Bonide Liquid Copper Fungicide concentrate or Bonide Tomato & Vegetable. Both of these treatments are organic.Leaf symptoms of late blight first appear as small, water-soaked areas that rapidly enlarge to form purple-brown, oily-appearing blotches. On the lower side of leaves, rings of grayish white mycelium and spore-forming structures may appear around the blotches.";
      } else if (predict == "Mosaic_virus") {
        description =
            "There are no cures for viral diseases such as mosaic once a plant is infected. As a result, every effort should be made to prevent the disease from entering your garden.virus symptoms consist of various leaf and plant deformities, stunting and poor growth, or yellowing or mosaic or mottling pattern in the leaves.";
      } else if (predict == "YellowLeaf__Curl_Virus") {
        description =
            "Inspect plants for whitefly infestations two times per week. If whiteflies are beginning to appear, spray with azadirachtin (Neem), pyrethrin or insecticidal soap. For more effective control, it is recommended that at least two of the above insecticides be rotated at each spraying The most obvious symptoms plants are small leaves that become yellow between the veins. The leaves also curl upwards and towards the middle of the leaf.";
      } else if (predict == "Target_Spot") {
        description =
            "Many fungicides are registered to control of target spot on tomatoes. Growers should consult regional disease management guides for recommended products. Products containing chlorothalonil, mancozeb, and copper oxychloride have been shown to provide good control of target spot in research trials The disease starts as small circular to oval dark brown to black spots on leavesA bronze or yellow appearance in single or multiple areas of a tree. Silky webs present around tree stems and leaves.";
      } else if (predict == "Spider_mites") {
        description =
            "bifenazate (Acramite): Group UN, a long residual nerve poison abamectin (Agri-Mek): Group 6, derived from a soil bacterium spirotetramat (Movento): Group 23, mainly affects immature stages spiromesifen (Oberon 2SC): Group 23, mainly affects immature stages OMRI-listed products include Small yellow or white spots on the needles or top of the tree leaves.";
      } else if (predict == "Leaf_Mold") {
        description =
            "It is a very effective anti-ageing herb since it slows... \nTomato leaf mold | UMN Extensio Leaf mold is caused by the fungus Passalora fulva (previously called Fulvia fulva or Cladosporium fulvum). It is not known to be pathogenic on any plant ";
      } else {
        description = "Invalid";
      }

      if (description == "Invalid") {
        Fluttertoast.showToast(
          msg: 'Not Found',
          backgroundColor: Colors.grey,
        );
      } else {
        Navigator.push(
            this.context,
            MaterialPageRoute(
                builder: (context) => symptoms(
                      name: predict,
                      symptm: description,
                    )));
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                        SizedBox(
                          width: 20,
                        ),
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
          ),
          Padding(
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
      setState(() {
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
