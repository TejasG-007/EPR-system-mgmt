import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techer_mgmt/Controller/Controller_State.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthScreen extends StatelessWidget{

  final controller = Get.put(ControllerState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: LayoutBuilder(
         builder: (context,size)=>SafeArea(
           child: Column(
             children: [
               SizedBox(height: 50,),
               Container(child: Text("Teacher MGMT",style:GoogleFonts.mulish(
                   color: Colors.purpleAccent,fontWeight:FontWeight.bold,fontSize: 34
               )),),
               SizedBox(height: 50,),
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 30),
                 child:Text("LOGO"),

               ),
               SizedBox(height: 30,),
               Container(child: Text("Get In",style:GoogleFonts.mulish(
                   color: Colors.purpleAccent,fontWeight:FontWeight.bold,fontSize: 24
               )),),
               Divider(height: 4,indent: 100,endIndent: 100,),
               SizedBox(height: 35,),
               Form(
                 key: _formkey,
                 child: Column(
                   children: [
                     Container(
                       margin: EdgeInsets.symmetric(horizontal: size.maxWidth*.15),
                       child: TextFormField(
                         validator: MultiValidator([
                           EmailValidator(errorText: "Please Enter Valid Email."),
                           RequiredValidator(errorText: "Email Should not be Empty")

                         ]),
                         style: GoogleFonts.mulish(),
                         autofocus: true,
                         controller: _username,
                         keyboardType: TextInputType.text,
                         cursorColor: Colors.purpleAccent,
                         cursorHeight: .2,
                         cursorRadius: Radius.circular(10),
                         decoration: InputDecoration(
                             labelText: "Username",
                             labelStyle: GoogleFonts.mulish(color: Colors.purpleAccent),
                             prefixIcon: Icon(Icons.person,color: Colors.purple,),
                             prefixStyle: GoogleFonts.mulish(),
                             hintText: "admin",
                             disabledBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             enabledBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             focusedBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             focusColor: Colors.purpleAccent,

                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             )
                         ),
                       ),),
                     SizedBox(height: 25,),
                     Obx(()=>Container(

                       margin: EdgeInsets.symmetric(horizontal: size.maxWidth*.15),
                       child: TextFormField(
                         controller: _password,
                         obscureText: controller.isPasswordHidden.value,
                         validator: MultiValidator([
                           RequiredValidator(errorText: "Password Should not be Empty")

                         ]),
                         style: GoogleFonts.mulish(),
                         autofocus: true,
                         keyboardType: TextInputType.visiblePassword,
                         cursorColor: Colors.purpleAccent,
                         cursorHeight: .2,
                         cursorRadius: Radius.circular(10),
                         decoration: InputDecoration(
                             labelText: "Password",
                             labelStyle: GoogleFonts.mulish(color: Colors.purpleAccent),
                             suffix: GestureDetector(
                               onTap: (){
                                 controller.ShowPassword();
                               },
                               child: controller.isPasswordHidden.value?Icon(Icons.visibility_rounded,color: Colors.purpleAccent,):Icon(Icons.visibility_off_rounded,color: Colors.purpleAccent,),
                             ),
                             suffixIconColor: Colors.purpleAccent,
                             prefixStyle: GoogleFonts.mulish(),
                             hintText: "Password",
                             disabledBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             enabledBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             focusedBorder:OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             ) ,
                             focusColor: Colors.purpleAccent,

                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(15),
                                 borderSide: BorderSide(
                                     color: Colors.purpleAccent
                                 )
                             )
                         ),
                       ),),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 50,),
               Obx(() => controller.isdisabled.value?Container(
                 child: CircularProgressIndicator(backgroundColor: Colors.purple,color: Colors.grey,),
               ):Container(
                   margin: EdgeInsets.symmetric(horizontal: 40),
                   child:ClipRRect(
                       borderRadius: BorderRadius.circular(29),
                       child: Container(
                         color: Colors.purpleAccent,
                         child: IconButton(
                           onPressed: ()async{
                             if(_formkey.currentState!.validate()){
                               try{
                                 controller.ButtonDisabled();
                                 await _auth.signInWithEmailAndPassword(email: _username.text, password: _password.text).then((value){
                                   controller.ButtonEnabled();
                                   Get.toNamed('/home',arguments: {
                                   });
                                 });
                               }catch(e){
                                 controller.ButtonEnabled();
                                 showDialog(context: context, builder: (context)=>AlertDialog(
                                   icon: Icon(Icons.warning,color: Colors.yellow,size: 80,),
                                   title: Text("Unable to Sign In."),
                                   content: Text("$e"),
                                   actions: [
                                     ElevatedButton(onPressed: (){
                                       Get.back();
                                     }, child: Text("Okay"))
                                   ],
                                 ));
                               }
                             }
                           },
                           icon: Icon(Icons.arrow_forward_rounded,color: Colors.white,),
                         ),
                       )
                   ))
               )
             ],
           ),
         ),
        ),
      ),
    );
  }
}