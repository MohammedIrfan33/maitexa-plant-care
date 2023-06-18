import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';

import 'homeadmin.dart';


class user_details extends StatefulWidget {
  const user_details({Key? key}) : super(key: key);

  @override
  State<user_details> createState() => _user_detailsState();
}

class _user_detailsState extends State<user_details> {

  void acceptAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('user_Tb')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });
    //login document  appointment id updated with is accepted
    FirebaseFirestore.instance
        .collection('login')
        .doc(appointmentId)
        .update({
      'isAccepted': true,

    });
  }

// Function to reject an appointment
  void rejectAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('user_Tb')
        .doc(appointmentId)
        .update({
      'isRejected': true,
      'status': 'rejected',
    });
  }
  void deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_Tb')
          .doc(userId)
          .delete();
      await FirebaseFirestore.instance
          .collection('login')
          .doc(userId)
          .delete();
      print('User deleted successfully');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text("User Manage"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homeadmin(

                        ),
                      ));
                },
                icon: Icon(Icons.home))
          ],
        ),
        body:Padding(
            padding: const EdgeInsets.all(8.0),
            child:StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('user_Tb').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = appointments[index].data() as Map<String, dynamic>;
                      final appointmentId = appointments[index].id;
                      final patientName = appointment['fullname'];
                      final patientPhone = appointment['phone'];
                      final isAccepted = appointment['isAccepted'];
                      final isRejected = appointment['isRejected'];
                      final status = appointment['status'];

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
                                    Text("Name:" +patientName, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("Phone:" +patientPhone, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    SizedBox(height: 10,),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:90,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){acceptAppointment(appointmentId);},
                                            child: Text(status == 'accepted'?'Accepted':'Accept',style: TextStyle(color: Colors.white),),),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 90,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){
                                            rejectAppointment(appointmentId);
                                            deleteUser(appointmentId);
                                          },
                                            child: Text(status == 'rejected'?'Rejected':'Reject ',style: TextStyle(color: Colors.white),),),
                                        ),
                                      ],
                                    ),

                                  ],),
                              ),
                            ),
                          ],),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )

          /*StreamBuilder(
              stream: bookings.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>streamSnapshot) {
                if(streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                      print("snap ${documentSnapshot}");
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
                                    Text("name:" +documentSnapshot['name'], style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("date:" +documentSnapshot['date'], style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("time:" + documentSnapshot['time'], style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    SizedBox(height: 10,),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){},
                                            child: Text('Accept',style: TextStyle(color: Colors.white),),),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 60,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){},
                                            child: Text('Reject ',style: TextStyle(color: Colors.white),),),
                                        ),
                                      ],
                                    ),

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
            ),*/
        )

      /* Container(
            child: Column(children: [
          Container(
            height: 150,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Full Name : Sabitha',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Email : Sabitha@gmail.com',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.green[900],
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 40,
                        color: Colors.green[900],
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Reject ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Full Name : Arun',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Email : arun@gmail.com.com',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 40,
                        color: Colors.green[900],
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 40,
                        color: Colors.green[900],
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Reject ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ])),
          ),

                    Container(
                      height: 150,
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Full Name : Keerthana',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email : Keerthana@gmail.com',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 40,
                                  color: Colors.green[900],
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Accept',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 60,
                                  height: 40,
                                  color: Colors.green[900],
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Reject ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                          ])),
                    )
                  ])
    )*/
    );

  }
}
