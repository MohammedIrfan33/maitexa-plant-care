import 'package:flutter/material.dart';
import 'package:plant_care/admin/homeadmin.dart';


class potato extends StatefulWidget {
  const potato ({Key? key}) : super(key: key);

  @override
  State<potato > createState() => _potatoState();
}

class _potatoState extends State<potato > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text("Description"),
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
                      'Crop Name',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
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
                      'Potato',
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
                    'Scientific Name',
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
                    'Solanum tuberosum',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Origin',
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
                'The humble potato was domesticated in the South American Andes some 8,000 years ago and was only brought to Europe in the mid-1500s, from where it spread west and northwards, back to the Americas, and beyond.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),

              SizedBox(
                height: 15,
              ),
              Text(
                'Suitable Soil',
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
                'Loamy and sandy loam soils, rich in organic matter with good drainage and aeration are most suitable for cultivation of potato crop. The soil with pH range of 5.2-6.4 is considered to be ideal.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                'Climate and Humidity',
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
                'For fresh market potatoes, a temperature of 40° F. is recommended. Seed potatoes may be stored at slightly lower temperatures (38° to 40° F.) for better weight loss and sprout control. Maintain a 95 percent relative humidity at all times.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
