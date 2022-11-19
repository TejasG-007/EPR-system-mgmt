import 'package:get/get.dart';
import 'package:techer_mgmt/Views/Daily-Data-Entry.dart';
import 'package:techer_mgmt/Views/Feedback-Entry.dart';
import 'package:techer_mgmt/Views/LateEntryView.dart';
import 'package:techer_mgmt/Views/PersonalDataEdit.dart';
import 'package:techer_mgmt/Views/PersonalDataEntry.dart';
import 'package:techer_mgmt/Views/PersonalHistory.dart';
import 'package:techer_mgmt/Views/ReportGenrator.dart';
import 'package:techer_mgmt/Views/showReportVdata.dart';
import '../Views/Daily-Data-Filling.dart';
import '../Views/FeedbackandLateMarks.dart';
import '../Views/HomeScreen.dart';
import '../Views/ShowPersonalData.dart';
import '../Views/WaytoGen.dart';

appRoutes() => [
      GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
  GetPage(
          name: '/personal-data-entry',
          page: () => DataEntry(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
  GetPage(
          name: '/feedback-and-latemarks',
          page: () => FeedbackandLateMarks(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
  GetPage(
          name: '/Personal-history',
          page: () => PersonalHistory(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),

  GetPage(
      name: '/daily-data-entry',
      page: () => DailyDataEntry(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500)),
  GetPage(
      name: '/show-personal-data',
      page: () => ShowPersonalData(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500)),

  GetPage(
      name: '/daily-data-filling',
      page: () => DailyDataFilling(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500)),

  GetPage(
      name: '/late-entry',
      page: () => LateEntry(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),

  GetPage(
      name: '/feedback-entry',
      page: () => FeedbackEntry(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),
  GetPage(
      name: '/report-gen',
      page: () => ReportGenerator(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),

  GetPage(
      name: "/showReportVdata",
      page: () => showReportVdata(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),
  GetPage(
      name: "/PersonalEntry-Edit",
      page: () => PersonalDataEdit(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),
  GetPage(
      name: "/Wayto-Gen",
      page: () => WaytoGenerate(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 500)),

];

class Middleware extends GetMiddleware{
  @override
  GetPage? onPageCalled(GetPage?page){
    print(page?.name);
    return super.onPageCalled(page);
  }
}