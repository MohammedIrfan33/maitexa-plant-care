import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:plant_care/admin/homeadmin.dart';
import 'package:plant_care/agriculture%20department/homeagri.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/user/homepage%20user.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  get user => _auth.currentUser;

//SIGN UP METHOD
  Future<String?> signUp({required String email, required String password,required String name,required String phone,}) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user=result.user;
      await _db.collection('user_Tb').doc(user!.uid).set({
        'fullname': name,
        'phone': phone,
        'isAccepted':false,
        'isRejected':true,
        'status':''

      });
      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"user",
        'isAccepted' : false
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String?> Signupagri({required String email, required String password,required String name,required String location,required String phone}) async {
    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user=result.user;
      await _db.collection('agriculture').doc(user!.uid).set({
        'name': name,
        'phone': phone,
        'location':location,
        'isAccepted':false,
        'isRejected':true,
        'status':''

      });
      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"agriculture",
        'isAccepted': false,
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
/*
  Future<String?> Signupadmin({required String email, required String password,}) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("user data${user}");
      await _db.collection('login').doc(user!.uid).set({
        'email': email,
        'password': password,
        'role':"admin",
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
*/


  Future<void> signIn(String email, String password) async {
    try {
      // Authenticate user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Get the user's ID
      String userId = userCredential.user!.uid;
      print("userid$userId");

      // Retrieve the user's role from the Firestore collection
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('login')
          .doc(userId)
          .get();

      // Check if the document exists and retrieve the 'role' field
      if (snapshot.exists  ) {
        Map<String, dynamic>? userData =
        snapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData['role'] != null) {
         String role = userData['role'] as String;
          print("role$role");


          if (role == 'user') {
            Navigator.pushReplacement(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => ho2(),
              ),
            );
          } else if (role == 'agriculture') {
            Navigator.pushReplacement(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) =>Homeagri (),
              ),
            );
          } else if (role == 'admin') {
            Navigator.pushReplacement(
              context as BuildContext,
              MaterialPageRoute(
                builder: (context) => Homeadmin(),
              ),
            );
          } else {
            final snackBar = SnackBar(
              content: Text("Something wronng".toString()),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);

            // Unknown role, handle appropriately
            print('Unknown role');
          }
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
            content: Text(
              "Document exists, but data is null",
              style: TextStyle(fontSize: 16),
            ),
          ));
          // Document exists, but data is null
        }
      } else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
          content: Text(
            "Document doesn't exist, handle appropriately",
            style: TextStyle(fontSize: 16),
          ),
        ));
        // Document doesn't exist, handle appropriately
      }
    } catch (e) {
      // Error occurred during login
      print('Login error: $e');
      // Handle error
    }
  }
//read
   read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await   _db.collection('user_Tb').doc(user!.uid).get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }


  //SIGN OUT METHOD
  Future<void> signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
