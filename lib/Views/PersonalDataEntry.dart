import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

import '../Utils/Utils.dart';

class DataEntry extends StatefulWidget {
  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController UniqueId = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController JoiningDate = TextEditingController();
  TextEditingController Salary_gov = TextEditingController();
  TextEditingController Salary_pvt = TextEditingController();
  TextEditingController DailyWorkLoad = TextEditingController();
  TextEditingController Subjects = TextEditingController();
  TextEditingController Classes = TextEditingController();
  TextEditingController Divisions = TextEditingController();
  TextEditingController Papers = TextEditingController();
  TextEditingController Mobile = TextEditingController();

  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

  final controller = Get.put(ControllerState());
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
            "Personal Data-Entry",
            style: GoogleFonts.gugi(color: Colors.white),
          ),
          elevation: 4,
          centerTitle: true,
        ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, size) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: formkey1,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("User Details", size),
                            ResponsiveUserDetails(
                                constraints: size,
                                UniqueId: UniqueId,
                                Name: Name,
                                Mobile: Mobile,
                                JoiningDate: JoiningDate),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("Salary Details", size),
                            ResonsiveSalary(
                                constraint: size,
                                Salary_gov: Salary_gov,
                                Salary_pvt: Salary_pvt,
                                key: formkey1),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("Classes", size),
                            Obx(
                              () => Container(
                                child: ChipsChoice<String>.multiple(
                                  value: controller.classes_real.value
                                      as List<String>,
                                  onChanged: (val) {
                                    controller.classes_real.value = val;
                                  },
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: controller.classes,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                    tooltip: (i, v) => v,
                                  ),
                                  wrapped: true,
                                  textDirection: TextDirection.ltr,
                                  choiceStyle: C2ChoiceStyle(
                                      borderRadius: BorderRadius.circular(5),
                                      margin: EdgeInsets.all(5),
                                      color: Colors.green,
                                      elevation: 4,
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black)),
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
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("Subjects", size),
                            Obx(
                              () => Container(
                                child: ChipsChoice<String>.multiple(
                                  value: controller.subjects_real.value
                                      as List<String>,
                                  onChanged: (val) {
                                    controller.subjects_real.value = val;
                                  },
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: controller.subjects,
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
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black)),
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
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("Divisions", size),
                            Obx(
                              () => Container(
                                child: ChipsChoice<String>.multiple(
                                  value: controller.division_real.value
                                      as List<String>,
                                  onChanged: (val) {
                                    controller.division_real.value = val;
                                  },
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: controller.division,
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
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black)),
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
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                            IconHeading("Papers", size),
                            Obx(
                              () => Container(
                                child: ChipsChoice<String>.multiple(
                                  value: controller.papers_real.value
                                      as List<String>,
                                  onChanged: (val) {
                                    controller.papers_real.value = val;
                                  },
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: controller.papers,
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
                                      labelStyle: GoogleFonts.mulish(
                                          color: Colors.black)),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                if (formkey1.currentState!.validate()) {
                                  controller.ButtonDisabled();
                                  try {
                                    await firestore
                                        .collection("Users")
                                        .add(PersonalDataUpdate(
                                            Userid: UniqueId.text,
                                            Name: Name.text,
                                            Classes:
                                                controller.classes_real.value,
                                            Subjects:
                                                controller.subjects_real.value,
                                            Divisions:
                                                controller.division_real.value,
                                            Papers:
                                                controller.papers_real.value,
                                            JoiningDate: JoiningDate.text,
                                            DailyWorkLoad: DailyWorkLoad.text,
                                            Salary: {
                                              "Salary_gov": Salary_gov.text,
                                              "Salary_pvt": Salary_pvt.text,
                                              "Salary_total": double.parse(
                                                      Salary_gov.text) +
                                                  double.parse(Salary_pvt.text),
                                            },
                                            Mobile: Mobile.text,
                                            Casual_Leave: {
                                              "Casual_Leave_Avaialable": 12,
                                              "Leave_Taken": 0,
                                            },
                                            Duty_Leave: {
                                              "Duty_Leave_Available": 0,
                                              "Leave_Taken": 0
                                            }).toMap())
                                        .then((value) {

                                          HomeBackAlertDialog(context);
                                          controller.ButtonEnabled();

                                    });
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          icon: Icon(Icons.cancel_outlined,color: Colors.red,),
                                          title: Text("Please try again.",style: GoogleFonts.mulish(
                                              color: Colors.black)),
                                          actions: [
                                            IconButton(onPressed: (){
                                              controller.ButtonEnabled();
                                              Get.back();
                                            }, icon:Icon(Icons.arrow_back))
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
          ),
        ),
      ),
    );
  }
}
