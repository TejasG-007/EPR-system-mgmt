import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Modal/FeedbackUpdate.dart';
import '../Utils/Utils.dart';

class FeedbackEntry extends StatelessWidget {
  TextEditingController feedback_oral = TextEditingController();
  TextEditingController feedback_written = TextEditingController();
  TextEditingController feedback_date = TextEditingController();

   CollectionReference<Map<String, dynamic>> _firebaseFirestore = FirebaseFirestore.instance.collection("Users");

  String userid = Get.arguments[1]["userid"];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback Entry"),
          centerTitle: true,
        ),
        body: LayoutBuilder(
            builder: (context, size) => SingleChildScrollView(
              child: Column(
                    children: [
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
                                              .set(FeedbackUpdate(
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
