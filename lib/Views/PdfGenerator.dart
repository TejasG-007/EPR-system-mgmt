import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:techer_mgmt/Modal/LateMarks.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Modal/DailyUpdate.dart';





Future<Uint8List> pdfGenerator(
    PersonalDataUpdate data, String id, var dailyData,Map<String,dynamic>? lateMarks) {
  final pdf = Document();
  pdf.addPage(MultiPage(
      build: (Context context) =>
         [ Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
             Table(border: TableBorder.all(color: PdfColors.black), children: [
               ...data.Salary.keys.toList().map((e) => TableRow(children: [
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
             Table(border: TableBorder.all(color: PdfColors.black), children: [
               ...data.Casual_Leave.keys
                   .toList()
                   .map((e) => TableRow(children: [
                 Padding(
                     child: Text("${e} : ${data.Casual_Leave[e]}"),
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
             Table(border: TableBorder.all(color: PdfColors.black), children: [
               ...data.Duty_Leave.keys.toList().map((e) => TableRow(children: [
                 Padding(
                     child: Text("${e} : ${data.Duty_Leave[e]}"),
                     padding: EdgeInsets.all(5))
               ]))
             ]),
           ]),
           SizedBox(height: 10),
           Divider(indent: 10, endIndent: 10, height: .4),
           SizedBox(height: 10),
           Column(children: [
             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
               Text("Daily Updated Data",
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: PdfColors.purpleAccent)),
             ]),
             SizedBox(height: 10),

            dailyData==null?Text("No Daily Update Record Found."): Table(border: TableBorder.all(color: PdfColors.black), children: [
              TableRow(children: [
                Column(children: [
                  Text("Date", style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("Uniform",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("Signature",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("Remark",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("DSC", style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("DSP", style: TextStyle(fontWeight: FontWeight.bold))
                ]),
                Column(children: [
                  Text("IdCard",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
              ]),
              ...dailyData.map((e) {


                DailyUpdate dd = DailyUpdate.fromMap(e.data());

                return TableRow(children: [
                  Column(children: [Text("${e.id}",style: TextStyle(
                      color: PdfColors.cyan,fontWeight: FontWeight.bold
                  ))]),
                  Column(children: [Text("${dd.Uniform}")]),
                  Column(children: [Text("${dd.Signature}")]),
                  Column(children: [Text("${dd.Remark}")]),
                  Column(children: [Text("${dd.DSC}")]),
                  Column(children: [Text("${dd.DSP}")]),
                  Column(children: [Text("${dd.IdCard}")]),
                ]);
              })
            ]),
             SizedBox(height: 20),
             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
               Text("Late Marks",
                   style: TextStyle(
                       fontWeight: FontWeight.bold,
                       color: PdfColors.purpleAccent)),
             ]),
             SizedBox(height: 10),
             lateMarks==null?Text("No Late Mark Record Found."): Table(border: TableBorder.all(color: PdfColors.black), children: [
               TableRow(children: [
                 Column(children: [
                   Text("Date", style: TextStyle(fontWeight: FontWeight.bold))
                 ]),
                 Column(children: [
                   Text("Class",
                       style: TextStyle(fontWeight: FontWeight.bold))
                 ]),
                 Column(children: [
                   Text("Division",
                       style: TextStyle(fontWeight: FontWeight.bold))
                 ]),
               ]),
               ...lateMarks.keys.toList().map((e){
                 LateMarks dd = LateMarks.fromMap(lateMarks[e]);
                 return TableRow(children: [
                   Column(children: [Text("${DateTime.fromMicrosecondsSinceEpoch(int.parse(e)).toString().substring(0,16)}",style: TextStyle(
                       color: PdfColors.cyan,fontWeight: FontWeight.bold
                   ))]),
                   Column(children: [Text("${dd.Division}")]),
                   Column(children: [Text("${dd.Class}")]),
                 ]);
               })
             ]),

           ]),
         ]),
         ],
      pageFormat: PdfPageFormat.a4));

  return pdf.save();
}
