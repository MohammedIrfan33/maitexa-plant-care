import 'package:flutter/material.dart';

import '../homeadmin.dart';


class lateblight extends StatefulWidget {
  const lateblight ({Key? key}) : super(key: key);

  @override
  State<lateblight > createState() => _lateblightState();
}

class _lateblightState extends State<lateblight > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text("Late blight"),
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
                      'Potato ',
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
                    'Potato Late Blight',
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
                '* Small water-soaked spots develop at the tips of leaf',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* whitish cottony growth of the fungus under the leaf',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* small,light to dark green,circular spots appear',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Watery blisters of green or yellow on the leaf foliage.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Brown or black lesions appear on the lower leaf.',
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
                '* Eliminating cull piles and volunteer potatoes',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* proper harvesting and storage practices',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '* Fertilize and irrigate optimally for the variety.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                '*  Kill vines totally prior to harvest ',
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
