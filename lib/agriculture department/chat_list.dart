import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_care/agriculture%20department/agri_chat.dart';
import 'package:plant_care/user/chat.dart';

class AgriChatListScreen extends StatefulWidget {
  const AgriChatListScreen({super.key});

  @override
  _AgriChatListScreenState createState() => _AgriChatListScreenState();
}

class _AgriChatListScreenState extends State<AgriChatListScreen> {
  bool loading = false;
  List<DocumentSnapshot> usersChatList = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
   User? currentUser;

  @override
  void initState() {
    currentUser = _auth.currentUser;
    super.initState();
    getChatList() ;
    
  }

  getChatList() async {
    try {
      setState(() {
        loading = true;
      });

      var userIdList;

      final data = FirebaseFirestore.instance
          .collection('chats')
          .where('agriId', isEqualTo: currentUser?.uid);


          

      final usersDatalist = FirebaseFirestore.instance.collection('user_Tb');

      await data.get().then((QuerySnapshot querySnapshot) async {
        userIdList = querySnapshot.docs.map((e) => e['userId']);

        await usersDatalist
            .where(FieldPath.documentId, whereIn: userIdList)
            .get()
            .then((QuerySnapshot querySnapshot) =>
                usersChatList = querySnapshot.docs);
      });

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar( SnackBar(content: Text(e.toString())));
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
          : usersChatList.isEmpty ?const Center(child: Text('No Chats'),)  :Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: ListView.separated(
              
              
                itemCount: usersChatList.length,
                itemBuilder: (context, index) {
                  final userChat = usersChatList[index];

                  


                  return ListTile(
                    onTap: () {

                       Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  AgriChatScreen(userId: userChat.id)));
                      
                    },
                  
                    leading: const CircleAvatar(
                  
                      backgroundImage: AssetImage('images/admin.png'),
                    ),
                    title: Text(userChat['fullname'])
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
}
