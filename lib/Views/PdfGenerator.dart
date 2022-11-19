import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:techer_mgmt/Modal/FeedbackUpdate.dart';
import 'package:techer_mgmt/Modal/LateMarks.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Modal/DailyUpdate.dart';

Future<Uint8List> pdfGenerator(PersonalDataUpdate data, String id,
    var dailyData, QuerySnapshot<Map<String, dynamic>>? lateMarks, QuerySnapshot<Map<String, dynamic>>? feedback) {
  int LateMarksCount = 0;
  int UnifromCount = 0;
  int IdcardCount = 0;
  int SignCount = 0;
  int totalDailyDataEntryCount = 0;
  final pdf = Document();
  pdf.addPage(MultiPage(
      build: (Context context) => [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Employee Details",
                      style: TextStyle(
                        color: PdfColors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Employee id"),
                Text(" : "),
                Text(data.Userid),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Name"),
                Text(" : "),
                Text(data.Name),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("JoiningDate"),
                Text(" : "),
                Text(data.JoiningDate),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Mobile"),
                Text(" : "),
                Text(data.Mobile),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Classes"),
                Text(" : "),
                Text(data.Classes.toString()
                    .replaceAll("[", " ")
                    .replaceAll("]", " ")),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Subjects"),
                Text(" : "),
                Text(data.Subjects.toString()
                    .replaceAll("[", " ")
                    .replaceAll("]", " ")),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Divisions"),
                Text(" : "),
                Text(data.Divisions.toString()
                    .replaceAll("[", " ")
                    .replaceAll("]", " ")),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Papers"),
                Text(" : "),
                Text(data.Papers.toString()
                    .replaceAll("[", " ")
                    .replaceAll("]", " ")),
              ]),
              SizedBox(height: 10),
              Divider(indent: 10, endIndent: 10, height: .4),
              SizedBox(height: 10),
              Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Salary",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.teal)),
                ]),
                SizedBox(height: 10),
                Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...data.Salary.keys.toList().map((e) => TableRow(
                              children: [
                                Padding(
                                    child: Text("${e} : ${data.Salary[e]}"),
                                    padding: EdgeInsets.all(5))
                              ]))
                    ])
              ]),
              SizedBox(height: 10),
              Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Casual Leaves",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.teal)),
                ]),
                SizedBox(height: 10),
                Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...data.Casual_Leave.keys
                          .toList()
                          .map((e) => TableRow(children: [
                                Padding(
                                    child:
                                        Text("${e} : ${data.Casual_Leave[e]}"),
                                    padding: EdgeInsets.all(5))
                              ]))
                    ])
              ]),
              SizedBox(height: 10),
              Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text("Duty Leaves",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: PdfColors.teal)),
                ]),
                SizedBox(height: 10),
                Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      ...data.Duty_Leave.keys.toList().map((e) => TableRow(
                              children: [
                                Padding(
                                    child: Text("${e} : ${data.Duty_Leave[e]}"),
                                    padding: EdgeInsets.all(5))
                              ]))
                    ]),
              ]),
              SizedBox(height: 10),
              Divider(indent: 10, endIndent: 10, height: .4),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(children: [  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Daily Updated Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PdfColors.purpleAccent)),
              ]),
                SizedBox(height: 10),
                dailyData == null
                    ? Text("No Daily Update Record Found.")
                    : Table(
                    border: TableBorder.all(color: PdfColors.black),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text("Date",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("Uniform",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("Signature",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("Remark",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("DSC",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("DSP",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("IdCard",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                      ]),
                      ...dailyData.map((e) {
                        DailyUpdate dd = DailyUpdate.fromMap(e.data());
                        if(dd.Uniform=="YES"){
                          UnifromCount++;
                        }
                        if(dd.IdCard=="YES"){
                          IdcardCount++;
                        }
                        if(dd.Signature=="YES"){
                          SignCount++;
                        }

                        totalDailyDataEntryCount++;
                        return TableRow(children: [
                          Column(children: [
                            Text("${e.id}",
                                style: TextStyle(
                                    color: PdfColors.cyan,
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [Text("${dd.Uniform}")]),
                          Column(children: [Text("${dd.Signature}")]),
                          Column(children: [Text("${dd.Remark}")]),
                          Column(children: [Text("${dd.DSC}")]),
                          Column(children: [Text("${dd.DSP}")]),
                          Column(children: [Text("${dd.IdCard}")]),
                        ]);

                      }),
                      dailyData == null?TableRow(children: []):TableRow(children: [
                        Column(children: [
                          Text("Total/Percentage",
                              style:
                              TextStyle(fontWeight: FontWeight.bold,color: PdfColors.red))
                        ]),
                        Column(children: [
                          Text("$UnifromCount/${((UnifromCount/totalDailyDataEntryCount)*100)==0 || ((UnifromCount/totalDailyDataEntryCount)*100)==100?((UnifromCount/totalDailyDataEntryCount)*100):((UnifromCount/totalDailyDataEntryCount)*100).toString().substring(0,2)}",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("$SignCount/${((SignCount/totalDailyDataEntryCount)*100)==0 || ((SignCount/totalDailyDataEntryCount)*100)==100?((SignCount/totalDailyDataEntryCount)*100):((SignCount/totalDailyDataEntryCount)*100).toString().substring(0,2)}",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("-",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("-",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("-",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                        Column(children: [
                          Text("$IdcardCount/${((IdcardCount/totalDailyDataEntryCount)*100)==0 || ((IdcardCount/totalDailyDataEntryCount)*100)==100?((IdcardCount/totalDailyDataEntryCount)*100):((IdcardCount/totalDailyDataEntryCount)*100).toString().substring(0,2)}",
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ]),
                      ]),
                    ]),])),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(children: [
                  SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Late Marks",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PdfColors.purpleAccent)),
                  ]),
                  SizedBox(height: 10),
                  lateMarks == null
                      ? Text("No Late Mark Record Found.")
                      : Table(
                      border: TableBorder.all(color: PdfColors.black),
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            Column(children: [
                              Text("Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))
                            ]),
                            Column(children: [
                              Text("Class & Division",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))
                            ]),
                          ],
                        ),
                        ...lateMarks.docs.map((e) {
                          LateMarksCount += e.data().length;
                          return TableRow(children: [
                            Column(children: [
                              Text("${e.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: PdfColors.teal))
                            ]),
                            Column(children: [
                              Table(
                                  border: TableBorder.all(
                                      color: PdfColors.black),
                                  children: [
                                    ...e.data().entries.map((e) {
                                      LateMarks data =
                                      LateMarks.fromMap(e.value);
                                      return TableRow(children: [
                                        Column(children: [
                                          Text("${data.Class}")
                                        ]),
                                        Column(children: [
                                          Text("${data.Division}")
                                        ]),
                                      ]);
                                    })
                                  ])
                            ]),
                          ]);
                        })
                      ]),
                ]),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                lateMarks == null
                    ? Container()
                    : Text("Total Late-Marks: $LateMarksCount",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: PdfColors.red))
              ]),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Feedback Records",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PdfColors.purpleAccent)),
              ]),
                SizedBox(height: 10),
                feedback == null
                    ? Text("No Feedback Record Found.")
                    : Table(
                    border: TableBorder.all(color: PdfColors.black),
                    defaultVerticalAlignment:
                    TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          Column(children: [
                            Text("Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("Division",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("Class",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("Oral-Feedback",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("Written-Feedback",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),

                        ],
                      ),
                      ...feedback.docs.map((e) {
                        print(e.data());
                        FeedbackUpdate data = FeedbackUpdate.fromMap(e.data());
                        return TableRow(children: [
                          Column(children: [
                            Text("${data.feedback_date}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.teal))
                          ]),
                          Column(children: [
                            Text("${data.Class}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("${data.Division}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold))
                          ]),
                          Column(children: [
                            Text("${data.feedback_oral}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.teal))
                          ]),
                          Column(children: [
                            Text("${data.feedback_written}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.teal))
                          ]),

                        ]);
                      })
                    ]),]))
            ]),
          ],
      pageFormat: PdfPageFormat.a4));

  return pdf.save();
}
