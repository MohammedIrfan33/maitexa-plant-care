import 'package:flutter/material.dart';

import 'package:plant_care/admin/homeadmin.dart';

class carrot extends StatefulWidget {
  const carrot ({Key? key}) : super(key: key);

  @override
  State<carrot> createState() => _carrotState();
}

class _carrotState extends State<carrot> {
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
                      'Carrot',
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
                    'Daucus carota',
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
                'Carrots originated in modern-day Iran and Afghanistan. They contain around 32,000 genes (more than humans), of which two recessive ones contribute to a build-up of carotenoids, such as alpha- and beta-carotene.',
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
                'Carrots grow best in full sun and light, fertile, well-drained soil. If your soil is stony, shallow or heavy clay, you may end up with stunted or forked roots, so try short-rooted types.',
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
                'Carrot is a cool season crop and will develop a good colour when grown at 15°C to 20°C. The crop needs deep loose loamy soil. It requires a pH ranging from 6.0 to 7.0 for higher production. Carrot can be grown throughout the year at an elevation above 1500 metres with assured irrigation.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
