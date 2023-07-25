import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_care/user/chat.dart';

import '../firebase/notification.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool loading = false;
  List<DocumentSnapshot> usersChatList = [];
 final  _firebaseNotification = FirebaseNotificatios();

  @override
  void initState() {
    super.initState();
    getChatList() ;
    
  }

  Future<void> getChatList() async {
    try {
      setState(() {
        loading = true;
      });

      final data = FirebaseFirestore.instance.collection('agriculture');

      await data.get().then((QuerySnapshot querySnapshot) {
        usersChatList = querySnapshot.docs;
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Chat'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: ListView.separated(
              
              
                itemCount: usersChatList.length,
                itemBuilder: (context, index) {
                  final userChat = usersChatList[index];

                  


                  return ListTile(
                    onTap: () {

                      sendNotifications(userChat.id);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your chat is ready')));

                      


                       Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  ChatScreen(agriId: userChat.id,)));

                 
                      
                    },
                  
                    leading: const CircleAvatar(
                  
                      backgroundImage: AssetImage('images/admin.png'),
                    ),
                    title: Text(userChat['name'])
                    ,
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 15,
                  );
                },
              ),
          ),
    );


    
  }

  sendNotifications(dynamic id) async{

    setState(() {
      loading = true;
    });

    String deviceToken = await _firebaseNotification.getagriToken(id);

    await _firebaseNotification.sendNotificationToAdmin(deviceToken: deviceToken,title: 'New chat',body: 'You got a new chat');

    setState(() {
      loading = false;
    });


  }
}
