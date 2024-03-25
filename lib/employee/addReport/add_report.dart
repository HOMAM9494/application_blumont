import 'package:application_blumont/employee/addReport/shiredvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sharing/my_text_field.dart';
import 'nextAddReport.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  late List data = [];
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  var gender;
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    data.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انشطة المركز ',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: activityName,
                        hintText: 'اسم النشاط',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(
                            CupertinoIcons.list_bullet_below_rectangle),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: activityHall,
                        hintText: 'قاعة النشاط',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.import_contacts),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          } else if (val.length > 50) {
                            return 'الاسم طويل يرجى تقصير الاسم';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: activityCoach,
                        hintText: 'اسم المدرب المسؤول عن النشاط',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_alt),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          } else if (val.length > 50) {
                            return 'الاسم طويل يرجى تقصير الاسم';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: blumontEmployee,
                        hintText: ' اسم موظف بلومنت',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: maleNumber,
                        hintText: 'عدد حضور الجلسة ذكور',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon:
                            const Icon(CupertinoIcons.person_crop_circle_fill),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: femaleNumber,
                        hintText: 'عدد حضور الجلسة إناث',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.person_pin_sharp),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: ageGroup,
                        hintText: '  الفئة العمرية 20 - 25 مثال ',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.groups),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: activitySupplies,
                        hintText: 'مستلزمات النشاط',
                        obscureText: false,
                        keyboardType: TextInputType.multiline,
                        prefixIcon: const Icon(Icons.person_pin_sharp),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        onTap: () async {
                          showTimePicker(context: context, initialTime: TimeOfDay.now()).
                          then((value) {
                            activityTime.text=value!.format(context);
                          });
                        },

                        controller: activityTime,
                        hintText: 'وقت النشاط',
                        obscureText: false,
                        keyboardType: TextInputType.datetime,
                        prefixIcon: const Icon(Icons.person_pin_sharp),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'الرجاء تعبئة هذا الحقل';
                          }
                          return null;
                        }),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            data.add({
                              activityName,
                              activityHall,
                              activityCoach,
                              blumontEmployee,
                              maleNumber,
                              femaleNumber,
                              ageGroup,
                              activitySupplies,
                              activityTime
                            });
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return NextReport(
                                  data: data,
                                );
                              }),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60))),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'الصفحة التالية',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////
