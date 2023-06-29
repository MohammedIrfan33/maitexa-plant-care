import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/firebase/authentication.dart';

class Signupagri extends StatelessWidget {
  const Signupagri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // logo
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Join PlantCare Community',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Create Your Account',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),

          Row(
            children: <Widget>[
              Text('Already here  ?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(' Get Logged in Now!',
                    style: TextStyle(fontSize: 20, color: Colors.green)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool validatePassword(String password) {
    // Define a regular expression pattern to match at least six characters
    RegExp regex = RegExp(r'^.{6,}$');

    // Check if the password matches the pattern
    return regex.hasMatch(password);
  }

  String? email;
  String? password;
  String? confirm;
  String? phone;
  String? name;
  String? location;
  bool _obscureText = false;

  bool agree = false;

  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    );

    var space = const SizedBox(height: 20);

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

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            validator: (valueMail) {
              if (valueMail!.isEmpty) {
                return 'Please enter Email Id';
              }
              RegExp email = new RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
              if (email.hasMatch(valueMail)) {
                return null;
              } else {
                return 'Invalid Email Id';
              }
            },
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: border),
          ),

          space,

          // password
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            obscureText: !_obscureText,
            validator: (value) {
              if (validatePassword(value!)) {
                print('Password is valid!');
              } else {
                print('Password should have at least six characters.');
              }
              if (value!.isEmpty) {
                return 'Please enter some text';
              } else if (value.length < 6) {
                return 'Password too short';
              }
              return null;
            },
          ),
          space,
          // confirm passwords
          TextFormField(
            validator: (value) {
              if (passwordController.text != value) {
                return 'Password doesn\'t match';
              }
            },
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
            ),
            obscureText: true,
          ),
          space,
          // name
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.account_circle),
              border: border,
            ),
            onSaved: (val) {
              name = val;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some name';
              }
              return null;
            },
          ),
          space,
          TextFormField(
            controller: locationController,
            decoration: InputDecoration(
              labelText: ' location',
              prefixIcon: Icon(Icons.location_on),
              border: border,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
          ),
          space,
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Mobile Number';
              }
              RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
              if (number.hasMatch(value)) {
                return null;
              } else {
                return 'Invalid Mobile Number';
              }
            },
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
              labelText: ' phone',
              prefixIcon: const Icon(Icons.phone),
              border: border,
            ),
            onSaved: (val) {
              phone = val;
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            /* decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg.jpg')
                      )
                    ),*/
            child: imageFile == null
                ? Row(
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
                      Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(imageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[900]),
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                        child: const Text("Change Image"),
                      ),
                    ],
                  ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                onChanged: (_) {
                  setState(() {
                    agree = !agree;
                  });
                },
                value: agree,
              ),
              const Flexible(
                child: Text(
                    'By creating account, I agree to Terms & Conditions and Privacy Policy.'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          // signUP button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {

                setState(() {
                    isLoading = true;
                  });
                String uniquename =
                    DateTime.now().microsecondsSinceEpoch.toString();
                Reference refrenceroot =  FirebaseStorage.instance.ref();
                Reference referenceDirImages = refrenceroot.child('images');

                Reference referenceImageToUpload =
                    referenceDirImages.child(uniquename);

                    

                try {
                  await referenceImageToUpload.putFile(File(imageFile!.path));
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (error) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image not uploaded')));
                }
                if (_formKey.currentState!.validate() && imageUrl != null) {
                  
                  await AuthenticationHelper()
                      .Signupagri(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          location: locationController.text,
                          phone: phoneController.text,
                          imageUrl: imageUrl)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });

                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Something went wrong')));

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Some fields are not valid')));
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[900],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  File? imageFile;
  File? file;
  String? imageUrl;

  /// Get from gallery
  Future<void> _getFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print('gallerypath${file?.path}');

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  /// Get from Camera
  Future<void> _getFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
    String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference refrenceroot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = refrenceroot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniquename);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {}
  }
}
