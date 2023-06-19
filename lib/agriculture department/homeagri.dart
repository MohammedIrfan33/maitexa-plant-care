import 'package:flutter/material.dart';
import 'package:plant_care/agriculture%20department/edit%20profile%20agri.dart';
import 'package:plant_care/agriculture%20department/message.dart';
import 'package:plant_care/agriculture%20department/viewmessage.dart';

import '../home public.dart';
import '../user/chat.dart';
import 'chat.dart';

class Homeagri extends StatefulWidget {
  @override
  State<Homeagri> createState() => _HomeagriState();
}

class _HomeagriState extends State<Homeagri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editagri()));
                },
                icon: Icon(Icons.person)),
          ],
          title: const Text("home"),
          backgroundColor: Colors.teal[900],
        ),
        body: Column(children: [
          /* Container(
            height: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.white,
                      // child: CircleAvatar(
                      // child: Align(
                      // alignment: Alignment.bottomRight,
                      //child: CircleAvatar(
                      //backgroundColor: Colors.green[200],
                      //radius: 12.0,
                      // child: Icon(
                      // Icons.camera_alt,
                      //size: 15.0,
                      //color: Color(0xFF404040),
                      //),
                      //),
                      backgroundImage: AssetImage(
                        'images/acc.png',
                      ),
                      //),
                      //),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Hello ',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Raniya Sherin',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => editagri()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[300],
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontFamily: 'SF Pro',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 30),
            child: Text(
              "Choose your way!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Admin())),
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
                size: 50,
              ),
              label: Text(
                "Chat",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(250, 45, 186, 239),
                fixedSize: const Size(360, 140),
                shadowColor: Colors.teal[900],
                backgroundColor: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ViewMessage())),
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
                size: 50,
              ),
              label: Text(
                "Message",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(250, 45, 186, 239),
                fixedSize: const Size(360, 140),
                shadowColor: Colors.teal[900],
                backgroundColor: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ]));
  }
}
