import 'package:get/get.dart';

class ControllerState extends GetxController {


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
}
