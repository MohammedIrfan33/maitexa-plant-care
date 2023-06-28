
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditDisease extends StatefulWidget {
  final String documentId;
  final String symptoms;
  final String treatment;

  const EditDisease({
    Key? key,
    required this.documentId,
    required this.symptoms,
    required this.treatment,
  }) : super(key: key);

  @override
  State<EditDisease> createState() => _EditDiseaseState();
}

class _EditDiseaseState extends State<EditDisease> {
  late TextEditingController symptom;
  late TextEditingController treatment;

  @override
  void initState() {
    super.initState();
    symptom = TextEditingController(text: widget.symptoms);
    treatment = TextEditingController(text: widget.treatment);
  }

  void updateDiseaseData() {
    FirebaseFirestore.instance
        .collection("disease")
        .doc(widget.documentId)
        .update({
          "symptoms": symptom.text,
          "treatment": treatment.text,
        })
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated successfull')));
          Navigator.pop(context);
        })
        .catchError((error) {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Disease"),
        backgroundColor: Colors.teal[900],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: symptom,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter symptoms',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: treatment,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter treatment',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[900],
              ),
              onPressed: () {
                updateDiseaseData();
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
