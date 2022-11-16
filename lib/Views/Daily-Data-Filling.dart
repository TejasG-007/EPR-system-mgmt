import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Utils/Utils.dart';
import 'package:get/get.dart';

class DailyDataFilling extends StatelessWidget {
  TextEditingController Signature = TextEditingController();
  TextEditingController Remark = TextEditingController();
  TextEditingController DSP = TextEditingController();
  TextEditingController DSC = TextEditingController();
  TextEditingController Uniform = TextEditingController();
  TextEditingController IdCard = TextEditingController();
  TextEditingController duty_Leave = TextEditingController();

  String userid = Get.arguments[0]["userid"];

  final GlobalKey<FormState> _dailyFilling = GlobalKey<FormState>();
  final GlobalKey<FormState> leave = GlobalKey<FormState>();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final controller = Get.put(ControllerState());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "btn2",
          icon: Icon(Icons.touch_app_outlined),
          onPressed: () {
            _key.currentState!.isDrawerOpen
                ? _key.currentState!.closeDrawer()
                : _key.currentState!.openDrawer();
          },
          label: Text("Manage Leaves")),
      appBar: AppBar(
        title: Text("Person Name"),
        actions: [Container()],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      drawer: Drawer(
          child: Container(
        width: MediaQuery.of(context).size.width - 5,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Manage Leaves",
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.bold, color: Colors.purpleAccent),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Back"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  child: Text("Home"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: _firebaseFirestore
                  .collection("Users")
                  .doc(userid)
                  .snapshots(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting &&
                    !snap.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.purpleAccent,
                    color: Colors.teal,
                  );
                } else {
                  PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                      snap.data!.data() as Map<String, dynamic>);
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Available Casual Leaves:${data.Casual_Leave["Casual_Leave_Avaialable"]}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Casual Leaves Taken:${data.Casual_Leave["Leave_Taken"]}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Available Duty Leaves:${data.Duty_Leave["Duty_Leave_Available"]}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total Leaves Available:${data.Casual_Leave["Casual_Leave_Avaialable"] + (data.Duty_Leave["Duty_Leave_Available"] == null ? 0 : data.Duty_Leave["Duty_Leave_Available"])}",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                            Text("Take Casual Leave"),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => controller.isdisabled2.value
                                ? Container(
                                    alignment: Alignment.center,
                                    child:
                                        Text("Please wait while Submitting..."),
                                  )
                                : FloatingActionButton(
                                    backgroundColor: Colors.purpleAccent,
                                    tooltip: "Take Casual Leave",
                                    heroTag: "casual_leave",
                                    onPressed: () async {
                                      if(data.Casual_Leave["Casual_Leave_Avaialable"]==0){
                                        showDialog(context: context, builder:(context)=> AlertDialog(
                                          title: Text("No Casual Leave Available",style: GoogleFonts.mulish(),),
                                          icon: Icon(Icons.warning,color: Colors.red,),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Back"),
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10))),
                                            ),
                                          ],
                                        ));
                                      }else{
                                      controller.ButtonDisabled2();
                                      await _firebaseFirestore
                                          .collection("Users")
                                          .doc(userid)
                                          .update({
                                        "Casual_Leave": {
                                          "Casual_Leave_Avaialable": (data
                                                      .Casual_Leave[
                                                  "Casual_Leave_Avaialable"] -
                                              1),
                                          "Leave_Taken":
                                              data.Casual_Leave["Leave_Taken"] +
                                                  1,
                                        }
                                      }).then((value) {
                                        Scaffold.of(context).closeDrawer();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Casual Leave Taken Successfully.")));
                                        controller.ButtonEnabled2();
                                      });}
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline_outlined,
                                      color: Colors.white,
                                    ))),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                            Text("Add Duty Leave"),
                            Form(
                              key: leave,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                          "Duty Leave should not be null"),
                                  PatternValidator(r'^[0-9]+$',
                                      errorText:
                                          "Duty Leave should be in Integer only.")
                                ]),
                                cursorRadius: const Radius.circular(3),
                                cursorColor: Colors.purpleAccent,
                                controller: duty_Leave,
                                decoration: InputDecoration(
                                  labelText: "Add Duty Leave",
                                  labelStyle:
                                      GoogleFonts.mulish(color: Colors.green),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.purpleAccent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.green)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => controller.isdisabled.value
                                ? Container(
                                    alignment: Alignment.center,
                                    child:
                                        Text("Please wait while Submitting..."),
                                  )
                                : FloatingActionButton(
                                    backgroundColor: Colors.purpleAccent,
                                    tooltip: "Add Duty Leave",
                                    heroTag: "duty_leave",
                                    onPressed: () async {
                                      if (leave.currentState!.validate()) {
                                        controller.ButtonDisabled();
                                        await _firebaseFirestore
                                            .collection("Users")
                                            .doc(userid)
                                            .update({
                                          "Duty_Leave": {
                                            "Duty_Leave_Available":
                                                int.parse(duty_Leave.text),
                                            "Leave_Taken":
                                                data.Duty_Leave["Leave_Taken"],
                                          }
                                        }).then((value) {
                                          Scaffold.of(context).closeDrawer();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "${duty_Leave.text} Duty Leave Added Successfully.")));
                                          controller.ButtonEnabled();
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: Colors.white,
                                    ))),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                            Text("Take Duty Leave"),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => controller.isdisabled3.value
                                ? Container(
                              alignment: Alignment.center,
                              child:
                              Text("Please wait while Submitting..."),
                            )
                                : FloatingActionButton(
                                backgroundColor: Colors.purpleAccent,
                                tooltip: "Take Duty Leave",
                                heroTag: "take duty leave",
                                onPressed: () async {
                                  if(data.Duty_Leave["Duty_Leave_Available"]==0){
                                    showDialog(context: context, builder:(context)=> AlertDialog(
                                      title: Text("No Duty Leave Available",style: GoogleFonts.mulish(),),
                                      icon: Icon(Icons.warning,color: Colors.red,),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("Back"),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10))),
                                        ),
                                      ],
                                    ));
                                  }else{
                                  controller.ButtonDisabled3();
                                  await _firebaseFirestore
                                      .collection("Users")
                                      .doc(userid)
                                      .update({
                                    "Duty_Leave": {
                                      "Duty_Leave_Available": (data
                                          .Duty_Leave[
                                      "Duty_Leave_Available"]-1),
                                      "Leave_Taken":
                                      (data.Duty_Leave["Leave_Taken"] +
                                          1),
                                    }
                                  }).then((value) {
                                    Scaffold.of(context).closeDrawer();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            "Duty Leave Taken Successfully.")));
                                    controller.ButtonEnabled3();
                                  });}
                                },
                                child: Icon(
                                  Icons.remove_circle_outline_outlined,
                                  color: Colors.white,
                                ))),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      )),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) => Container(
          child: Form(
            key: _dailyFilling,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                ResponsiveDailyDataDetails(
                  constraints: size,
                  Remark: Remark,
                  DSP: DSP,
                  DSC: DSC,
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() => controller.isdisabled.value
                    ? Container(
                        alignment: Alignment.center,
                        child: Text("Please wait while Submitting..."),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent,
                                elevation: 10,
                                textStyle:
                                    GoogleFonts.mulish(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (_dailyFilling.currentState!.validate()) {
                                controller.ButtonDisabled();
                                try {
                                  await _firebaseFirestore
                                      .collection("Users")
                                      .doc(userid)
                                      .collection("DailyUpdate")
                                      .doc(DateTime.now()
                                          .toString()
                                          .substring(0, 11))
                                      .set(DailyUpdate(
                                              Signature:
                                                  controller.Signature.value,
                                              Remark: Remark.text,
                                              DSP: DSP.text,
                                              DSC: DSC.text,
                                              Uniform: controller.Uniform.value,
                                              IdCard: controller.Id_card.value)
                                          .toMap())
                                      .then((value) {
                                    HomeBackAlertDialog(context);
                                    controller.ButtonEnabled();
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
                                                    controller.ButtonEnabled();
                                                    Get.back();
                                                  },
                                                  icon: Icon(Icons.arrow_back))
                                            ],
                                          ));
                                }
                              }
                            },
                            child: Text(
                              "Submit",
                              style: GoogleFonts.mulish(color: Colors.white),
                            )),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
