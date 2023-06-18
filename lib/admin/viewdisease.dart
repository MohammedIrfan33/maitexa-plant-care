
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/admin/admin%20add%20disease.dart';

class ViewDisease extends StatefulWidget {
  const ViewDisease({Key? key}) : super(key: key);

  @override
  State<ViewDisease> createState() => _ViewDiseaseState();
}

class _ViewDiseaseState extends State<ViewDisease> {
  final CollectionReference crop = FirebaseFirestore.instance
      .collection('disease'); //refer to the table we created

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease"),
        backgroundColor: Colors.teal[900],),
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => disease(),
                      ));
                },
                backgroundColor: Colors.teal[900],
                child: Icon(Icons.add),
              ),

            ]),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:StreamBuilder(
          stream: crop.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {

                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  print("documentSnapshot${documentSnapshot.id}");
                  return Container(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(
                              documentSnapshot['symptoms'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),  Text(
                              documentSnapshot['treatment'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  /* children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => apple()));
                },
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
            ]);*/
                },);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
