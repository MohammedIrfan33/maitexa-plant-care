

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/account.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_care/admin/admin%20add%20disease.dart';
import 'package:plant_care/admin/admin%20crop%20add.dart';
import 'package:plant_care/admin/admin%20crop%20desc.dart';
import 'package:plant_care/admin/notify.dart';
import 'package:plant_care/admin/viewdisease.dart';

import '../agriculture department/maindash agri.dart';
import 'crop description/crop description.dart';

class Homeadmin extends StatefulWidget {
  @override
  State<Homeadmin> createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {

  int  ? count;
  @override
  void initState() {
    super.initState();

  }

  Future<void> notificationCount() async {
     count = await FirebaseFirestore.instance
        .collection('notify')
        .get()
        .then((value) => value.size);

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text("Admin"),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            // shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainDash()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Image.asset(
                        'images/user.png',
                        height: 80,
                        // width: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Manage User',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainDash2()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Image.asset(
                        'images/agri.jpg',
                        height: 80,

                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Manage',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Agriculture Department',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cropdesc_admin()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Image.asset(
                        'images/crop.jpg',
                        height: 80,

                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Crop Description',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewDisease()));
                },
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Image.asset(
                        'images/disease.png',
                        height: 80,

                        fit: BoxFit.cover,
                      ),
                     const  SizedBox(height: 10,),
                     const  Text(
                        'Disease Description',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddNotify()));
                },
                child: Card(
                  elevation: 10,
                  child: StreamBuilder<QuerySnapshot>(
                    stream:FirebaseFirestore.instance
                        .collection('notify').snapshots() ,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    size: 80,
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                            snapshot.data!.docs.length.toString(),
                                            style: TextStyle(
                                                color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }


                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Icon(
                              Icons.logout,
                              size: 65,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
