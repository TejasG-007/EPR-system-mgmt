import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

class PersonalHistory extends StatelessWidget {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal History"),
        elevation: 4,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: _firebaseFirestore.collection('Users').snapshots(),
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purpleAccent,
                      semanticsLabel: "Fetching Feedback data...",
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, ind) {
                      PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                          snapshot.data!.docs[ind].data());
                      return Container(
                          child: InkWell(
                              onTap: () async{
                                Get.toNamed("/show-personal-data", arguments: [
                                  {"Personal data": data},
                                  {"userid": snapshot.data!.docs[ind].id},
                                  {"lateMarks":await FirebaseFirestore.instance
                                      .collection('Users').doc(snapshot.data!.docs[ind].id).collection("LateMarks")
                                      .get()}
                                ]);
                              },
                              hoverColor: Colors.purpleAccent,
                              splashColor: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(1, 1),
                                          color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
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
                                ),
                              )));
                    },
                  )),
      ),
    );
  }
}
