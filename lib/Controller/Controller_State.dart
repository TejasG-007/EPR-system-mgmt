import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/LateMarks.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Modal/FeedbackUpdate.dart';

class ControllerState extends GetxController {


  checkUser()async{
    return FirebaseAuth.instance.currentUser!=null;
  }

  /////////////////////For Late Marks//////////////////////////////
  List<String> classesfromFirebase = [""].obs;
  List<String> divisionfromFirebase = [""].obs;

  ///////////////////////////////////////////////////
  late Rx<double> TotalSalary;

  List<String> division = [
    "Division-A",
    "Division-B",
    "Division-C",
    "Division-D",
    "Division-E",
    "Division-F",
    "Division-G"
  ].obs;
  List<String> subjects = [
    "Hindi",
    "English",
    "Mathematics",
    "Science",
    "History",
    "Geography",
    "Social-Science",
    "Biology",
    "Physics",
    "Chemistry"
  ].obs;
  List<String> classes = ["Class-XII", "Class-XI"].obs;
  List<String> papers = [
    "Paper-I",
    "Paper-II",
    "Paper-III",
    "Paper-IV",
    "Paper-V",
    "Paper-VI",
    "Paper-VII",
    "Paper-VIII",
    "Paper-IX",
    "Paper-X"
  ].obs;
  RxList division_real = ["Division-A"].obs;
  RxList subjects_real = ["Hindi"].obs;
  RxList classes_real = ["Class-XII"].obs;
  RxList papers_real = ["Paper-I"].obs;
  RxString firebaseClass = "".obs;
  RxString firebaseDivision = "".obs;

  RxBool isdisabled = false.obs;

  ButtonDisabled() {
    isdisabled.value = true;
  }

  ButtonEnabled() {
    isdisabled.value = false;
  }

  //////////////////////////////
  RxBool isdisabled2 = false.obs;

  ButtonDisabled2() {
    isdisabled2.value = true;
  }

  ButtonEnabled2() {
    isdisabled2.value = false;
  }

/////////////////////////////////////////////
  RxBool isdisabled3 = false.obs;

  ButtonDisabled3() {
    isdisabled3.value = true;
  }

  ButtonEnabled3() {
    isdisabled3.value = false;
  }

  ///////////////////////////////////////////
  var totalSalary = 0.0.obs;
  var salGov = 0.0.obs;
  var salPvt = 0.0.obs;

  updatingSalary() {
    try {
      totalSalary.value = salPvt.value + salGov.value;
    } catch (e) {
      return "Invalid Double $e";
    }
  }

//--------------------------------Daily-Update

  RxString Signature = "NO".obs;
  RxString Uniform = "YES".obs;
  RxString Id_card = "NO".obs;

  // ===========================Search===============

  RxList<Map<String, PersonalDataUpdate>> data = [
    {
      "": PersonalDataUpdate(
          Userid: '',
          Name: 'Search Here',
          Classes: [],
          Subjects: [],
          Divisions: [],
          Papers: [],
          JoiningDate: '',
          DailyWorkLoad: '',
          Salary: {},
          Mobile: '',
          Casual_Leave: {},
          Duty_Leave: {})
    }
  ].obs;
//==============================Report==========================================
  var value = "".obs;

  List<String> feedbackDate = [""].obs;
  getFeedbackDate(List<DateTime?>? data) {
    feedbackDate.clear();
    if (data!.isNotEmpty) {
      if(data.length==1){
        for(var date in data){
          feedbackDate.add(date.toString().substring(0, 11));
          feedbackDate.add(date.toString().substring(0, 11));
        }
      }else{
        for (var item in data) {
          feedbackDate.add(item.toString().substring(0, 11));
        }
      }
    }
  }


  List<String> LateMarksDate = [""].obs;
  getLateMarksDate(List<DateTime?>? data) {
    LateMarksDate.clear();
    if (data!.isNotEmpty) {
      if(data.length==1){
        for(var date in data){
          LateMarksDate.add(date.toString().substring(0, 11));
          LateMarksDate.add(date.toString().substring(0, 11));
        }
      }else{
        for (var item in data) {
          LateMarksDate.add(item.toString().substring(0, 11));
        }
      }
    }
  }

  List<String> DailyUpdateDate = [""].obs;
  getDailyUpdateDate(List<DateTime?>? data) {
    DailyUpdateDate.clear();
    if (data!.isNotEmpty) {
      if(data.length==1){
        for(var date in data){
          DailyUpdateDate.add(date.toString().substring(0, 11));
          DailyUpdateDate.add(date.toString().substring(0, 11));
        }
      }else{
        for (var item in data) {
          DailyUpdateDate.add(item.toString().substring(0, 11));
        }
      }

    }
  }



  List<FeedbackUpdate> feedbackDataR = [
    FeedbackUpdate(
        feedback_date: '',
        feedback_written: '',
        feedback_oral: '',
        Division: '',
        Class: '')
  ].obs;
  List<LateMarks> LateMarksDataR = [LateMarks(Division: '', Class: '', Date: '')].obs;
  List<DailyUpdate> DailyDataEntryR = [
   DailyUpdate(Signature: '', Remark: '', DSP: '', DSC: '', Uniform: '', IdCard: '', Date: '', Reward: '', Penalty: '')
  ].obs;




  ////////////////////////////////////////////////////////////////User Auth

  var isPasswordHidden = true.obs;

  ShowPassword(){
  isPasswordHidden.value = !(isPasswordHidden.value);
  }



}
