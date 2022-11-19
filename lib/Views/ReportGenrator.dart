import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/FeedbackUpdate.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Modal/LateMarks.dart';

class ReportGenerator extends StatefulWidget {
  @override
  State<ReportGenerator> createState() => _ReportGeneratorState();
}

class _ReportGeneratorState extends State<ReportGenerator> {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final controller = Get.put(ControllerState());

  Future<List<FeedbackUpdate>> getFeedbackData(String userid) async {
    var data = await _firebaseFirestore
        .collection("Users")
        .doc(userid)
        .collection("Feedback")
        .get();
    var mainData =
        data.docs.map((e) => FeedbackUpdate.fromMap(e.data())).toList();
    return mainData; //All Feedback Data in list format
  }

  Future<Iterable<Iterable<LateMarks>>> getLateMarkData(String userid) async {
    var data = await _firebaseFirestore
        .collection("Users")
        .doc(userid)
        .collection("LateMarks")
        .get();
    var mainData = data.docs.map((e) =>
        e.data().entries.toList().map((e) => LateMarks.fromMap(e.value)));
    return mainData; //All Feedback Data in list format
  }

  Future<List<DailyUpdate>> getDailyUpdateData(String userid) async {
    var data = await _firebaseFirestore
        .collection("Users")
        .doc(userid)
        .collection("DailyUpdate")
        .get();
    var mainData = data.docs.map((e) => DailyUpdate.fromMap(e.data())).toList();
    return mainData; //All Feedback Data in list format
  }

