import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class message extends StatefulWidget {
  const message({Key? key}) : super(key: key);

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  String date= DateTime.now().toString();
  TextEditingController msgcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[100],
          title: Text("Messages",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey, Colors.green]),
            ),
          ),
        ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller:msgcontroller,
                  maxLines:3,
                  decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    hintText: 'Type Here',

                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 50, left: 130, right: 130),
                child: Container(
                  //color:Colors.greenAccent ,
                  width: double.maxFinite,
                  height: 39,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.teal[900],
                  ),
                  child: TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection("message").add({
                        "message":msgcontroller.text,
                        "date":date,

                      }).then((value) {
                        print(value.id);
                        Navigator.pop(context);
                      }).catchError(
                              (error) => print("failed to add new booking $error"));

                    },
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
