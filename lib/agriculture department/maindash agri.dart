import 'package:flutter/material.dart';
import 'package:plant_care/agriculture%20department/view%20agri.dart';

import '../admin/homeadmin.dart';
import '../admin/manage agri.dart';



class MainDash2 extends StatefulWidget {
  const MainDash2({super.key});

  

  @override
  State<MainDash2> createState() => _MainDash2State();
}

class _MainDash2State extends State<MainDash2> {
  get email => null;


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          )),
      ),

      body: SingleChildScrollView(
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
            ),*/ 
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
              padding: const EdgeInsets.all(80.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10),

              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => viewagri()));
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
                        MaterialPageRoute(builder: (context) => agri_details()));
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
    );
  }
}
