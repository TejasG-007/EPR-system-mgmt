import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techer_mgmt/Views/Daily-Data-Entry.dart';
import 'package:techer_mgmt/Views/Feedback-Entry.dart';
import 'package:techer_mgmt/Views/LateEntryView.dart';
import 'package:techer_mgmt/Views/PersonalDataEdit.dart';
import 'package:techer_mgmt/Views/PersonalDataEntry.dart';
import 'package:techer_mgmt/Views/PersonalHistory.dart';
import 'package:techer_mgmt/Views/ReportGenrator.dart';
import 'package:techer_mgmt/Views/UserAuth.dart';
import 'package:techer_mgmt/Views/showReportVdata.dart';
import '../Views/Daily-Data-Filling.dart';
import '../Views/FeedbackandLateMarks.dart';
import '../Views/HomeScreen.dart';
import '../Views/PersonalDataEditView.dart';
import '../Views/ShowPersonalData.dart';
import '../Views/ShowViewForFLH.dart';
import '../Views/WaytoGen.dart';

List<GetPage> appRoutes() => [
      GetPage(
        name: "/userauth",
        page: () => UserAuthScreen(),
        middlewares: [HomeMiddleware()],
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
          name: "/home",
          page: () => HomeScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500),),
      GetPage(
          name: '/personal-data-entry',
          page: () => DataEntry(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/feedback-and-latemarks',
          page: () => FeedbackLateView(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/Personal-history',
          page: () => PersonalHistory(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/daily-data-entry',
          page: () => DailyDataEntry(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/show-personal-data',
          page: () => ShowPersonalData(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/daily-data-filling',
          page: () => DailyDataFilling(),
          middlewares: [HomeMiddleware()],
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/late-entry',
          page: () => LateEntry(),
          transition: Transition.fadeIn,
          middlewares: [HomeMiddleware()],
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/feedback-entry',
          page: () => FeedbackEntry(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: '/report-gen',
          page: () => ReportGenerator(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: "/showReportVdata",
          page: () => showReportVdata(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: "/PersonalEntry-Edit",
          page: () => PersonalDataEdit(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: "/Wayto-Gen",
          page: () => WaytoGenerate(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
      GetPage(
          name: "/PersonalDataEditView",
          page: () => PersonalDataEditView(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
  GetPage(
          name: "/showuserFLH",
          page: () => ShowHistory(),
          middlewares: [HomeMiddleware()],
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 500)),
    ];


class HomeMiddleware extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route)=> (FirebaseAuth.instance.currentUser!=null)?null:route!='/userauth'?RouteSettings(name: '/userauth'):null;
}