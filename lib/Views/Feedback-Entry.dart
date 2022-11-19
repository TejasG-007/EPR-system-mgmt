import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Modal/FeedbackUpdate.dart';
import '../Modal/PersonalUpdate.dart';
import '../Utils/Utils.dart';

class FeedbackEntry extends StatefulWidget {
  @override
  State<FeedbackEntry> createState() => _FeedbackEntryState();
}

class _FeedbackEntryState extends State<FeedbackEntry> {
  TextEditingController feedback_oral = TextEditingController();

  TextEditingController feedback_written = TextEditingController();

  TextEditingController feedback_date = TextEditingController();

   CollectionReference<Map<String, dynamic>> _firebaseFirestore = FirebaseFirestore.instance.collection("Users");

  String userid = Get.arguments[1]["userid"];
  PersonalDataUpdate data = Get.arguments[0]["Personal-data"];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data.Classes != null && data.Divisions != null) {
        controller.divisionfromFirebase.clear();
        controller.classesfromFirebase.clear();
        data.Classes.map(
                (e) => controller.classesfromFirebase.add(e.toString())).toList();
        data.Divisions.map(
                (e) => controller.divisionfromFirebase.add(e.toString())).toList();
        controller.firebaseClass.value = controller.classesfromFirebase[0];
        controller.firebaseDivision.value = controller.divisionfromFirebase[0];
      }
    });

    super.initState();
  }
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
            "Feedback-Entry",
            style: GoogleFonts.gugi(color: Colors.white),
          ),
          elevation: 4,
          centerTitle: true,
        ),
        body: LayoutBuilder(
            builder: (context, size) => SingleChildScrollView(
              child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(

                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: .7,
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.inner,
                                  offset: Offset(1, 1))
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Select Classes from Below",
                              style: GoogleFonts.nunito(),
                            ),
                            Obx(
                                  () => Container(
                                child: ChipsChoice<String>.single(
                                  value: controller.firebaseClass.value,
                                  onChanged: (val) {
                                    controller.firebaseClass.value = val;
                                    //print(controller.firebaseClass.value);
                                  },
                                  choiceItems: C2Choice.listFrom<String, String>(
                                    source: controller.classesfromFirebase,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                    tooltip: (i, v) => v,
                                  ),
                                  wrapped: true,
                                  textDirection: TextDirection.rtl,
                                  choiceStyle: C2ChoiceStyle(
                                      borderRadius: BorderRadius.circular(5),
                                      margin: EdgeInsets.all(5),
                                      color: Colors.green,
                                      elevation: 4,
                                      labelStyle:
                                      GoogleFonts.mulish(color: Colors.black)),
                                  choiceActiveStyle: C2ChoiceStyle(
                                      showCheckmark: true,
                                      borderRadius: BorderRadius.circular(5),
                                      margin: EdgeInsets.all(5),
                                      borderColor: Colors.green,
                                      elevation: 4,
                                      color: Colors.purpleAccent,
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: .7,
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.inner,
                                  offset: Offset(1, 1))
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "Select Division from Below",
                              style: GoogleFonts.nunito(),
                            ),
                            Obx(
                                  () => Container(
                                child: ChipsChoice<String>.single(
                                  value: controller.firebaseDivision.value,
                                  onChanged: (val) {
                                    controller.firebaseDivision.value = val;
                                   // print(controller.firebaseDivision.value);
                                  },
                                  choiceItems: C2Choice.listFrom<String, String>(
                                    source: controller.divisionfromFirebase,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                    tooltip: (i, v) => v,
                                  ),
                                  wrapped: true,
                                  textDirection: TextDirection.rtl,
                                  choiceStyle: C2ChoiceStyle(
                                      borderRadius: BorderRadius.circular(5),
                                      margin: EdgeInsets.all(5),
                                      color: Colors.green,
                                      elevation: 4,
                                      labelStyle:
                                      GoogleFonts.mulish(color: Colors.black)),
                                  choiceActiveStyle: C2ChoiceStyle(
                                      showCheckmark: true,
                                      borderRadius: BorderRadius.circular(5),
                                      margin: EdgeInsets.all(5),
                                      borderColor: Colors.green,
                                      elevation: 4,
                                      color: Colors.purpleAccent,
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formkey,
                        child: ResponsiveFeedback(
                          constraints: size,
                          Feedback_oral: feedback_oral,
                          Feedback_written: feedback_written,
                          Feedback_Date: feedback_date),),
                      Obx(() => Container(
                            margin: EdgeInsets.all(10),
                            child: controller.isdisabled.value
                                ? Container(
                                    height: 25,
                                    width: 25,
                                    child: const CircularProgressIndicator(
                                      color: Colors.purpleAccent,
                                    ),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () async {
                                      if(_formkey.currentState!.validate()){
                                        controller.ButtonDisabled();
                                        try {
                                          await _firebaseFirestore
                                              .doc(userid)
                                              .collection("Feedback")
                                              .doc(DateTime.now().millisecondsSinceEpoch.toString())
                                              .set(
                                              FeedbackUpdate(
                                                Division: controller.firebaseClass.value,
                                              Class: controller.firebaseDivision.value,
                                              feedback_date:
                                              feedback_date.text,
                                              feedback_written:
                                              feedback_written.text,
                                              feedback_oral:
                                              feedback_oral.text)
                                              .toMap()).then((value){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Feedback submitted Successfully...")));
                                            Get.back();
                                          });
                                          controller.ButtonEnabled();
                                        } catch (e) {
                                          controller.ButtonEnabled();
                                          return showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                icon: const Icon(
                                                  Icons.warning,
                                                  color: Colors.red,
                                                ),
                                                title: Text(
                                                  "Please try again later...",
                                                  style: GoogleFonts.mulish(
                                                      color: Colors.black),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10))),
                                                    onPressed: () {
                                                      Get.toNamed('/home');
                                                    },
                                                    child: Text(
                                                      "Home",
                                                      style:
                                                      GoogleFonts.mulish(),
                                                    ),
                                                  )
                                                ],
                                              ));
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.mulish(),
                                    ),
                                  ),
                          ))
                    ],
                  ),
            )));
  }
}
