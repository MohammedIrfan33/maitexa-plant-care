import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/firebase/authentication.dart';




class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget> [
          // logo
          const Padding(
            padding: EdgeInsets.only(top:50),
            child: Text(
              'Join PlantCare Community',
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Padding(
            padding:  EdgeInsets.only(bottom: 30),
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
              const  Padding(
                padding:  EdgeInsets.only(left: 50),
                child: Text('Already here  ?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(' Get Logged in Now!',
                    style: TextStyle(fontSize: 18, color: Colors.green)),
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
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  String? email;
  String? password;
  String? confirm;
  String? name;
  String? phone;
  bool _obscureText = false;

  bool agree = false;

  bool isLoading = false;

  final pass = new TextEditingController();
  bool validatePassword(String password) {
    // Define a regular expression pattern to match at least six characters
    RegExp regex = RegExp(r'^.{6,}$');

    // Check if the password matches the pattern
    return regex.hasMatch(password);
  }

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a phone number.';
    }

    // Remove any non-digit characters from the phone number
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Check if the cleaned phone number has exactly 10 digits
    if (cleanedPhoneNumber.length != 10) {
      return 'Phone number must have 10 digits.';
    }

    return null; // Return null if the phone number is valid
  }
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

            onSaved: (val) {
              email = val;
            },
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
                
              } else {
                
              }
              if (value!.isEmpty) {
                return 'Please enter some text';
              } else if(value.length<6){
                return 'Password too short';
              }
              return null;
            },
          ),
          space,
          // confirm passwords
          TextFormField(

            validator: (value) {
              if(passwordController.text != value){
                return 'Password doesn\'t match';
              }
            },
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
            ),onSaved: (val) {
           if(passwordController.text == val)
           {

             confirm  = val;
           }
           },


            obscureText: true,
            /*  validator: (value) {
              if (value != pass.text) {
                return 'password not match';
              }
              return null;
            },*/
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
            validator:validatePhoneNumber,
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'phone',
              prefixIcon: Icon(Icons.phone),
              border: border,
            ),
            onSaved: (val) {
              phone = val;
            },
          ),
          SizedBox(height: 10,),
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
            height: 20,
          ),

          // signUP button
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()  async {



                if(_formKey.currentState!.validate()){
                  setState(() {
                    isLoading = true;
                  });
                 await  AuthenticationHelper()
                      .signUp(email: emailController.text, password:passwordController.text, name:nameController.text, phone:phoneController.text)
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

                }else{

                  setState(() {
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Some fields are not valid')));

                }

              },
              style: ElevatedButton.styleFrom(primary: Colors.teal[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)))),
              child: isLoading == true ?  CircularProgressIndicator()   :  Text('Sign Up',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

