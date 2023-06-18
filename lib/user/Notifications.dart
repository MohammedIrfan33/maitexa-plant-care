import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/home%20public.dart';
class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {

  final CollectionReference message = FirebaseFirestore.instance
      .collection('message');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('Notifications'),
        backgroundColor: Colors.teal[900],
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => homepage(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body:
      StreamBuilder(
          stream: message.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot>streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(

                    shrinkWrap: true,
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot
                          .data!.docs[index];
                      return
                        Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.notifications, color: Colors.black,),
                            title: Text(
                              documentSnapshot['message'],
                              style: TextStyle(color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                            subtitle: Text(documentSnapshot['date'],
                                style: TextStyle(color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),

                          ),

                        );
                    }
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
