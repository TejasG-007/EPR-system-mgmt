import 'dart:convert';

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

  List<Map<String, PersonalDataUpdate>> searchTerm = [{
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
  }];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback & Late-Marks"),
        centerTitle: true,
          actions: [
            IconButton(onPressed: ()=>showSearch(context: context, delegate: CustomSearchDelegate(data: searchTerm)), icon: Icon(Icons.search))
          ],
      ),
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
                        final id = snapshot.data!.docs[ind].id;
                        searchTerm.add({id:data});
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
                                         onTap: (){
                                           Get.toNamed("/feedback-entry",arguments: [{"Personal-data":data},{"userid":snapshot.data!.docs[ind].id}]);

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

class CustomSearchDelegate extends SearchDelegate {
  late List<Map<String,PersonalDataUpdate>> data;
  CustomSearchDelegate({required this.data});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    Set<Map<String,PersonalDataUpdate>> matchQuery = {};
    for (Map<String,PersonalDataUpdate> fruit in data) {
      for(var ent in fruit.entries){
        if (ent.value.Name.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);

        }
      }

    }
    final jsonList = matchQuery.map((item) => jsonEncode(item.map((key, value) => MapEntry(key,value.toMap())))).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final final_list = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    return ListView.builder(
      itemCount: final_list.length,
      itemBuilder: (context, index) {
        var result = final_list[index];
        PersonalDataUpdate personalData = result.entries.map((e)=>PersonalDataUpdate.fromMap(e.value)).toList()[0];
        String userid = result.entries.map((e)=>e.key).toString().substring(1,result.entries.map((e)=>e.key).toString().length-1);
        print(personalData.Name);
        return ListTile(
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
                          onTap: (){
                            Get.toNamed("/feedback-entry",arguments: [{"Personal-data":personalData},{"userid":userid}]);

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
                                Icon(Icons.feedback_outlined,color: Colors.purpleAccent,size: 80,)
                                ,Text("Feedback-Entry",style: GoogleFonts.mulish(),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Get.toNamed("/late-entry",arguments: [{"Personal-data":personalData},{"userid":userid}]);
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
          title: Text(result.entries.map((e)=>PersonalDataUpdate.fromMap(e.value).Name).toString().replaceAll("(","").replaceAll(")", "")),
        );
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    var matchQuery = [];
    for (Map<String,PersonalDataUpdate> fruit in data) {
      for(var ent in fruit.entries){
        if (ent.value.Name.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);
        }
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        // var result = matchQuery[index];
        //print(matchQuery);
        return Container();
        // return ListTile(
        //   title:  Text(result.entries.map((e)=>e.value.Name).toString().replaceAll("(","").replaceAll(")", "")),
        // );
      },
    );
  }
}