  @override
  void initState() {
    // TODO: implement initState
    controller.feedbackDataR.clear();
    controller.feedbackDate.clear();
    controller.LateMarksDataR.clear();
    controller.LateMarksDate.clear();
    controller.DailyDataEntryR.clear();
    controller.DailyUpdateDate.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Report Generator",
          style: GoogleFonts.gugi(color: Colors.white),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _firebaseFirestore.collection("Users").snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.active) {
            var data = snap.data!.docs;
            String singlePersonid = data.map((e) => e.id).first;
            controller.value.value = singlePersonid;
            return snap.hasData
                ? ListView(
                    shrinkWrap: true,
                    children: [
                      Obx(() => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: const Border(
                                    top: BorderSide(width: 1),
                                    left: BorderSide(width: 1),
                                    bottom: BorderSide(width: 1),
                                    right: BorderSide(width: 1))),
                            child: DropdownButton(
                              isDense: true,
                              iconEnabledColor: Colors.green,
                              value: controller.value.value,
                              borderRadius: BorderRadius.circular(10),
                              enableFeedback: true,
                              icon: Icon(Icons.person),
                              items: data
                                  .map((e) => DropdownMenuItem(
                                        child: Text(
                                            "${PersonalDataUpdate.fromMap(e.data()).Name.toString()}"),
                                        value: e.id,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.value.value = value!;
                                controller.feedbackDate.clear();
                              },
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: getFeedbackData(singlePersonid),
                          builder: (context, data) {
                            sortingofFeedback() {
                              try {
                                if (data.hasData) {
                                  for (var item in data.data!) {
                                    if (DateTime.parse(item.feedback_date.removeAllWhitespace)
                                            .isAfter(DateTime.parse(controller
                                                    .feedbackDate[0]
                                                    .removeAllWhitespace)
                                                .subtract(Duration(days: 1))) &&
                                        DateTime.parse(item.feedback_date
                                                .removeAllWhitespace)
                                            .isBefore(DateTime.parse(controller
                                                    .feedbackDate[1]
                                                    .removeAllWhitespace)
                                                .add(Duration(days: 1)))) {
                                      controller.feedbackDataR.add(item);
                                    }
                                  }
                                }
                              } catch (e) {
                                print("Facing Error $e");
                              }
                            }

                            return data.hasData
                                ? Column(
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () async {
                                          var result =
                                              (await showCalendarDatePicker2Dialog(
                                            context: context,
                                            config:
                                                CalendarDatePicker2WithActionButtonsConfig(
                                                    calendarType:
                                                        CalendarDatePicker2Type
                                                            .range),
                                            dialogSize: const Size(325, 400),
                                            initialValue: [],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ));

                                          controller.getFeedbackDate(result);
                                          controller.feedbackDataR.clear();
                                        },
                                        icon: Icon(
                                          Icons.date_range_outlined,
                                        ),
                                        label: Text(
                                            "Select Date Range for Feedback"),
                                      ),
                                      Container(
                                          child: Obx(() => Text(
                                              "Selected Date Range - ${controller.feedbackDate.toString().replaceAll("]", "").replaceAll(",", "-").replaceAll("[", "")}"))),
                                      Obx(
                                        () => controller.feedbackDate.isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  controller
                                                          .feedbackDataR.isEmpty
                                                      ? ElevatedButton.icon(
                                                          label: Text(
                                                              "Add Feedback"),
                                                          icon: Icon(Icons
                                                              .add_box_rounded),
                                                          onPressed: () {
                                                            //print(controller.feedbackDataR);
                                                            if (controller
                                                                .feedbackDate
                                                                .isNotEmpty) {
                                                              Future.delayed(
                                                                      Duration(
                                                                          microseconds:
                                                                              1))
                                                                  .then((value) =>
                                                                      sortingofFeedback())
                                                                  .then(
                                                                      (value) {
                                                                if (controller
                                                                        .feedbackDate
                                                                        .isNotEmpty &&
                                                                    controller
                                                                        .feedbackDataR
                                                                        .isEmpty) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              const AlertDialog(
                                                                                title: Icon(
                                                                                  Icons.warning,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                content: Text("No Data Found in Selected Range"),
                                                                              ));
                                                                }
                                                              });
                                                            }
                                                          },
                                                        )
                                                      : Container(
                                                          child: const Text(
                                                            "Feedback Data Added",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                  controller
                                                          .feedbackDataR.isEmpty
                                                      ? Container()
                                                      : IconButton(
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            controller
                                                                .feedbackDataR
                                                                .clear();
                                                            print(controller
                                                                .feedbackDataR);
                                                          },
                                                        ),
                                                ],
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    width: 200,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          Colors.purpleAccent.shade100,
                                      color: Colors.purple,
                                    ),
                                  );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getLateMarkData(singlePersonid),
                          builder: (context, data) {
                            sortingofLateMarks() {
                              try {
                                if (data.hasData) {
                                  for (var item in data.data!.elementAt(0)) {
                                    if (DateTime.parse(
                                                item.Date.removeAllWhitespace)
                                            .isAfter(DateTime.parse(controller
                                                    .LateMarksDate[0]
                                                    .removeAllWhitespace)
                                                .subtract(Duration(days: 1))) &&
                                        DateTime.parse(
                                                item.Date.removeAllWhitespace)
                                            .isBefore(DateTime.parse(controller
                                                    .LateMarksDate[1]
                                                    .removeAllWhitespace)
                                                .add(Duration(days: 1)))) {
                                      controller.LateMarksDataR.add(item);
                                    }
                                  }
                                }
                              } catch (e) {
                                print("Facing Error $e");
                              }
                            }

                            return data.hasData
                                ? Column(
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () async {
                                          var result =
                                              (await showCalendarDatePicker2Dialog(
                                            context: context,
                                            config:
                                                CalendarDatePicker2WithActionButtonsConfig(
                                                    calendarType:
                                                        CalendarDatePicker2Type
                                                            .range),
                                            dialogSize: const Size(325, 400),
                                            initialValue: [],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ));

                                          controller.getLateMarksDate(result);
                                          controller.LateMarksDataR.clear();
                                        },
                                        icon: Icon(
                                          Icons.date_range_outlined,
                                        ),
                                        label: Text(
                                            "Select Date Range for LateMarks"),
                                      ),
                                      Container(
                                          child: Obx(() => Text(
                                              "Selected Date Range - ${controller.LateMarksDate.toString().replaceAll("]", "").replaceAll(",", "-").replaceAll("[", "")}"))),
                                      Obx(
                                        () => controller
                                                .LateMarksDate.isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  controller.LateMarksDataR
                                                          .isEmpty
                                                      ? ElevatedButton.icon(
                                                          label: Text(
                                                              "Add Late-Marks Data"),
                                                          icon: Icon(Icons
                                                              .add_box_rounded),
                                                          onPressed: () {
                                                            //print(controller.feedbackDataR);
                                                            if (controller
                                                                .LateMarksDate
                                                                .isNotEmpty) {
                                                              Future.delayed(
                                                                      Duration(
                                                                          microseconds:
                                                                              1))
                                                                  .then((value) =>
                                                                      sortingofLateMarks())
                                                                  .then(
                                                                      (value) {
                                                                if (controller
                                                                        .LateMarksDate
                                                                        .isNotEmpty &&
                                                                    controller
                                                                        .LateMarksDataR
                                                                        .isEmpty) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              const AlertDialog(
                                                                                title: Icon(
                                                                                  Icons.warning,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                content: Text("No Data Found in Selected Range"),
                                                                              ));
                                                                }
                                                              });
                                                            }
                                                          },
                                                        )
                                                      : Container(
                                                          child: const Text(
                                                            "LateMarks Data Added ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                  controller.LateMarksDataR
                                                          .isEmpty
                                                      ? Container()
                                                      : IconButton(
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            controller
                                                                    .LateMarksDataR
                                                                .clear();
                                                            print(controller
                                                                .LateMarksDataR);
                                                          },
                                                        ),
                                                ],
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    width: 200,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          Colors.purpleAccent.shade100,
                                      color: Colors.purple,
                                    ),
                                  );
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: getDailyUpdateData(singlePersonid),
                          builder: (context, data) {
                            sortingofFeedback() {
                              if (data.hasData) {
                                for (var item in data.data!) {
                                  if (DateTime.parse(
                                              item.Date.removeAllWhitespace)
                                          .isAfter(DateTime.parse(controller
                                                  .DailyUpdateDate[0]
                                                  .removeAllWhitespace)
                                              .subtract(Duration(days: 1))) &&
                                      DateTime.parse(
                                              item.Date.removeAllWhitespace)
                                          .isBefore(DateTime.parse(controller
                                                  .DailyUpdateDate[1]
                                                  .removeAllWhitespace)
                                              .add(Duration(days: 1)))) {
                                    controller.DailyDataEntryR.add(item);
                                  }
                                }
                              }
                            }

                            return data.hasData
                                ? Column(
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () async {
                                          var result =
                                              (await showCalendarDatePicker2Dialog(
                                            context: context,
                                            config:
                                                CalendarDatePicker2WithActionButtonsConfig(
                                                    calendarType:
                                                        CalendarDatePicker2Type
                                                            .range),
                                            dialogSize: const Size(325, 400),
                                            initialValue: [],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ));

                                          controller.getDailyUpdateDate(result);
                                          controller.DailyDataEntryR.clear();
                                        },
                                        icon: Icon(
                                          Icons.date_range_outlined,
                                        ),
                                        label: const Text(
                                            "Select Date Range for Daily-Data-Update"),
                                      ),
                                      Container(
                                          child: Obx(() => Text(
                                              "Selected Date Range - ${controller.DailyUpdateDate.toString().replaceAll("]", "").replaceAll(",", "-").replaceAll("[", "")}"))),
                                      Obx(
                                        () => controller
                                                .DailyUpdateDate.isNotEmpty
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  controller.DailyDataEntryR
                                                          .isEmpty
                                                      ? ElevatedButton.icon(
                                                          label: Text(
                                                              "Add Daily Data"),
                                                          icon: Icon(Icons
                                                              .add_box_rounded),
                                                          onPressed: () {
                                                            //print(controller.feedbackDataR);
                                                            if (controller
                                                                .DailyUpdateDate
                                                                .isNotEmpty) {
                                                              Future.delayed(
                                                                      Duration(
                                                                          microseconds:
                                                                              1))
                                                                  .then((value) =>
                                                                      sortingofFeedback())
                                                                  .then(
                                                                      (value) {
                                                                if (controller
                                                                        .DailyUpdateDate
                                                                        .isNotEmpty &&
                                                                    controller
                                                                        .DailyDataEntryR
                                                                        .isEmpty) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              const AlertDialog(
                                                                                title: Icon(
                                                                                  Icons.warning,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                content: Text("No Data Found in Selected Range"),
                                                                              ));
                                                                }
                                                              });
                                                            }
                                                          },
                                                        )
                                                      : Container(
                                                          child: const Text(
                                                            "Daily-Data-Update Data Added",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ),
                                                  controller.DailyDataEntryR
                                                          .isEmpty
                                                      ? Container()
                                                      : IconButton(
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          onPressed: () {
                                                            controller
                                                                    .DailyDataEntryR
                                                                .clear();
                                                            print(controller
                                                                .DailyDataEntryR);
                                                          },
                                                        ),
                                                ],
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    width: 200,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          Colors.purpleAccent.shade100,
                                      color: Colors.purple,
                                    ),
                                  );
                          }),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            label: Text("Proceed with Selected data"),
                            onPressed: () {
                              print(controller.DailyDataEntryR);
                              print(controller.feedbackDataR);
                              print(controller.LateMarksDataR);
                              Get.toNamed("/showReportVdata", arguments: [
                                {"userid": singlePersonid},
                                {"feedback": controller.feedbackDataR},
                                {"latemarks": controller.LateMarksDataR},
                                {"dailydata": controller.DailyDataEntryR}
                              ]);
                            },
                            icon: Icon(Icons.add_chart_outlined)),
                      )
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.purpleAccent.shade100,
                    color: Colors.purple,
                  ));
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.purpleAccent.shade100,
              color: Colors.purple,
            ));
          }
        },
      ),
    );
  }
}
