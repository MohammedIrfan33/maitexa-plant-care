import 'package:flutter/material.dart';

import '../homeadmin.dart';


class powdry extends StatefulWidget {
  const powdry  ({Key? key}) : super(key: key);

  @override
  State<powdry> createState() => _powdryState();
}

class _powdryState extends State<powdry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text("Powdry Mildew"),
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      'Plant Name',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 49,
                    ),
                    Text(
                      ':',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Grape',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Disease Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  Text(
                    ':',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Powdry Mildew',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Symptoms',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '* whitish or greenish-white powdery patches on leaves',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '*  Leaf curling and withering',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '*  Scarring and cracking of berries',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Leaves become slightly yellow or red a',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Treatment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '* Use an under-vine irrigation system',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Manage irrigation carefully. E',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Select varieties that are less susceptible to mildew',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '*  Remove leaves in the fruiting zone.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
