import 'package:flutter/material.dart';

import 'home public.dart';


class symptoms extends StatefulWidget {
final String name;
final String symptm;


  const symptoms({super.key, required this.name, required this.symptm});

  @override
  State<symptoms> createState() => _symptomsState();
}

class _symptomsState extends State<symptoms> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Prediction"),
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
                      builder: (context) => homepage(),
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
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Text(
                      'Disease Name',
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
                      widget.name,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
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
                widget.symptm,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              // Text(
              //   '* Small black spots appear',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              // ),
              // Text(
              //   '* circular spots appear on leaves',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // Text(
              //   'Treatment',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     decoration: TextDecoration.underline,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Text(
              //   '* proper sanitation',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              // ),
              // Text(
              //   '* Apply copper based sprays and lime sulfur ',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              // ),
              // Text(
              //   '* Remove all sources of spores',
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              // ),
              // SizedBox(
              //   height: 100,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
