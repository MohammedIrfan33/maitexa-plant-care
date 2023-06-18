import 'package:flutter/material.dart';
import 'package:plant_care/admin/homeadmin.dart';


class tomato extends StatefulWidget {
  const tomato({Key? key}) : super(key: key);

  @override
  State<tomato> createState() => _tomatoState();
}

class _tomatoState extends State<tomato> {
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
                      'Tomato',
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
                    'Solanum lycopersicum',
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
                'From its origins as a wild plant in the Americas to the thousands of varieties grown around the world today, tomatoes have evolved into one of the worlds most popular food crops. Todays tomatoes began as wild plants in the Andes, growing in parts of Bolivia, Chile, Colombia, Ecuador and Peru.',
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
                'Tomato can be grown on a wide range of soils from sandy to heavy clay. However, well-drained, sandy or red loam soils rich in organic matter with a pH range of 6.0-7.0 are considered as ideal. Tomato is a warm season crop.',
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
                'The optimum temperature is between 26 and 29˚C. For the optimal development of the tomato plant, a relative humidity between 65% and 85% is required. Higher relative humidity levels negatively influence pollen release and distribution on the stigma.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
