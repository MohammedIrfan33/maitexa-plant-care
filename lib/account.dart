import 'package:flutter/material.dart';
import 'package:plant_care/user/view.dart';


import 'admin/homeadmin.dart';
import 'admin/manage user.dart';

class MainDash extends StatelessWidget {
  const MainDash({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainDashB(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainDashB extends StatefulWidget {
  const MainDashB({super.key, required this.title});

  final String title;

  @override
  State<MainDashB> createState() => _MainDashBState();
}

class _MainDashBState extends State<MainDashB> {
  get email => null;


  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                      icon,
                      size: 40.0,
                      color: Colors.black,
                    )),
                SizedBox(height: 20.0),
                Center(
                  child: Text(title,
                      style:
                      TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Homeadmin()));
          },
        ),

        /// elevation: .1,
        //  backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [

              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "Registration",
                  style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                      color:Colors.black54
                  ),),
              ),*/ SizedBox(
                height: 40,
              ),
              //  GridView.count(
              //   shrinkWrap: true,
              //    crossAxisCount: 2,
              //    padding: EdgeInsets.all(3.0),
              //    children: <Widget>[
              //      makeDashboardItem("USER", Icons.person_2),
              //      makeDashboardItem("COMPANY", Icons.business),
              //      makeDashboardItem("DEPARTMENT", Icons.factory),
              //    ],
              //  ),
              GridView(

                shrinkWrap: true,
                padding: EdgeInsets.all(80.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10),

                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => view()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.teal[900],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50, color: Colors.white),
                          SizedBox(height: 5,),
                          Text("View",
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => user_details()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.teal[900],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pending_actions, size: 50,
                              color: Colors.white),
                          SizedBox(height: 5,),
                          Text("Pending Actions",
                              style:
                              TextStyle(fontSize: 18.0, color: Colors.white)),
                        ],
                      ),),
                  ),


                ],)
            ],
          ),
        ),
      ),
    );
  }
}
