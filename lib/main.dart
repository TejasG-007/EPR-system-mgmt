import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Utils/AppRoutes.dart';
import 'package:techer_mgmt/Views/HomeScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB-BfXy-N7ReDsHueaoVBMqkhiFbZR1bh8",
          authDomain: "db-mgmt-teacher.firebaseapp.com",
          projectId: "db-mgmt-teacher",
          storageBucket: "db-mgmt-teacher.appspot.com",
          messagingSenderId: "971322426050",
          appId: "1:971322426050:web:269ab80eedd87d5b04315b",
          measurementId: "G-9L7KJS28KY"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
              bodyText1: GoogleFonts.oswald(textStyle: textTheme.bodyText1),
              bodyText2: GoogleFonts.mulish(textStyle: textTheme.bodyText2),


          ),
          useMaterial3: true),
      getPages: appRoutes(),
      initialRoute: '/home',
      home: HomeScreen(),
    );
  }
}



