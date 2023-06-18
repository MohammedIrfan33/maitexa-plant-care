import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/firebase/authentication.dart';

import 'homeagri.dart';

class Signupagri extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // logo
          Column(
            children: [
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Already here  ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(' Get Logged in Now!',
                          style: TextStyle(fontSize: 20, color: Colors.green)),
                    )
                  ],
                )
              ],
            ),
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
  SignupForm({Key? key}) : super(key: key);

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
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 20);
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
              prefixIcon: Icon(Icons.phone),
              border: border,
            ),
            onSaved: (val) {
              phone = val;
            },
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
              Flexible(
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
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  await AuthenticationHelper()
                      .Signupagri(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                          location: locationController.text,
                          phone: phoneController.text)
                      .then((result) {
                    if (result == null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 16),
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

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Some fields are not valid')));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: isLoading ? CircularProgressIndicator() :   Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
