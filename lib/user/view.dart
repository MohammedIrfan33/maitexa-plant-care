import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';

import '../admin/homeadmin.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);
  @override
  State<view> createState() => _viewState();
}
class _viewState extends State<view> {
  final CollectionReference user_Tb = FirebaseFirestore.instance
      .collection('user_Tb');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                icon: Icon(Icons.home))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:StreamBuilder<QuerySnapshot>(
            stream:FirebaseFirestore.instance.collection('user_Tb').where('status', isEqualTo: 'accepted').snapshots(),
            builder: ( context, snapshot) {
              if(snapshot.hasData) {
                final appointments = snapshot.data!.docs;
                return ListView.builder(
                  itemCount:  appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index].data() as Map<String, dynamic>;
                    final patientName = appointment['fullname'];
                    final phone = appointment['phone'];
                    return Container(
                      child: Column(
                        children: [
                          Container(height: 120,
                            margin: EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("fullname:" +patientName, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),),
                                  Text("phone:" +phone, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),),
                                 /* Text("age:" + documentSnapshot['age'], style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),),*/

                                  SizedBox(height: 10,),

                                ],),
                            ),
                          ),
                        ],),
                    );
                  },);
              }return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}