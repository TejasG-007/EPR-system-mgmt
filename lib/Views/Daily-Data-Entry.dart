import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Searchinghelper.dart';
import '../Modal/PersonalUpdate.dart';

class DailyDataEntry extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Set<Map<String,String>> searchTerm = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Data-Entry"),
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()=>showSearch(context: context, delegate: CustomSearchDelegate(data: searchTerm.toList())), icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: _firebaseFirestore.collection('Users').snapshots(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
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
                  PersonalDataUpdate data =
                  PersonalDataUpdate.fromMap(
                      snapshot.data!.docs[ind].data());
                  final id = snapshot.data!.docs[ind].id;
                  searchTerm.add({id:data.Name});
                  return Container(
                      child: InkWell(
                          onTap: () {
                            Get.toNamed("/daily-data-filling",
                                arguments: [
                                  {
                                    "userid":
                                    snapshot.data!.docs[ind].id
                                  }
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
                                borderRadius:
                                BorderRadius.circular(5)),
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
              );
            }),
      ),
    );
  }
}
