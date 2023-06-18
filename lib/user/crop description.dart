import 'package:flutter/material.dart';
import 'package:plant_care/admin/crop%20description/grapes.dart';
import 'package:plant_care/admin/crop%20description/apple.dart';
import 'package:plant_care/admin/crop%20description/potato.dart';
import 'package:plant_care/admin/crop%20description/pumpkin.dart';
import 'package:plant_care/admin/crop%20description/strawberry.dart';
import 'package:plant_care/admin/crop%20description/tomato.dart';
import 'package:plant_care/admin/crop%20description/watermelon.dart';

import '../admin/crop description/carrot.dart';

class cropdesc extends StatefulWidget {
  const cropdesc ({Key? key}) : super(key: key);

  @override
  State<cropdesc > createState() => _cropdescState();
}

class _cropdescState extends State<cropdesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crops"),
        backgroundColor: Colors.teal[900],),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            shrinkWrap: true,
            children: <Widget>[
              InkWell(
                onTap: () {
               /*   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => apple()));
              */  },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Image.asset(
                            'images/apple image.jpg',
                            height: 99,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => grapes()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/grape image.jpg',
                          height: 121,
                          width: 110,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Text(
                            '',style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),),),
                        Text('',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => watermelon()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/watermelon.jpg',
                          height: 120,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => strawberry()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/strawberry.jpg',
                          height: 120,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => potato()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/potatos.jpg',
                          height: 120,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => tomato()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/tomatos.jpg',
                          height: 120,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => pumpkin()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/pumpkin.jpg',
                          height: 120,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => carrot()));
                },
                child: Container(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/carrot.jpg',
                          height: 120,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,top: 3),
                          child: Text(
                            '',
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
