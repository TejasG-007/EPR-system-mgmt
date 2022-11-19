import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/FeedbackUpdate.dart';
import 'package:techer_mgmt/Modal/LateMarks.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

import 'ReportViewer.dart';

class showReportVdata extends StatelessWidget {
  String  userid = Get.arguments[0]["userid"];
  List<FeedbackUpdate> feedback = Get.arguments[1]["feedback"];
  List<LateMarks> latemarks = Get.arguments[2]["latemarks"];
  List<DailyUpdate> dailydata = Get.arguments[3]["dailydata"];

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userid).snapshots(),
              builder: (context, snap) {
                if(snap.hasData){

                  return PdfPreview(
                      build: (context) => ReportViewer(personalData:snap.data!.data(),id:userid,feedback: feedback,dailyData: dailydata,lateMarks: latemarks
                      )
                  );
                }else{
                  return LinearProgressIndicator();}
              }),));
    } catch (e) {
      return Center(
        child: Text("Page Not Found$e"),
      );
    }
  }
}
