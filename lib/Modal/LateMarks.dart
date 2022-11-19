

import 'package:flutter/cupertino.dart';

class LateMarks{
  late String Class;
  late String Division;
  late String Date;

  LateMarks({
    required this.Division,
    required this.Class,
    required this.Date,
});

  LateMarks.fromMap(Map<String,dynamic> map){
    this.Class = map["Class"];
    this.Division = map["Division"];
    this.Date = map["Date"];
  }

Map<String,dynamic> toMap(){
    return {
      "Class":this.Class,
      "Division":this.Division,
      "Date":this.Date

    };
}
}