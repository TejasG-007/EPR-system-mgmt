import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

import 'PdfGenerator.dart';

class ShowPersonalData extends StatefulWidget {
  @override
  State<ShowPersonalData> createState() => _ShowPersonalDataState();
}

class _ShowPersonalDataState extends State<ShowPersonalData> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PersonalDataUpdate data = Get.arguments[0]["Personal data"];
  String userid = Get.arguments[1]["userid"];

  final controller = Get.put(ControllerState());

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userid)
                  .collection("DailyUpdate")
                  .snapshots(),
              builder: (context, snap) {
                if(snap.hasData){
                  return PdfPreview(
                    build: (context) => pdfGenerator(data, userid,snap.data!.size==0?null:snap.data!.docs),
                  );
                }else{
                  return LinearProgressIndicator();}
              }),
        ),
      );
    } catch (e) {
      return Center(
        child: Text("Page Not Found$e"),
      );
    }
  }
}
