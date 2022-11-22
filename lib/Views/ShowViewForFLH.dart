import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';

class ShowHistory extends StatelessWidget {

  final controller = Get.put(ControllerState());

  final data = Get.arguments[0]["personaldata"];
  final userid = Get.arguments[1]["userid"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text(
          "Data Entry/View",
          style: GoogleFonts.gugi(color: Colors.white),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Center(child: InkWell(
              onTap: (){
                Get.toNamed("/feedback-entry",arguments: [{"Personal-data":data},{"userid":userid}]);
              },
              hoverColor: Colors.teal,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(15),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          color: Colors.grey)
                    ]),
                child: Column(
                  children: [
                    Icon(Icons.feedback_outlined,color: Colors.purpleAccent,size: 80,)
                    ,Text("Feedback-Entry",style: GoogleFonts.mulish(),)
                  ],
                ),
              ),
            ),),
            SizedBox(height: 10,),
            Center(child: InkWell(
              onTap: (){
                Get.toNamed("/late-entry",arguments: [{"Personal-data":data},{"userid":userid}]);
              },
              hoverColor: Colors.teal,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(15),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          color: Colors.grey)
                    ]),
                child: Column(
                  children: [
                    Icon(Icons.directions_run_outlined,color: Colors.purpleAccent,size: 80,)
                    ,Text("Late-Entry",style: GoogleFonts.mulish(),)
                  ],
                ),
              ),
            ),),
            SizedBox(height: 10,),
            Center(child: InkWell(
              onTap: ()async{
                Get.toNamed("/show-personal-data",
                    arguments: [
                      {"Personal data": data},
                      {"userid": userid},
                      {"lateMarks":await FirebaseFirestore.instance
                          .collection('Users').doc(userid).collection("LateMarks")
                          .get()},
                      {"Feedback":await FirebaseFirestore.instance
                          .collection('Users').doc(userid).collection("Feedback")
                          .get()}
                    ]);
              },
              hoverColor: Colors.teal,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(15),
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                          color: Colors.grey)
                    ]),
                child: Column(
                  children: [
                    Icon(Icons.add_chart_outlined,color: Colors.purpleAccent,size: 80,)
                    ,Text("View all Data",style: GoogleFonts.mulish(),)
                  ],
                ),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
