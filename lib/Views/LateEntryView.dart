import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/LateMarks.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

class LateEntry extends StatefulWidget {
  @override
  State<LateEntry> createState() => _LateEntryState();
}

class _LateEntryState extends State<LateEntry> {
  PersonalDataUpdate data = Get.arguments[0]["Personal-data"];

  String userid = Get.arguments[1]["userid"];

  var controller = Get.put(ControllerState());

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
        title: Text(
          "Late Entry",
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      //View all late entry in bottomsheet
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Select Class and Division from Below for adding Late Marks"),
              SizedBox(height: 20,),
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
                            print(controller.firebaseClass.value);
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
                            print(controller.firebaseDivision.value);
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
              Obx(() => controller.isdisabled.value
                  ? Container(
                alignment: Alignment.center,
                child: Text("Please wait while Submitting..."),
              )
                  : Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        elevation: 10,
                        textStyle:
                        GoogleFonts.mulish(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10))),
                    onPressed: () async {
                      if (!controller.firebaseDivision.isEmpty) {
                        controller.ButtonDisabled();
                        try {
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .doc(userid)
                              .collection("LateMarks")
                              .doc(DateTime.now()
                              .toString()
                              .substring(0, 11))
                              .get()
                              .then((doc) {
                            if (doc.exists) {
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(userid)
                                  .collection("LateMarks")
                                  .doc(DateTime.now()
                                  .toString()
                                  .substring(0, 11))
                                  .update({
                                DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(): LateMarks(
                                    Division: controller
                                        .firebaseDivision
                                        .toString(),
                                    Class: controller
                                        .firebaseClass
                                        .toString())
                                    .toMap()
                              }).then((value) {
                                showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        "Submitted Successfully.",
                                        style: GoogleFonts
                                            .mulish(
                                            color: Colors
                                                .black),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Add more",
                                            style: GoogleFonts
                                                .mulish(),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))),
                                          onPressed: () {
                                            Get.toNamed(
                                                '/home');
                                          },
                                          child: Text(
                                            "Home",
                                            style: GoogleFonts
                                                .mulish(),
                                          ),
                                        )
                                      ],
                                    ));
                                controller.ButtonEnabled();
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(userid)
                                  .collection("LateMarks")
                                  .doc(DateTime.now()
                                  .toString()
                                  .substring(0, 11))
                                  .set({
                                DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(): LateMarks(
                                    Division: controller
                                        .firebaseDivision
                                        .toString(),
                                    Class: controller
                                        .firebaseClass
                                        .toString())
                                    .toMap()
                              }).then((value) {
                                showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                      icon: Icon(
                                        Icons.done,
                                        color: Colors.green,
                                      ),
                                      title: Text(
                                        "Submitted Successfully.",
                                        style: GoogleFonts
                                            .mulish(
                                            color: Colors
                                                .black),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text(
                                            "Add more",
                                            style: GoogleFonts
                                                .mulish(),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10))),
                                          onPressed: () {
                                            Get.toNamed(
                                                '/home');
                                          },
                                          child: Text(
                                            "Home",
                                            style: GoogleFonts
                                                .mulish(),
                                          ),
                                        )
                                      ],
                                    ));
                                controller.ButtonEnabled();
                              });
                            }
                          });
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                                title: Text("Please try again.",
                                    style: GoogleFonts.mulish(
                                        color: Colors.black)),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        controller
                                            .ButtonEnabled();
                                        Get.back();
                                      },
                                      icon: Icon(
                                          Icons.arrow_back))
                                ],
                              ));
                        }
                      }
                    },
                    child: Text(
                      "Submit",
                      style:
                      GoogleFonts.mulish(color: Colors.white),
                    )),
              ))
            ],
          ),
        ),
      )
    );
  }
}
