import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
class ReportGenerator extends StatefulWidget {
  @override
  State<ReportGenerator> createState() => _ReportGeneratorState();
}

class _ReportGeneratorState extends State<ReportGenerator> {

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
          stream: _firebaseFirestore.collection('Users').snapshots(),
          builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting && !snapshot.hasData
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purpleAccent,
              semanticsLabel: "Fetching  data...",
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, ind) {
              PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                  snapshot.data!.docs[ind].data());
              final id = snapshot.data!.docs[ind].id;
              return Container(
                  child: InkWell(
                      onTap: () async{
                        Get.toNamed("/Wayto-Gen",
                            arguments: [
                              {"Personaldata": data},
                              {"userid": snapshot.data!.docs[ind].id}]);
                      },
                      splashColor: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                      child: ListTile(
                        title: Text(
                          data.Name,
                          style: GoogleFonts.mulish(),
                        ),
                        subtitle: Text(
                          "+91 ${data.Mobile}",
                          style: GoogleFonts.openSans(),
                        ),
                        isThreeLine: true,
                        enableFeedback: true,
                      )));
            },
          )),
    );
  }
}


