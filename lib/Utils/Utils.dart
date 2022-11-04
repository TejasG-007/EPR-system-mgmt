import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../Controller/Controller_State.dart';

Widget IconHeading(String label, BoxConstraints size) => Row(
      children: [
        Icon(Icons.center_focus_strong_outlined),
        Container(
          margin: EdgeInsets.all(10),
          alignment: size.maxWidth > 450 ? Alignment.topLeft : Alignment.center,
          child: Text(
            "$label",
            style: GoogleFonts.mulish(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

final SalaryValidator = MultiValidator([
  RequiredValidator(errorText: "Salary Should Not be Empty"),
  PatternValidator(r'^[0-9]+$', errorText: "Salary Should be in Integer Only.")
]);

Widget ResonsiveSalary({
  required BoxConstraints constraint,
  required TextEditingController Salary_gov,
  required TextEditingController Salary_pvt,
  required GlobalKey<FormState> key,
}) {
  return constraint.maxWidth > 450
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
                size: constraint.maxWidth / 5,
                controller: Salary_gov,
                fieldName: "Salary-GOV",
                key: TextInputType.number,
                prefix: const Icon(
                  Icons.currency_rupee_outlined,
                  color: Colors.green,
                ),
                validator: SalaryValidator),

            DecoratedTextFormField(
                size: constraint.maxWidth / 5,
                controller: Salary_pvt,
                fieldName: "Salary-PVT",
                key: TextInputType.number,
                prefix: const Icon(
                  Icons.currency_rupee_rounded,
                  color: Colors.green,
                ),
                validator: SalaryValidator),
          ],
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DecoratedTextFormField(
                size: constraint.maxWidth / 1.5,
                controller: Salary_gov,
                fieldName: "Salary-GOV",
                key: TextInputType.number,
                prefix: const Icon(
                  Icons.currency_rupee_outlined,
                  color: Colors.green,
                ),
                validator: SalaryValidator),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
                size: constraint.maxWidth / 1.5,
                controller: Salary_pvt,
                fieldName: "Salary-PVT",
                key: TextInputType.number,
                prefix: const Icon(
                  Icons.currency_rupee_rounded,
                  color: Colors.green,
                ),
                validator: SalaryValidator),
            const SizedBox(
              height: 10,
            ),
          ],
        );
}

final c = Get.put(ControllerState());

Widget DecoratedTextFormField(
    {required double size,
    required TextEditingController controller,
    required String fieldName,
    required TextInputType key,
    prefix,
    required String? Function(String?) validator}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: size,
    child: TextFormField(
      validator: validator,
      keyboardType: key,
      cursorRadius: const Radius.circular(3),
      cursorColor: Colors.purpleAccent,
      controller: controller,
      decoration: InputDecoration(
        prefix: prefix,
        labelText: fieldName,
        labelStyle: GoogleFonts.mulish(color: Colors.green),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.purpleAccent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green)),
      ),
    ),
  );
}





