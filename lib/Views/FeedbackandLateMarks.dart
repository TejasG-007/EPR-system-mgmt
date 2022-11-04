import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import 'package:techer_mgmt/Utils/Utils.dart';



class FeedbackScreen extends StatelessWidget {


  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController Feedback_oral = TextEditingController();
  TextEditingController Feedback_written = TextEditingController();
  TextEditingController Feedback_date = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, size) => SafeArea(
          child: StreamBuilder(
              stream: _firebaseFirestore.collection('data').snapshots(),
              builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purpleAccent,
                  semanticsLabel: "Fetching Feedback data...",
                ),
              )
                  : ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, ind) {
                  PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                      snapshot.data!.docs[ind].data());
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Feedback Entry",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.purpleAccent,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: formkey,
                                  child: ResponsiveFeedbackDialog(
                                      constraints: size,
                                      Feedback_oral: Feedback_oral,
                                      Feedback_written:
                                      Feedback_written,
                                      Feedback_Date: Feedback_date,key: formkey),),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Center(
                                  child: Text("Button"),
                                  // child: ElevatedButton(
                                  //   onPressed: () async {
                                  //     if(formkey.currentState!.validate()){
                                  //       Map<String, dynamic>
                                  //       varibale = data.Feedback
                                  //       as Map<String,
                                  //           dynamic>;
                                  //       varibale.addAll({
                                  //         Feedback_date.text
                                  //             .substring(0, 11)
                                  //             .removeAllWhitespace: {
                                  //           "OralFeedback":
                                  //           Feedback_oral.text,
                                  //           "WrittenFeedback":
                                  //           Feedback_written
                                  //               .text,
                                  //           "FeedbackDate":
                                  //           Feedback_date.text
                                  //         }
                                  //       });
                                  //
                                  //       await _firebaseFirestore
                                  //           .collection("data")
                                  //           .doc(snapshot
                                  //           .data!.docs[ind].id)
                                  //           .update({
                                  //         "Feedback": varibale
                                  //       }).then((value) =>
                                  //           showDialog(
                                  //               context:
                                  //               context,
                                  //               builder:
                                  //                   (context) =>
                                  //                   AlertDialog(
                                  //                     title:
                                  //                     Column(
                                  //                       children: [
                                  //                         const Center(
                                  //                           child: Icon(
                                  //                             Icons.done,
                                  //                             color: Colors.green,
                                  //                           ),
                                  //                         ),
                                  //                         Text(
                                  //                           "Feedback Submitted Successfully.",
                                  //                           style: GoogleFonts.mulish(),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                     actions: [
                                  //                       ElevatedButton(
                                  //                         style: ElevatedButton.styleFrom(
                                  //                           shape:RoundedRectangleBorder(
                                  //                             borderRadius: BorderRadius.circular(10)
                                  //                           )
                                  //                         ),
                                  //                           onPressed: () {
                                  //                             Get.toNamed('/home');
                                  //                           },
                                  //                           child: const Text("home")),
                                  //                     ],
                                  //                   )));
                                  //     }
                                  //   },
                                  //   child: const Text("Submit"),
                                  // ),
                                )
                              ],
                            ),
                          ));
                    },
                    hoverColor: Colors.purpleAccent,
                    splashColor: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: ListTile(
                      leading: const Icon(
                        Icons.person_pin,
                        color: Colors.green,
                      ),
                      style: ListTileStyle.list,
                      dense: true,
                      title: Text(
                        "Name: ${data.Name}",
                        style: GoogleFonts.mulish(),
                      ),
                      subtitle: Text(
                        "Mobile:+91 ${data.Mobile}",
                        style: GoogleFonts.openSans(),
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}