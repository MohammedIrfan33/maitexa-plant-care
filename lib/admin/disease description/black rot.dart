import 'package:flutter/material.dart';
import 'package:plant_care/admin/homeadmin.dart';


class blackrot extends StatefulWidget {
  const blackrot({Key? key}) : super(key: key);

  @override
  State<blackrot> createState() => _blackrotState();
}

class _blackrotState extends State<blackrot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text("black Rot"),
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
                      'Apple ',
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
                    'Black Rot',
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
                '* flesh of Apple will be  brown',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                  '*Initially tiny purple fleck appears eventually it enlarges',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Small black spots appear',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* circular spots appear on leaves',
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
                '* proper sanitation',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Apply copper based sprays and lime sulfur ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Remove all sources of spores',
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
