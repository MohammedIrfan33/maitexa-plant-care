import 'package:flutter/material.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/admin/disease%20description/bacterial%20speck.dart';
import 'package:plant_care/admin/disease%20description/black%20rot.dart';
import 'package:plant_care/admin/disease%20description/corn%20eyespot.dart';
import 'package:plant_care/admin/disease%20description/grape%20powdry.dart';
import 'package:plant_care/admin/disease%20description/potato%20late%20blight.dart';
import 'package:plant_care/admin/homeadmin.dart';

class disease_desp extends StatefulWidget {
  const disease_desp ({Key? key}) : super(key: key);

  @override
  State<disease_desp > createState() => _disease_despState();
}

class _disease_despState extends State<disease_desp > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text("Disease Description"),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              )),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homeadmin(),));
            }, icon: Icon(Icons.home))
          ],
        ),
        body:ListView(
          children:[
          Column(
      children:[
        GestureDetector(

        onTap: ()=>Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  blackrot())),
    child:Container(height: 210,
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image:DecorationImage(
                            image: AssetImage("images/apple.jpg"),fit: BoxFit.cover,),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),),),
    GestureDetector(

    onTap: ()=>Navigator.push(context,
    MaterialPageRoute(builder: (context) =>  lateblight())),
    child:Container(height: 210,
          margin: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage("images/potato.jpg"),fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),),),
    GestureDetector(

    onTap: ()=>Navigator.push(context,
    MaterialPageRoute(builder: (context) =>  bacterialspeck())),
    child:Container(height: 210,
          margin: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage("images/tomato.jpg"),fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),),),
    GestureDetector(

    onTap: ()=>Navigator.push(context,
    MaterialPageRoute(builder: (context) =>  eyespot())),
    child:Container(height: 210,
          margin: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage("images/corn.jpg"),fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),),),
    GestureDetector(

    onTap: ()=>Navigator.push(context,
    MaterialPageRoute(builder: (context) =>  powdry())),
    child:Container(height: 210,
          margin: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage("images/grape.jpg"),fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),),
    )
   ] )
   ] )
    );
  }
}
