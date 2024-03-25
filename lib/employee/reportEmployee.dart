import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../sharing/my_text_field.dart';
import '../sharing/not.dart';

class UserReportOne extends StatefulWidget {
  const UserReportOne({super.key});

  @override
  State<UserReportOne> createState() => _UserReportOneState();
}

class _UserReportOneState extends State<UserReportOne> {
  CollectionReference<Map<String, dynamic>> activity =
      FirebaseFirestore.instance.collection('activity');
  List<QueryDocumentSnapshot> docReport = [];

  getdata() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('activity')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    docReport = querySnapshot.docs;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: activity.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),

            itemCount: docReport.length,
            // snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: BookNote.notesColor[index],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "اسم النشاط :${docReport[index]['activityName']} ",
                          style: themeText2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "وقت النشاط :${docReport[index]['activityTime']} ",
                          style: themeText2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "اسم موظف بلومونت : ${docReport[index]['blumontEmployee']}",
                          style: themeText2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "اسم مدرب النشاط : ${docReport[index]['activityCoach']}",
                          style: themeText2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: double.infinity,
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: BookNote.notesColor[index],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسم النشاط : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['activityName']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "قاعة النشاط : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['activityHall']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسم مدرب النشاط : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['activityCoach']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسم موظف بلومونت : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['blumontEmployee']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "عدد الحضور الذكور : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['maleNumber']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "عدد الحضور الإناث : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['femaleNumber']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "الفئة العمرية : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['ageGroup']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "مستلزمات النشاط :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['activitySupplies']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "وقت النشاط :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['activityTime']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "تحديات خلال النشاط :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['challenges']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "الانجازات خلال النشاط :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['achievements']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسماء الغياب اليوم :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${docReport[index]['staffName']}",
                                      style: themeText1,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "هل يوجد حجوزات لمنظمات خارجية :  ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: docReport[index]['Reservations']
                                                .toString() ==
                                            "true"
                                        ? Text(
                                            "نعم",
                                            style: themeText1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            "لا",
                                            style: themeText1,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                  ),
                                ],
                              ),
                              docReport[index]['Reservations'].toString() ==
                                      "true"
                                  ? org(docReport[index])
                                  : const Text(''),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget org(QueryDocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 2,
          color: Colors.white,
        ),
        Text(
          "اسم المنظمة : ${document['orgName']}",
          style: themeText2,
        ),
        Container(
          height: 2,
          color: Colors.white,
        ),
        Text(
          "عنوان النشاط  : ${document['orgActivity']}",
          style: themeText2,
        ),
        Container(
          height: 2,
          color: Colors.white,
        ),
        Text(
          "وقت النشاط  : ${document['orgActivityTime']}",
          style: themeText2,
        ),
        Container(
          height: 2,
          color: Colors.white,
        ),
        Text(
          "عدد الحضور  : ${document['orgNumberGroup']}",
          style: themeText2,
        ),
      ],
    );
  }
}
