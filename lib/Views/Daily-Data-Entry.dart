import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Modal/PersonalUpdate.dart';

class DailyDataEntry extends StatelessWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Map<String, PersonalDataUpdate> searchData = {
    "id": PersonalDataUpdate(
        Userid: '',
        Name: "search Employee Name here",
        Classes: [],
        Subjects: [],
        Divisions: [],
        Papers: [],
        JoiningDate: '',
        DailyWorkLoad: '',
        Salary: {},
        Mobile: '',
        Casual_Leave: {},
        Duty_Leave: {}),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Data-Entry"),
        elevation: 4,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomeSearchDelagate(searchData));
              },
              icon: Icon(Icons.search_rounded))
        ],
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
                      final id = snapshot.data!.docs[ind].id;
                      searchData.addAll({id: data});
                      return Container(
                          child: InkWell(
                              onTap: () {
                                Get.toNamed("/daily-data-filling", arguments: [
                                  {"Personal data": data},
                                  {"userid": snapshot.data!.docs[ind].id}
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

class CustomeSearchDelagate extends SearchDelegate {
  CustomeSearchDelagate(this.searchData);
  final searchData; //id and PersonalDataUpdate Object in Map

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    List<String> allids = searchData.keys.toList(growable: true);
    List<PersonalDataUpdate> mainData =
        searchData.values.toList(growable: true);
    for (int itr = 0; itr <= mainData.length - 1; itr++) {
      if (mainData[itr].Name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(mainData[itr].Name);
      }
    }
    return ListView.builder(
      itemCount: mainData.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    List<String> allids = searchData.keys.toList(growable: true);
    List<PersonalDataUpdate> mainData =
        searchData.values.toList(growable: true);
    for (int itr = 0; itr <= mainData.length - 1; itr++) {
      if (mainData[itr].Name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(mainData[itr].Name);
      }
    }
    return ListView.builder(
      itemCount: mainData.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        print("here is result$result");
        return InkWell(
          onTap: () {
            result == "search Employee Name here"
                ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Container(
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "Please Search User Name and Tap to Fill the Data.",
                                    style: GoogleFonts.mulish(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "back",
                                      style: GoogleFonts.mulish(),
                                    ))
                              ],
                            ),
                          ),
                        ))
                : Get.toNamed('/daily-data-filling', arguments: [
                    {"Personal data": searchData[allids[index]]},
                    {"userid": allids[index]}
                  ]);
          },
          hoverColor: Colors.purpleAccent,
          splashColor: Colors.green,
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
