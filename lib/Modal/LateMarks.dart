

import 'package:flutter/cupertino.dart';

class LateMarks{
  late String Class;
  late String Division;

  LateMarks({
    required this.Division,
    required this.Class,
});

  LateMarks.fromMap(Map<String,dynamic> map){
    this.Class = map["Class"];
    this.Division = map["Division"];
  }

Map<String,dynamic> toMap(){
    return {
      "Class":this.Class,
      "Division":this.Division

    };
}
}