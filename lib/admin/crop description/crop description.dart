import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/admin/crop%20description/apple.dart';
import 'package:plant_care/home%20public.dart';


class cropdesc extends StatefulWidget {
  const cropdesc ({Key? key}) : super(key: key);

  @override
  State<cropdesc > createState() => _cropdescState();
}

class _cropdescState extends State<cropdesc> {
  final CollectionReference crop = FirebaseFirestore.instance
      .collection('crop'); //refer to the table we created

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crops"),
        leading:IconButton(onPressed:(){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => homepage(),
        ));
      },
          icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.teal[900],),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:StreamBuilder(
          stream: crop.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return GridView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                ),
                itemBuilder: (BuildContext context, int index) {

                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => apple(
                            documentSnapshot.id,)));
                    },
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Image.network(
                              documentSnapshot['image'],
                              height: 99,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Text(
                              documentSnapshot['name'],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                },);
            
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
     
     
      ),
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                _create();
              },
              backgroundColor: Colors.teal[900],
              child: Icon(Icons.add),
            ),

          ],
        ),
      ),
    );
  
  
  }
 
 
 
 
 
  final TextEditingController _plantController = TextEditingController();

  final CollectionReference _products = FirebaseFirestore.instance
      .collection('notify'); //refer to the table we created
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _plantController.text = documentSnapshot['notification'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text('Add Plant Suggestion'),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _plantController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          border: InputBorder.none,
                          hintText: "enter suggestions",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {

                          final String plant_name = _plantController.text;

                          if (plant_name != null) {
                            await _products.add({
                              "notification": plant_name,
                            });
                            _plantController.text = '';
                          }
                        },
                        child: Text('submit')),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