Widget ResponsiveUserDetails({
  required BoxConstraints constraints,
  required TextEditingController UniqueId,
  required TextEditingController Name,
  required TextEditingController Mobile,
  required TextEditingController JoiningDate,
}) {
  return constraints.maxWidth > 450
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              size: constraints.maxWidth / 4,
              controller: UniqueId,
              fieldName: "Employee-Id",
              key: TextInputType.text,
              prefix: null,
              validator: MultiValidator([
                RequiredValidator(errorText: "Employee Id should not be null"),
                PatternValidator(r'^[0-9]+$', errorText: "Employee Id should be in Integer only.")
              ])
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 4,
              controller: Name,
              fieldName: "Full Name",
              key: TextInputType.text,
              prefix: null,
              validator: MultiValidator([
                RequiredValidator(errorText: "Full Name Id should not be null"),
                PatternValidator(r'^[a-z A-Z,.\-]+$', errorText: "Enter Full Name as \n First Middle Last")
              ])
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 4,
              controller: Mobile,
              fieldName: "Mobile",
              key: TextInputType.number,
              prefix: Text(
                "+91",
                style: GoogleFonts.mulish(),
              ),
              validator: MultiValidator(
                 [
                   RequiredValidator(errorText: "Mobile should not be null"),
                   PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                 ]
              )

            ),
            Expanded(
              child: DateTimePicker(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Joining Date should not be Empty.";
                    }
                  },
                  decoration: InputDecoration(
                    prefix: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.purpleAccent,
                    ),
                    labelText: "Joining Date",
                    labelStyle: GoogleFonts.mulish(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.purpleAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                  ),
                  controller: JoiningDate,
                  type: DateTimePickerType.date,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now()),
            )
          ],
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: UniqueId,
              fieldName: "Employee-Id",
              key: TextInputType.text,
              prefix: null,
              validator:MultiValidator([
                RequiredValidator(errorText: "Employee Id should not be null"),
                PatternValidator(r'^[0-9]+$', errorText: "Employee Id should be in Integer only.")
              ])
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: Name,
              fieldName: "Full Name",
              key: TextInputType.text,
              prefix: null,
              validator:  MultiValidator([
                RequiredValidator(errorText: "Full Name should not be null"),
                PatternValidator(r'^[a-z A-Z,.\-]+$', errorText: "Enter Full Name as \n First Middle Last")
              ])
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: Mobile,
              fieldName: "Mobile",
              key: TextInputType.number,
              prefix: Text(
                "+91",
                style: GoogleFonts.mulish(),
              ),
              validator:MultiValidator(
                  [
                    RequiredValidator(errorText: "Mobile should not be null"),
                    PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                  ]
              )
            ),
            const SizedBox(
              height: 10,
            ),
            DateTimePicker(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Joining Date should not be Empty.";
                  }
                },
                decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.purpleAccent,
                  ),
                  labelText: "Joining Date",
                  labelStyle: GoogleFonts.mulish(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purpleAccent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                ),
                controller: JoiningDate,
                type: DateTimePickerType.date,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now())
          ],
        );
}


final controller = Get.put(ControllerState());
List dta = ["YES","NO"];

