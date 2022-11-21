import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techer_mgmt/Utils/AppRoutes.dart';

import 'Views/UserAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: '/userauth',
      home:UserAuthScreen(), //ReportGenerator(),
    );
  }
}



