import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/agriculture%20department/homeagri.dart';

class editagri extends StatefulWidget {
  const editagri({Key? key}) : super(key: key);

  @override
  State<editagri> createState() => _editagriState();
}

class _editagriState extends State<editagri> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  String userid = "";
  String userId = '';
  User? user;

  bool isLoading = false;

  void loadCurrentUserDetails() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      userid = user.uid ?? '';
      _emailcontroller.text = user.email ?? '';
      _namecontroller.text = user.displayName ?? '';
      _phonecontroller.text = user.phoneNumber ?? '';
      //  locationcontroller.text=user.location??'';
    }
  }

  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance
        .collection('agriculture')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          String fullname = data['name'] as String;
          String phone = data['phone'] as String;
          String location = data['location'] as String;

          _namecontroller.text = fullname;
          _phonecontroller.text = phone;
          locationcontroller.text = location;
          print('Fullname: $fullname');
          print('Place: $phone');
        });
      } else {
        print('User document does not exist');
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  updateUserData(String fullname, String phn, String location) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('agriculture')
        .doc(userId)
        .update({'name': fullname, 'phone': phn, 'location': location}).then(
            (value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrongs'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text("Edit"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 10),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: AssetImage("images/acc.png"),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: [
                    /*   Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                 SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    // child: const TextField(obscureText: true,decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'password',),),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                        labelText: 'password',
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                                  () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        alignLabelWithHint: false,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),*/
                    /* SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                        labelText: 'Confirm password',
                      ),
                    ),
                  ),*/
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: _namecontroller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          border: OutlineInputBorder(),
                          labelText: 'Full Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: locationcontroller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                          labelText: 'Location',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: _phonecontroller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          labelText: 'Phone',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        updateUserData(
                            _namecontroller.text.trim(),
                            _phonecontroller.text.trim(),
                            locationcontroller.text.trim());
                      },
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
              ]));
  }
}