Widget ResponsiveDailyDataDetails({
  required BoxConstraints constraints,
  required TextEditingController Remark,
  required TextEditingController DSP,
  required TextEditingController DSC,

  
}) {
  return constraints.maxWidth > 550
      ?Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .7,
                        blurRadius: 8,
                        blurStyle: BlurStyle.inner,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                children: [
                  Text("Signature",style: GoogleFonts.mulish(),),
                  SizedBox(height: 10,),
                  ToggleSwitch(
                    initialLabelIndex: dta.indexOf(controller.Signature.value),
                    totalSwitches: 2,
                    labels: ['YES', 'NO'],
                    activeBgColor: const[
                      Colors.green
                    ],
                    onToggle: (index) {
                      if(index==0){
                        controller.Signature.value="YES";
                      }else{
                        controller.Signature.value="NO";
                      }
                    },

                  ),
                ],
              ),
            ),),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: .7,
                          blurRadius: 8,
                          blurStyle: BlurStyle.inner,
                          offset: Offset(1, 1))
                    ]),
                child: Column(
                  children: [
                    Text("Uniform",style: GoogleFonts.mulish(),),
                    SizedBox(height: 10,),
                    ToggleSwitch(
                      initialLabelIndex: dta.indexOf(controller.Uniform.value),
                      totalSwitches: 2,
                      labels: ['YES', 'NO'],
                      activeBgColor: const[
                        Colors.green
                      ],
                      onToggle: (index) {
                        if(index==0){
                          controller.Uniform.value="YES";
                        }else{
                        controller.Uniform.value="NO";
                        }
                      },

                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: .7,
                        blurRadius: 8,
                        blurStyle: BlurStyle.inner,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                children: [
                  Text("Id-Card",style: GoogleFonts.mulish(),),
                  SizedBox(height: 10,),
                  ToggleSwitch(
                    initialLabelIndex: dta.indexOf(controller.Id_card.value),
                    totalSwitches: 2,
                    labels: ['YES', 'NO'],
                    activeBgColor: const[
                      Colors.green
                    ],
                    onToggle: (index) {
                      if(index==0){
                        controller.Id_card.value="YES";
                      }else{
                      controller.Id_card.value="NO";
                      }
                    },

                  ),
                ],
              ),
            ),)
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
                size: constraints.maxWidth / 4,
                controller: DSP,
                fieldName: "DSP",
                key: TextInputType.text,
                validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "DSP should not be null"),
                      // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                    ]
                )

            ),
            DecoratedTextFormField(
                size: constraints.maxWidth / 4,
                controller: DSC,
                fieldName: "DSC",
                key: TextInputType.text,
                validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "DSP should not be null"),
                      // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                    ]
                )

            ),
            DecoratedTextFormField(
                size: constraints.maxWidth / 4,
                controller: Remark,

                fieldName: "Remark",
                key: TextInputType.text,
                validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "Remark should not be null"),
                      // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                    ]
                )

            ),
          ],
        ),
    ],
  )
      : Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: .7,
                      blurRadius: 8,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(1, 1))
                ]),
            child: Column(
              children: [
                Text("Signature",style: GoogleFonts.mulish(),),
                SizedBox(height: 10,),
                ToggleSwitch(
                  initialLabelIndex: dta.indexOf(controller.Signature.value),
                  totalSwitches: 2,
                  labels: ['YES', 'NO'],
                  activeBgColor: const[
                    Colors.green
                  ],
                  onToggle: (index) {
                    if(index==0){
                      controller.Signature.value="YES";
                    }else{
                    controller.Signature.value="NO";
                    }
                  },

                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: .7,
                      blurRadius: 8,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(1, 1))
                ]),
            child: Column(
              children: [
                Text("Uniform",style: GoogleFonts.mulish(),),
                SizedBox(height: 10,),
                ToggleSwitch(
                  initialLabelIndex: dta.indexOf(controller.Uniform.value),
                  totalSwitches: 2,
                  labels: ['YES', 'NO'],
                  activeBgColor: const[
                    Colors.green
                  ],
                  onToggle: (index) {
                    if(index==0){
                      controller.Uniform.value="YES";
                    }else{
                    controller.Uniform.value="NO";
                    }
                  },

                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: .7,
                      blurRadius: 8,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(1, 1))
                ]),
            child: Column(
              children: [
                Text("Id-Card",style: GoogleFonts.mulish(),),
                SizedBox(height: 10,),
                ToggleSwitch(
                  initialLabelIndex: dta.indexOf(controller.Id_card.value),
                  totalSwitches: 2,
                  labels: ['YES', 'NO'],
                  activeBgColor: const[
                    Colors.green
                  ],
                  onToggle: (index) {
                    if(index==0){
                      controller.Id_card.value="YES";
                    }else{
                    controller.Id_card.value="NO";
                    }
                  },

                ),
              ],
            ),
          )
        ],
      ),
      SizedBox(height: 20,),
      Column(
        children: [
          DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: DSP,
              fieldName: "DSP",
              key: TextInputType.text,
              validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "DSP should not be null"),
                    // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                  ]
              )

          ),
          SizedBox(height: 10,),
          DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: DSC,
              fieldName: "DSC",
              key: TextInputType.text,
              validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "DSP should not be null"),
                    // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                  ]
              )

          ),
          SizedBox(height: 10,),
          DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: Remark,

              fieldName: "Remark",
              key: TextInputType.text,
              validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "Remark should not be null"),
                    // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',errorText: "Please Enter Valid Mobile Number")
                  ]
              )

          ),
        ],
      ),
    ],
  );
}


Widget ResponsiveLeaveDetails({
  required BoxConstraints constraints,
  required TextEditingController CasualLeaveTaken,
  required TextEditingController CasualLeaveTakenDate,
  required TextEditingController DutyLeaveTaken,
  required TextEditingController DutyLeaveTakenDate,
}) {
  return constraints.maxWidth > 450
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              size: constraints.maxWidth / 4,
              controller: CasualLeaveTaken,
              fieldName: "Casual Leave Taken",
              key: TextInputType.text,
              prefix: null,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Casual Leave Taken should not be Empty.";
                }
              },
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 4,
              controller: DutyLeaveTaken,
              fieldName: "Duty Leave Taken",
              key: TextInputType.text,
              prefix: null,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Duty Leave Taken should not be Empty.";
                }
              },
            ),
          ],
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: CasualLeaveTaken,
              fieldName: "CasualLeaveTaken",
              key: TextInputType.text,
              prefix: null,
              validator: (val) {
                if (val!.isEmpty) {
                  return "CasualLeaveTaken  should not be Empty.";
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              size: constraints.maxWidth / 1.5,
              controller: DutyLeaveTaken,
              fieldName: "DutyLeaveTaken",
              key: TextInputType.text,
              prefix: null,
              validator: (val) {
                if (val!.isEmpty) {
                  return "DutyLeaveTaken  should not be Empty.";
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            DateTimePicker(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Joining Date should not be Empty.";
                  }
                },
                decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.purpleAccent,
                  ),
                  labelText: "Joining Date",
                  labelStyle: GoogleFonts.mulish(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purpleAccent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                ),
                controller: null,
                type: DateTimePickerType.date,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100))
          ],
        );
}

