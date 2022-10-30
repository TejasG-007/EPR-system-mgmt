import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:techer_mgmt/Modal/DailyUpdate.dart';
import 'package:techer_mgmt/Modal/PersonalUpdate.dart';
import '../Utils/Utils.dart';
import 'package:get/get.dart';

class DailyDataFilling extends StatelessWidget {

 TextEditingController Signature = TextEditingController();
 TextEditingController Remark = TextEditingController();
 TextEditingController DSP = TextEditingController();
 TextEditingController DSC = TextEditingController();
 TextEditingController Uniform = TextEditingController();
 TextEditingController IdCard = TextEditingController();

 PersonalDataUpdate data = Get.arguments[0]["Personal data"];
 String userid = Get.arguments[1]["userid"];

 final GlobalKey<FormState> _dailyFilling = GlobalKey<FormState>();

 FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

 final controller = Get.put(ControllerState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Person Name"),
      ),
      body: LayoutBuilder(
        builder:(BuildContext context,BoxConstraints size)=> Container(
          child:Form(
            key: _dailyFilling,
            child: ListView(
              children: [
                SizedBox(height: 50,),
                ResponsiveDailyDataDetails(
                  constraints: size,
                  Remark: Remark,
                  DSP: DSP,
                  DSC: DSC,
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.purpleAccent,
                        elevation: 10,
                        textStyle: GoogleFonts.mulish(
                          color: Colors.white
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: ()async{
                             if(_dailyFilling.currentState!.validate()){
                               try{
                                 await  _firebaseFirestore.collection("Users").doc(userid).collection("DailyUpdate").doc(DateTime.now().toString().substring(0,11)).set(DailyUpdate(Signature: controller.Signature.value, Remark: Remark.text, DSP: DSP.text, DSC: DSC.text, Uniform: controller.Uniform.value, IdCard: controller.Id_card.value).toMap()
                                 ).then((value) => showDialog(
                                     context: context,
                                     builder: (context) => AlertDialog(
                                       content: Column(
                                         children: [
                                           const Center(
                                             child: Icon(
                                               Icons.done,
                                               color: Colors.green,
                                               size: 50,
                                             ),
                                           ),
                                           Text(
                                             "Submitted Succesfully",
                                             style: GoogleFonts.mulish(
                                                 color: Colors.black),
                                           )
                                         ],
                                       ),
                                       actions: [
                                         ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                               shape:
                                               RoundedRectangleBorder(
                                                   borderRadius:
                                                   BorderRadius
                                                       .circular(
                                                       10))),
                                           onPressed: () {
                                             Get.toNamed('/home');
                                           },
                                           child: Text(
                                             "Home",
                                             style: GoogleFonts.mulish(),
                                           ),
                                         )
                                       ],
                                     )));
                               }catch(e){

                                 showDialog(
                                     context: context,
                                     builder: (context) => AlertDialog(
                                       content: Column(
                                         children: [
                                           Center(
                                             child: Icon(
                                               Icons.error_outline_rounded,
                                               color: Colors.orange,
                                             ),
                                           ),
                                           Text(
                                             "Facing Issue While Submitting\n$e",
                                             style: GoogleFonts.mulish(
                                                 color: Colors.red),
                                           )
                                         ],
                                       ),
                                     ));
                               }
                             }
                      }, child: Text("Submit",style: GoogleFonts.mulish(
                    color: Colors.white
                  ),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
