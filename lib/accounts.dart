import 'package:flutter/material.dart';
import 'package:plant_care/agriculture%20department/signup%20agri.dart';
import 'package:plant_care/user/signup.dart';

class account extends StatefulWidget {
  const
  account({Key? key}) : super(key: key);

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("account"),
        backgroundColor: Colors.teal[900],),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding:   EdgeInsets.symmetric(horizontal:10,vertical:20),
              child: Text(
                "Select Your Role?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
            ),
            Column(children: [
              GestureDetector(

                onTap: ()=>Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Signup())),
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0, left: 60,bottom: 5),
                  child: Container(
                    height: 265,
                    width: 260,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topLeft,
                          image: AssetImage(
                            'images/users.png',
                          ),
                          fit: BoxFit.contain
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 110, right: 5, bottom: 30, top: 210),
                      child: Text(
                        "User",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),


                  ),
                ),
              ),
            ]),
            Column(children: [
              GestureDetector(

                onTap: ()=>Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Signupagri())),
                child:Padding(
                  padding: const EdgeInsets.only(top: 40, left: 60),
                  child: Container(
                    height: 265,
                    width: 260,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(
                          'images/agri.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 230,left: 25),
                      child: Text("Agriculture Department",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ],
      ),
    );
  }
}
