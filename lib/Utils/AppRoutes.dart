import 'package:get/get.dart';
import 'package:techer_mgmt/Views/Daily-Data-Entry.dart';
import 'package:techer_mgmt/Views/PersonalDataEntry.dart';
import 'package:techer_mgmt/Views/PersonalHistory.dart';
import '../Views/Daily-Data-Filling.dart';
import '../Views/Feedback-Update.dart';
import '../Views/HomeScreen.dart';
import '../Views/ShowPersonalData.dart';

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
          name: '/feedback-entry',
          page: () => FeedbackScreen(),
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
    ];

class Middleware extends GetMiddleware{
  @override
  GetPage? onPageCalled(GetPage?page){
    print(page?.name);
    return super.onPageCalled(page);
  }
}