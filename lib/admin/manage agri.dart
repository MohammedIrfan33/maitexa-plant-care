import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homeadmin.dart';

class agri_details extends StatefulWidget {
  const agri_details({Key? key}) : super(key: key);

  @override
  State<agri_details> createState() => _agri_detailsState();
}

class _agri_detailsState extends State<agri_details> {
  void acceptAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('agriculture')
        .doc(appointmentId)
        .update({
      'isAccepted': true,
      'status': 'accepted',
    });
    //login document  appointment id updated with is accepted
    FirebaseFirestore.instance.collection('login').doc(appointmentId).update({
      'isAccepted': true,
    });
  }

// Function to reject an appointment
  void rejectAppointment(String appointmentId) {
    FirebaseFirestore.instance
        .collection('agriculture')
        .doc(appointmentId)
        .update({
      'isRejected': true,
      'status': 'rejected',
    });
  }

  void deleteUser(String appointmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('agriculture')
          .doc(appointmentId)
          .delete();
      await FirebaseFirestore.instance
          .collection('login')
          .doc(appointmentId)
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
                        builder: (context) => Homeadmin(),
                      ));
                },
                icon: Icon(Icons.home))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('agriculture')
              .where('isAccepted', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final appointments = snapshot.data!.docs;
              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment =
                      appointments[index].data() as Map<String, dynamic>;
                  final appointmentId = appointments[index].id;
                  final name = appointment['name'];
                  final phone = appointment['phone'];

                  final status = appointment['status'];
                  final imageUrl = appointment['image'];

                  return Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(imageUrl),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Name: $name",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Phone: $phone",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 90,
                                height: 40,
                                color: Colors.green[900],
                                child: TextButton(
                                  onPressed: () {
                                    acceptAppointment(appointmentId);
                                  },
                                  child: Text(
                                    status == 'accepted'
                                        ? 'Accepted'
                                        : 'Accept',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 90,
                                height: 40,
                                color: Colors.green[900],
                                child: TextButton(
                                  onPressed: () {
                                    rejectAppointment(appointmentId);
                                    deleteUser(appointmentId);
                                  },
                                  child: Text(
                                    status == 'rejected'
                                        ? 'Rejected'
                                        : 'Reject ',
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 90,
                                height: 40,
                                color: Colors.green[900],
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Stack(
                                          children: [
                                            Image.network(
                                              imageUrl,
                                              fit: BoxFit.fill,
                                              ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                                child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle
                                                ),
                                                
                                                child: const Icon(
                                                  
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 20,
                                                  ),
                                              ),
                                            ))
                                          ],

                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'certificate',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        )

        /*Container(
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
                        'Full Name : Akhil',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text('Email  : akhil@gmail.com',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Location : Malappuram',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
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
                        'Full Name : Rineeta',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Email : rineeta@gmail.com',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Location : Ernankulam',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
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
                        'Full Name : Varun',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Email : varun@gmail.com',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Location : Palakkad',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
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
