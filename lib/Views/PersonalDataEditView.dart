import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';

class PersonalDataEditView extends StatelessWidget {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<Map<String, PersonalDataUpdate>> searchData = [{
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
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text(
          "Way to Personal Data Edit ",
          style: GoogleFonts.gugi(color: Colors.white),
        ),
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchingForNames(data: searchData));
              },
              icon: Icon(Icons.search_rounded,color: Colors.white,))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: _firebaseFirestore.collection('Users').snapshots(),
            builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting && !snapshot.hasData
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purpleAccent,
                semanticsLabel: "Fetching data...",
              ),
            )
                : ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, ind) {
                PersonalDataUpdate data = PersonalDataUpdate.fromMap(
                    snapshot.data!.docs[ind].data());
                final id = snapshot.data!.docs[ind].id;
                searchData.add({id:data});
                return Container(
                    child: InkWell(
                        onTap: () async{
                          Get.toNamed('/PersonalEntry-Edit',arguments: [
                            {"PersonalData": data},{"userid": snapshot.data!.docs[ind].id}
                          ]);
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
      ),
    );
  }
}


class SearchingForNames extends SearchDelegate {
  late List<Map<String,PersonalDataUpdate>> data;
  SearchingForNames({required this.data});
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
        return ListTile(
          onTap: () async {
            Get.toNamed("/show-personal-data", arguments: [
              {"Personal data": personalData},
              {"userid": userid},
              {"lateMarks":await FirebaseFirestore.instance
                  .collection('Users').doc(userid).collection("LateMarks")
                  .get(),
              },
              {"Feedback":await FirebaseFirestore.instance
                  .collection('Users').doc(userid).collection("Feedback")
                  .get()}
            ]);
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
        print(matchQuery);
        return Container();
        // return ListTile(
        //   title:  Text(result.entries.map((e)=>e.value.Name).toString().replaceAll("(","").replaceAll(")", "")),
        // );
      },
    );
  }
}