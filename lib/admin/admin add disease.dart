import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class disease extends StatefulWidget {
  const disease({Key? key}) : super(key: key);

  @override
  State<disease> createState() => _diseaseState();
}

class _diseaseState extends State<disease> {
  TextEditingController syptom = TextEditingController();
  TextEditingController treatment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deseise"),
        backgroundColor: Colors.teal[900],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: syptom,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter symptoms',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            controller: treatment,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter treatment',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[900],
            ),
            onPressed: () {
              FirebaseFirestore.instance.collection("disease").add({
                "symptoms": syptom.text,
                "treatment": treatment.text,
              }).then((value) {
                print(value.id);
                Navigator.pop(context);
              }).catchError(
                  (error) => print("failed to add new booking $error"));
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
}
