import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

class FeedbackandLateMarks extends StatelessWidget {
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
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, ind) {
                        PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                            snapshot.data!.docs[ind].data());

                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                title: Text("Select Entry Point",style: GoogleFonts.nunito(
                                  color: Colors.black,
                                ),),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                       InkWell(
                                         onTap: (){},
                                         hoverColor: Colors.teal,
                                         borderRadius: BorderRadius.circular(15),
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            padding: EdgeInsets.all(15),
                                            decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
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
                                                Icon(Icons.feedback_outlined,color: Colors.purpleAccent,size: 80,)
                                                ,Text("Feedback-Entry",style: GoogleFonts.mulish(),)
                                              ],
                                            ),
                                          ),
                                       ),
                                        SizedBox(height: 10,),
                                        InkWell(
                                          onTap: (){
                                            Get.toNamed("/late-entry",arguments: [{"Personal-data":data},{"userid":snapshot.data!.docs[ind].id}]);
                                          },
                                          hoverColor: Colors.teal,
                                          borderRadius: BorderRadius.circular(15),
                                          child: Container(
                                            margin: EdgeInsets.all(2),
                                            padding: EdgeInsets.all(15),
                                            decoration:BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
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
                                                Icon(Icons.directions_run_outlined,color: Colors.purpleAccent,size: 80,)
                                                ,Text("Late-Entry",style: GoogleFonts.mulish(),)
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
