
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchDelegate extends SearchDelegate {
  late List<Map<String,String>> data;
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
    Set<Map<String,String>> matchQuery = {};
    for (Map<String,String> fruit in data) {
      for(var ent in fruit.entries){
        if (ent.value.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);

        }
      }

    }
    final jsonList = matchQuery.map((item) => jsonEncode(item)).toList();

    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();

    // convert each item back to the original form using JSON decoding
    final final_list = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    return ListView.builder(
      itemCount: final_list.length,
      itemBuilder: (context, index) {
        var result = final_list[index];
        return ListTile(
          onTap: (){
            Get.toNamed("/daily-data-filling",
                arguments: [
                  {
                    "userid":result.entries.map((e)=>e.key).toString()
                  }
                ]);
          },
          title: Text(result.entries.map((e)=>e.value).toString().replaceAll("(","").replaceAll(")", "")),
        );
      },
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    var matchQuery = [];
    for (Map<String,String> fruit in data) {
      for(var ent in fruit.entries){
        if (ent.value.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(fruit);
        }
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Container();
        // return ListTile(
        //   title:  Text(result.entries.map((e)=>e.value.Name).toString().replaceAll("(","").replaceAll(")", "")),
        // );
      },
    );
  }
}