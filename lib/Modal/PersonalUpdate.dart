class PersonalDataUpdate {
  late String Name;
  late String Userid;
  late String JoiningDate;
  late Map Salary;
  late String DailyWorkLoad;
  late List Subjects;
  late List Classes;
  late List Divisions;
  late List Papers;
  late String Mobile;
  late Map Casual_Leave;
  late Map Duty_Leave;


  PersonalDataUpdate({
    required this.Userid,
    required this.Name,
    required this.Classes,
    required this.Subjects,
    required this.Divisions,
    required this.Papers,
    required this.JoiningDate,
    required this.DailyWorkLoad,
    required this.Salary,
    required this.Mobile,
    required this.Casual_Leave,
    required this.Duty_Leave,

  });

  PersonalDataUpdate.fromMap(Map<String, dynamic> map) {
    this.Name = map["Name"];
    this.Userid = map["Userid"];
    this.Subjects = map["Subjects"];
    this.Classes = map["Classes"];
    this.Divisions = map["Divisions"];
    this.Papers = map["Papers"];
    this.JoiningDate = map["JoiningDate"];
    this.DailyWorkLoad = map["DailyWorkLoad"];
    this.Salary = map["Salary"];
    this.Mobile = map["Mobile"];
    this.Casual_Leave=map["Casual_Leave"];
    this.Duty_Leave=map["Duty_Leave"];


  }

  Map<String, dynamic> toMap() {
    return {
      "Userid": this.Userid,
      "Name": this.Name,
      "Mobile": this.Mobile,
      "Subjects": this.Subjects,
      "Classes": this.Classes,
      "Divisions": this.Divisions,
      "Papers": this.Papers,
      "Salary": this.Salary,
      "DailyWorkLoad": this.DailyWorkLoad,
      "JoiningDate": this.JoiningDate,
      "Casual_Leave": this.Casual_Leave,
      "Duty_Leave": this.Duty_Leave,

    };
  }
}

