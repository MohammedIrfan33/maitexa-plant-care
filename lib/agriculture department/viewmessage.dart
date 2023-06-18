import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/agriculture%20department/homeagri.dart';
import 'package:plant_care/agriculture%20department/message.dart';


class ViewMessage extends StatefulWidget {
  const ViewMessage({Key? key}) : super(key: key);

  @override
  State<ViewMessage> createState() => _ViewMessageState();
}

class _ViewMessageState extends State<ViewMessage> {
  String appointmentId='';
  final CollectionReference _msg = FirebaseFirestore.instance
      .collection('message'); //refer to the table we created

  TextEditingController msgController=TextEditingController();
 /* void deleteMessage(String msgId) async {
    try {
      await FirebaseFirestore.instance
          .collection('message')
          .doc(msgId)
          .delete();
      print('Message deleted successfully');
    } catch (e) {
      print('Message deleting user: $e');
    }
  }
 */ Future<void> deleteMessage(String productId) async {
    await _msg.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a symptoms')));
  }


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      msgController.text = documentSnapshot['message'];
    }
    await  showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding:  EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),

            child: Container(
              height: 300,

              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('update message'),


                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: msgController,

                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),

                          border: InputBorder.none,
                          hintText: "enter message",
                        ),
                      ),
                    ),

                    ElevatedButton(onPressed: () async {
                      final String symptoms_name= msgController.text;
                      if ( symptoms_name != null) {
                        await _msg
                            .doc(documentSnapshot!.id)

                            .update({"message": symptoms_name,});
                        msgController.text = '';
                        Navigator.pop(context);
                      }

                    },
                        child: Text('update')
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(

          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>message())),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text("Message Manage"),
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
                        builder: (context) => Homeagri(

                        ),
                      ));
                },
                icon: Icon(Icons.home))
          ],
        ),
        body:Padding(
            padding: const EdgeInsets.all(8.0),
            child:StreamBuilder<QuerySnapshot>(
              stream:  _msg.snapshots(),
              builder: (context,  AsyncSnapshot<QuerySnapshot>snapshot) {
                if (snapshot.hasData) {
                  final appointments = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot=appointments[index];

                      final appointment = appointments[index].data() as Map<String, dynamic>;
                       appointmentId = appointments[index].id;
                      final msgdate = appointment['date'];
                      final msg = appointment['message'];
                      return Container(
                        child: Column(
                          children: [
                            Container(height: 120,
                              margin: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("Date:" +msgdate, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),
                                    Text("Message:" +msg, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),),

                                    SizedBox(height: 10,),
                                    Row(mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width:90,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){_update(documentSnapshot);},
                                            child: Text("Edit",style: TextStyle(color: Colors.white),),),
                                        ),
                                        SizedBox(width: 10,),
                                        Container(
                                          width: 90,
                                          height: 40,
                                          color: Colors.green[900],
                                          child: TextButton(onPressed: (){
                                            deleteMessage(appointmentId);
                                          },
                                            child: Text("Delete",style: TextStyle(color: Colors.white),),),
                                        ),
                                      ],
                                    ),

                                  ],),
                              ),
                            ),
                          ],),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )

        )

    );

  }
}