Widget ResponsiveFeedback({
  required BoxConstraints constraints,
  required TextEditingController Feedback_oral,
  required TextEditingController Feedback_written,
  required TextEditingController Feedback_Date,
}) {
  return constraints.maxWidth > 450
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              fieldName: "Oral Feedback(%)",
              size: constraints.maxWidth / 3,
              controller: Feedback_oral,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Oral Feedback should not be Empty.";
                }
              },
            ),
            DecoratedTextFormField(
              fieldName: "Written Feedback(%)",
              size: constraints.maxWidth / 3,
              controller: Feedback_written,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Written Feedback should not be Empty.";
                }
              },
            ),
            Expanded(
              child: DateTimePicker(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Feedback Date should not be Empty.";
                    }
                  },
                  decoration: InputDecoration(
                    prefix: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.purpleAccent,
                    ),
                    labelText: "Feedback Date",
                    labelStyle: GoogleFonts.mulish(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.purpleAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                  ),
                  controller: Feedback_Date,
                  type: DateTimePickerType.dateTime,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100)),
            )
          ],
        )
      : Column(
          children: [
            DateTimePicker(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Feedback Date should not be Empty.";
                  }
                },
                decoration: InputDecoration(
                  prefix: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.purpleAccent,
                  ),
                  labelText: "Feedback Date",
                  labelStyle: GoogleFonts.mulish(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purpleAccent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                ),
                controller: Feedback_Date,
                type: DateTimePickerType.dateTime,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100)),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              fieldName: "Oral Feedback",
              size: constraints.maxWidth / 1.5,
              controller: Feedback_oral,
              key: TextInputType.text,
              validator: RequiredValidator(errorText:  "Oral Feedback Should not be Empty"),
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              fieldName: "Written Feedback(%)",
              size: constraints.maxWidth / 1.5,
              controller: Feedback_written,
              key: TextInputType.text,
              validator: RequiredValidator(errorText: "Written Feedback Should not be Empty"),
            ),
          ],
        );
}

Widget ResponsiveFeedbackDialog({
  required BoxConstraints constraints,
  required TextEditingController Feedback_oral,
  required TextEditingController Feedback_written,
  required TextEditingController Feedback_Date,
  required GlobalKey<FormState> key,
}) {
  return constraints.maxWidth > 450
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedTextFormField(
              fieldName: "Oral Feedback(%)",
              size: constraints.maxWidth / 5,
              controller: Feedback_oral,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Oral Feedback should not be Empty.";
                }
              },
            ),
            DecoratedTextFormField(
              fieldName: "Written Feedback(%)",
              size: constraints.maxWidth / 5,
              controller: Feedback_written,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Written Feedback  should not be Empty.";
                }
              },
            ),
            Expanded(
              flex: 2,
              child: DateTimePicker(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Feedback Date should not be Empty.";
                    }
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today_outlined),
                    prefix: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.purpleAccent,
                    ),
                    labelText: "Feedback Date",
                    labelStyle: GoogleFonts.mulish(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.purpleAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.green)),
                  ),
                  controller: Feedback_Date,
                  type: DateTimePickerType.dateTime,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100)),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        )
      : Column(
          children: [
            DateTimePicker(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Feedback Date should not be Empty.";
                  }
                },
                decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.purpleAccent,
                  ),
                  labelText: "Feedback Date",
                  labelStyle: GoogleFonts.mulish(color: Colors.green),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purpleAccent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green)),
                ),
                controller: Feedback_Date,
                type: DateTimePickerType.dateTime,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100)),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              fieldName: "Oral Feedback(%)",
              size: constraints.maxWidth / 1.5,
              controller: Feedback_oral,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Oral Feedback should not be Empty.";
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DecoratedTextFormField(
              fieldName: "Written Feedback(%)",
              size: constraints.maxWidth / 1.5,
              controller: Feedback_written,
              key: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Written Feedback should not be Empty.";
                }
              },
            ),
          ],
        );
}



 HomeBackAlertDialog(BuildContext context){
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.done,color: Colors.green,),
        title: Text("Submitted Successfully.",style: GoogleFonts.mulish(
            color: Colors.black),),
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
      ));
}