import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Utils/AppRoutes.dart';
import 'package:techer_mgmt/Views/HomeScreen.dart';

import 'Views/UserAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details)=>Scaffold(
    body:SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          SizedBox(
            height: 40,
          ),
          Center(child: Icon(Icons.do_not_disturb_alt_rounded,size: 100,color: Colors.red,),),
          Center(
            child: Text("Your Unauthorized to this Page.",style: GoogleFonts.mulish(
              color: Colors.blue,fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed:(){
                Get.toNamed('/home');
              }, label: Text("Home"),icon:Icon(Icons.home_rounded) ,)
            ],
          )
        ],
      ),
    ),
  );
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAvL9zU4IK1_3zdT4BRpIAGkdf3sbY-ZGQ",
          authDomain: "teacher-db-10399.firebaseapp.com",
          projectId: "teacher-db-10399",
          storageBucket: "teacher-db-10399.appspot.com",
          messagingSenderId: "539855020282",
          appId: "1:539855020282:web:a4a51034f3088caf252943",
          measurementId: "G-MVTQQ6P3SZ"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          color: Color(0xFFBA94D1)
        ),
      ),
      getPages: appRoutes(),
      initialRoute: '/home',
      home:HomeScreen(), //ReportGenerator(),
    );
  }
}



