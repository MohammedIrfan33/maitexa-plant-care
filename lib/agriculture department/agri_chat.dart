import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class AgriChatScreen extends StatefulWidget {
  const AgriChatScreen({super.key, required this.userId});

  final String userId;

  @override
  _AgriChatScreenState createState() => _AgriChatScreenState();
}

class _AgriChatScreenState extends State<AgriChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<QuerySnapshot>? _messageStream;

  QueryDocumentSnapshot<Object>? selctedAgri;

  String? specialication;
  bool loading = false;

  var usersChatList = [];

  User? currentUser;

  @override
  void initState() {
    currentUser = _auth.currentUser;

    _messageStream = _firestore
        .collection('chats')
        .where('userId', isEqualTo: widget.userId )
        .where('agriId',isEqualTo: currentUser?.uid)
        .orderBy('time', descending: true)
        .snapshots();

    super.initState();
  }

  Future<void> _sendMessage() async {
    final String messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    if (currentUser == null) return;

    await _firestore.collection('chats').add({
      'userId': widget.userId,
      'agriId':  currentUser?.uid,
      'senderId': currentUser?.uid,
      'messageText': messageText,
      'time': DateTime.now().millisecondsSinceEpoch,
    });

    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.green[900],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _messageStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!.docs;

                      

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final String senderId =
                              messages[index].get('senderId');
                              

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: senderId == currentUser?.uid
                                ? Alignment.bottomRight
                                : Alignment.centerLeft,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ListTile(
                                title: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: senderId == currentUser?.uid
                                        ? Colors.green[900]
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    messages[index].get('messageText'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                subtitle:
                                    Text(getTime(messages[index].get('time'))),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Enter a  message...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon:  const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

String getTime(int milliseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}
