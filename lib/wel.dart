import 'package:flutter/material.dart';
import 'package:plant_care/firebase/authentication.dart';
import 'home public.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/my.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Column(children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text(
                    "Hello there!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 200),
                child: Text(
                  "Welcome to PlantCare",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                AuthenticationHelper()
                    .signOut()
                    .then((_) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contex) => homepage()),
                        ));
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 500),
                  child: Text("GetStarted",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
