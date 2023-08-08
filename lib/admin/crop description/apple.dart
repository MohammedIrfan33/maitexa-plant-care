import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/admin/edit_crop.dart';
import 'package:plant_care/admin/homeadmin.dart';

class apple extends StatefulWidget {
  final String id;

  apple(this.id);

  @override
  State<apple> createState() => _appleState();
}

class _appleState extends State<apple> {
  String fullname = '';
  String climate = '';
  String image = '';
  String orgin = '';
  String sname = '';
  String soil = '';

  bool loading = false;
  void fetchUserData() {

    setState(() {
      loading = true;
    });
    String ids = widget.id;
    FirebaseFirestore.instance
        .collection('crop')
        .doc(ids)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          fullname = data['name'] as String;
          climate = data['climate'] as String;
          image = data['image'] as String;
          orgin = data['climate'] as String;
          sname = data['scientificname'] as String;
          soil = data['soil'] as String;

          loading =false;
        });
      } else {
        
        setState(() {
          
          loading =false;
        });
      }
    }).catchError((error) {});
  }

  deleteDoc() async{

    setState(() {
      loading = true;
    });

    try {
      await FirebaseFirestore.instance.collection('crop').doc(widget.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully deleted')));
      Navigator.pop(context); // Navigate back after deletion
    } catch (error) {
      print('Error deleting document: $error');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to delete')));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: 30,
      thickness: .4,
      color: Colors.grey,
      indent: 14,
      endIndent: 14,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[900]),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCrop(
                            name: fullname,
                            scName: sname,
                            orginName: orgin,
                            soilname: soil,
                            cliHumdity: climate,
                            
                            image: image,
                            id: widget.id,
                          ),
                        ));
                  },
                  child: const Text('Edit')),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[900]),
                  onPressed: () {

                    showDialog(
                      context: context, builder: (context) => 
                      AlertDialog(
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(onPressed: () {

                             deleteDoc();

                             Navigator.pop(context);


                            
                          }, child: Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.teal[900]
                            ),
                            )),

                          TextButton(onPressed: () {
                            Navigator.pop(context);
                            
                          }, child: Text(
                            'No',
                            style: TextStyle(
                              color: Colors.teal[900]
                            ),
                            ))
                        ],
                        
                        ),
                      );



                  },
                  child: const Text('Delete')),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Description"),
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
              icon: const Icon(Icons.home))
        ],
      ),
      body: loading ?  Center(child: CircularProgressIndicator(color: Colors.teal[900],),) :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: NetworkImage(image),
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RowText(lefttext: 'Crop name', rightText: fullname),
                  divider,
                  RowText(lefttext: 'Scientific  name', rightText: sname),
                  divider,
                  RowText(lefttext: 'Climet', rightText: climate),
                  divider,
                  RowText(lefttext: 'Soil', rightText: soil),
                  divider,
                  RowText(lefttext: 'Orgin', rightText: orgin),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.lefttext,
    required this.rightText,
  });

  final String lefttext;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              lefttext,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              rightText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
