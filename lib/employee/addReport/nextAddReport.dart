
import 'dart:convert';
import 'package:application_blumont/employee/addReport/shiredvalue.dart';
import 'package:application_blumont/employee/employee.dart';
import 'package:application_blumont/sharing/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NextReport extends StatefulWidget {
  List data;

  NextReport({super.key, required this.data});

  @override
  State<NextReport> createState() => _NextReportState();
}

class _NextReportState extends State<NextReport> {
  CollectionReference report =
      FirebaseFirestore.instance.collection('activity');
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  String reservations = "false";
void cleantext(){
  activityName.clear();
  activityHall.clear();
  activityCoach.clear();
  blumontEmployee.clear();
  maleNumber.clear();
  femaleNumber.clear();
  ageGroup.clear();
  activitySupplies.clear();
  activityTime.clear();
  challenges.clear();
  achievements.clear();
  staffName.clear();
  reservations;
  orgName.clear();
  orgActivity.clear();
  orgNumberGroup.clear();
  orgActivityTime.clear();
}
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التحديات  و الحلول المقترحة '),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MyTextField(
                        controller: challenges,
                        hintText: 'يرجى ذكر التحديات والحلول المقترحة هنا',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.import_contacts),
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
                        controller: achievements,
                        hintText: 'يرجى ذكر الإنجازات هنا',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_alt),
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
                        controller: staffName,
                        hintText:
                            'الغياب ( اسماء المتطوعين المجازين في ذلك اليوم )',
                        obscureText: false,
                        keyboardType: TextInputType.multiline,
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black26,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.teal.shade700,
                            ),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: const Center(
                              child: Text(
                                'الحجوزات',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'هل يوجد حجوزات للقاعات من قبل منظمات خارجية في هذا اليوم؟',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          RadioListTile(
                            title: const Text("لا"),
                            value: "false",
                            groupValue: reservations,
                            onChanged: (value) {
                              setState(() {
                                reservations = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: const Text("نعم"),
                            value: "true",
                            groupValue: reservations,
                            onChanged: (value) {
                              setState(() {
                                reservations = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (reservations == "false") const Text("") else activity(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await report.add({
                                'docId': report.id,
                                'userId':
                                    FirebaseAuth.instance.currentUser!.uid,
                                'activityName': activityName.text,
                                'activityHall': activityHall.text,
                                'activityCoach': activityCoach.text,
                                'blumontEmployee': blumontEmployee.text,
                                'maleNumber': maleNumber.text,
                                'femaleNumber': femaleNumber.text,
                                'ageGroup': ageGroup.text,
                                'activitySupplies': activitySupplies.text,
                                'activityTime': activityTime.text,
                                'challenges': challenges.text,
                                'achievements': achievements.text,
                                'staffName': staffName.text,
                                'Reservations': reservations,
                                'orgName': orgName.text,
                                'orgActivity': orgActivity.text,
                                'orgNumberGroup': orgNumberGroup.text,
                                'orgActivityTime': orgActivityTime.text,
                              }).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تمت إضافة البيانات بنجاح'),
                                  ),
                                );
                                sendMessage("ارسال هذا الاشعار ${blumontEmployee.text}","${ activityName.text }+${activityCoach.text}");

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const EmployeePage()));
                              });
                              cleantext();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('حدث خطأ أثناء إضافة البيانات')),
                              );
                            }
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
                            'ارسال البيانات',
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

  Widget activity() {
    return Column(
      children: [
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: MyTextField(
              controller: orgName,
              hintText: 'اسم المنظمة',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon:
                  const Icon(CupertinoIcons.list_bullet_below_rectangle),
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
              controller: orgActivity,
              hintText: 'عنوان النشاط',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.import_contacts),
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
                  orgNumberGroup.text=value!.format(context);
                });
              },
              controller: orgNumberGroup,
              hintText: 'عدد الحضور',
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(CupertinoIcons.group),
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
              controller: orgActivityTime,
              hintText: 'وقت النشاط',
              obscureText: false,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(CupertinoIcons.time_solid),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'الرجاء تعبئة هذا الحقل';
                }
                return null;
              }),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }
  sendMessage(title , bodyMessage)async{
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAVRN5BvY:APA91bF-7-qQ0HE1xwnMks5zi0iDSrJ2gzAcvqXPLAZOHD7-abmZ1sdhs6MhlT3yavrsHgrbohPPiqX8sJGojrIBHIkRB6ouTGyZEOqMRcjzqRHPEpfg3k5mxKtnDEVZNwXAyZ_R6ahP'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": "/topics/Manger",
      "notification": {
        "title": title,
        "body": bodyMessage,
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);


    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
    }
  }
}
