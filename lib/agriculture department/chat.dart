import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String message) {
    User? user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    FirebaseFirestore.instance.collection('message').doc('room').update({
      'messages': FieldValue.arrayUnion([
        {
          'email' : user?.email,
          'content': message,
          'time': DateTime.now(),

        }
      ]),
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.teal[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('message')
                  .doc('room')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> messages =
                      snapshot.data!.get('messages') ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      dynamic message = messages[index];

                      
                       return ListTile(
                        title: Text(message['content']),
                        subtitle: Text(
                          message['email'].toString(),
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: Container(
          //       width: 100,
          //       height: 60,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           hintText: "hi",
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Container(
          //       width: 100,
          //       height: 60,
          //       child: TextField(
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           hintText: "hello! how can I help you",
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          
          
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 320),
              child: TextField(
                controller: _messageController,
                onSubmitted: (value) {
                  _sendMessage(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.teal[900],
                    ),
                    onPressed: () {
                      _sendMessage(_messageController.text);
                    },
                  ),
                  hintText: "Type here",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
