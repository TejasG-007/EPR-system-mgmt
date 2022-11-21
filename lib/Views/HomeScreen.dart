import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Container(),
      //   actions: [
      //     IconButton(onPressed: ()async{
      //       try{
      //         await FirebaseAuth.instance.signOut();
      //       }catch(e){
      //         print(e);
      //       }
      //     }, icon: Icon(Icons.logout_outlined))
      //   ],
      // ),
      body: LayoutBuilder(
        builder: (context, size) => SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.adjust_rounded,
                    color: Colors.purpleAccent,
                  ),
                  Text(
                    "DASHBOARD",
                    style: GoogleFonts.nunito(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  boxTiles('/daily-data-entry', size, "assets/images/Daily-Entry.png",
                      "Daily-Data-Entry"),
                  boxTiles('/feedback-and-latemarks', size, "assets/images/lateandfeedback.png",
                      "Late-Marks and Feedback Entry"),
                ],
              ),
              Row(
                children: [
                  boxTiles('/personal-data-entry', size,
                      "assets/images/Data-Entry.png", "Personal-Data-Entry"),
                  boxTiles('/Personal-history', size,
                      "assets/images/personal-info.png", "Personal History"),
                ],
              ),
              Row(
                children: [
                  boxTiles('/report-gen', size,
                      "assets/images/Feedback Report.png", "Report-Generator"),
                  boxTiles('/PersonalDataEditView', size, "assets/images/person-edit.png",
                      "Personal Data Edit"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                        child: Text(
                      "Copyright @2021 by TejasG-Production",
                      style: GoogleFonts.mulish(),
                    )),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget boxTiles(
      String routeName, BoxConstraints size, String imgPath, String label) {
    return Expanded(
        child: InkWell(
      onTap: () {
        Get.toNamed(routeName);
      },
      hoverColor: Colors.purpleAccent,
      splashColor: Colors.green,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
          height: size.maxHeight / 3,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(1, 1),
                    color: Colors.grey)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Expanded(child:  Container(
               margin: EdgeInsets.only(top: 10),
               child: Image.asset(
               imgPath,
             ),)),
             Expanded(child:  Container(
               padding: EdgeInsets.all(8),
               alignment: Alignment.center,
               margin: const EdgeInsets.all(5),
               child: Text(
                 label,
                 style: GoogleFonts.mulish(
                     fontWeight: FontWeight.bold, fontSize: 24),
               ),
             )),
            ],
          )),
    ));
  }
}
