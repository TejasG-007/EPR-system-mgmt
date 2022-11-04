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
 final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: Drawer(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: FloatingActionButton.extended(
              heroTag: "btn1",
                icon: Icon(Icons.touch_app_outlined),
                onPressed: (){
                  _key.currentState!.isEndDrawerOpen?_key.currentState!.closeEndDrawer():_key.currentState!.openEndDrawer();
                }, label: Text("View Leaves")),
          ),
          Container(margin: EdgeInsets.symmetric(horizontal: 10),
          child:  FloatingActionButton.extended(
              heroTag: "btn2",
              icon: Icon(Icons.touch_app_outlined),
              onPressed: (){
                _key.currentState!.isDrawerOpen?_key.currentState!.closeDrawer():_key.currentState!.openDrawer();
              }, label: Text("Manage Leaves")),),
          SizedBox(width: 10,),
        ],
      ),
      appBar: AppBar(
        title: Text("Person Name"),
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Text("Hi There")
          ],
        ),
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
                Obx(() => controller.isdisabled.value?Container(
                  alignment: Alignment.center,
                  child: Text("Please wait while Submitting..."),
                ):Container(
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
                          controller.ButtonDisabled();
                          try{
                            await  _firebaseFirestore.collection("Users").doc(userid).collection("DailyUpdate").doc(DateTime.now().toString().substring(0,11)).set(DailyUpdate(Signature: controller.Signature.value, Remark: Remark.text, DSP: DSP.text, DSC: DSC.text, Uniform: controller.Uniform.value, IdCard: controller.Id_card.value).toMap()
                            ).then((value){

                              HomeBackAlertDialog(context);
                              controller.ButtonEnabled();

                            } );
                          }catch(e){

                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  icon: Icon(Icons.cancel_outlined,color: Colors.red,),
                                  title: Text("Please try again.",style: GoogleFonts.mulish(
                                      color: Colors.black)),
                                  actions: [
                                    IconButton(onPressed: (){
                                      controller.ButtonEnabled();
                                      Get.back();
                                    }, icon:Icon(Icons.arrow_back))
                                  ],
                                ));

                          }
                        }
                      }, child: Text("Submit",style: GoogleFonts.mulish(
                      color: Colors.white
                  ),)),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
