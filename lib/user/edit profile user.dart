import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homepage user.dart';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  String userId = '';
  User? user;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();

  bool isLoading = false;
  void fetchUserData() {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;
    FirebaseFirestore.instance
        .collection('user_Tb')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        String fullname = data['fullname'] as String;
        String phone = data['phone'] as String;
        //String email=data['email']as String;
        // _emailcontroller.text=email;
        _namecontroller.text = fullname;
        _phonecontroller.text = phone;
      } else {
        print('User document does not exist');
      }
    }).catchError((error) {
      print('Failed to fetch user data: $error');
    });
  }

  updateUserData(String fullname, String phone) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('user_Tb').doc(userId).update({
      'fullname': fullname,
      'phone': phone,
    }).then((value) {
      Fluttertoast.showToast(
        msg: "User data updated successfully!",
        backgroundColor: Colors.grey,
      );
      setState(() {
        isLoading = true;
      });
    }).catchError((error) {});

    setState(() {
      isLoading = false;
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
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
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
                  height: 25,
                ),
                Column(
                  children: [
                    /*      Padding(
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
                    child:*/ /* TextField(
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
                    ),*/ /*
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        labelText: 'phone',
                      ),
                    ),
                  ),*/
                    SizedBox(
                      height: 10,
                    ),

                    /* Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                        labelText: 'Confirm password',
                      ),
                    ),
                  ),*/
                    const SizedBox(
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
                        );
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
