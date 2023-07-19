import 'package:flutter/material.dart';
import 'package:plant_care/admin/crop%20description/crop%20description.dart';
import 'package:plant_care/login.dart';
import 'package:plant_care/plants.dart';
import 'package:plant_care/public_desc.dart';
import 'package:plant_care/user/Notifications.dart';
import 'package:webview_flutter/webview_flutter.dart';



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}
enum MenuItem{
  capture,Account,Logout
}
class _homepageState extends State<homepage> {

  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("homepage"),

        backgroundColor: Colors.teal[900],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            )),

        //leading: IconButton( onPressed: (){ Navigator.pushReplacement(
          //  context,
            //MaterialPageRoute(
              //builder: (context) => wel(),
            //)); }, icon:Icon(Icons. arrow_back),),
          actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                  icon: Icon(Icons.person)),
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => notification()
                        ));
                  },
                  icon: Icon(Icons.notifications)),
            ],
          )
        ],
      ),
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const Publiccropdesc(),
                    ));
              },
              backgroundColor: Colors.teal[900],
              child: const Icon(Icons.add),
            ),

          ],
        ),
      ),
      body: Center(
          child:WebView(
            zoomEnabled: true ,
            initialUrl: "https://www.wired.com/tag/plants/",
            javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: (WebViewController webViewController) {
      _controller = webViewController;
    }
    ),
      ),

    );

  }
}
