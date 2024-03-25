import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application_blumont/textfile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../sharing/my_text_field.dart';
import '../../sharing/not.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  CollectionReference<Map<String, dynamic>> items =
      FirebaseFirestore.instance.collection('activity');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: items.snapshots(),
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
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var nameUser;
              var deleteDoc;
              List idDevice=[];
              var document = snapshot.data!.docs[index];
              FirebaseFirestore.instance
                  .collection('users')
                  .where('userid', isEqualTo: document['userId'])
                  .get()
                  .then((value) {
                for (var dataId in value.docs) {
                  nameUser = dataId["name"];
                  deleteDoc=document.id;
                  idDevice= dataId["tokens"];
                }
              });
              return GestureDetector(
                child: Container(
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "اسم النشاط :${document['activityName']}",
                          style: themeText2,
                        ),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "وقت النشاط :${document['activityTime']} ",
                          style: themeText2,
                        ),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "اسم موظف بلومونت : ${document['blumontEmployee']}",
                          style: themeText2,
                        ),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        Text(
                          "اسم مدرب النشاط : ${document['activityCoach']}",
                          style: themeText2,
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
                              AppBar(
                                backgroundColor:Colors.black38 ,
                                title:
                                IconButton(
                                  onPressed: () async{
                                    String data = '${document.data()}';
                                    saveDataToFile01(data);
                                  },
                                  icon: Icon(Icons.share_outlined,size: 35,),),
                                leading: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('تنبيه هام '),
                                            content: const Text('هل تريد حذف هذا التقرير'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('ألغاء'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text('تأكيد'),
                                                onPressed: ()async {
                                                await  items.doc(deleteDoc.toString()).delete();
                                                Navigator.of(context).pop();
                                               // Handle the confirm action
                                                }
                                              ),
                                            ],
                                          );
                                        },
                                      ).then((value){
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      });
                                     },
                                    icon: Icon(Icons.delete_outline,size: 35,)),
                                actions: [
                                  IconButton(
                                      onPressed: ()async {
                                        for(int i=0;i<idDevice.length;i++){
                                          await sendMessage(nameUser,"hhhhhhhhhhhhh",idDevice[i]);
                                          print("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${idDevice[i].toString()}");
                                        }

                                      },
                                      icon: Icon(Icons.send,size: 35,),),
                                ],

                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "اسم كاتب التقرير : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$nameUser",
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
                                    "اسم النشاط : ",
                                    style: themeText,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${document['activityName']}",
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
                                      "${document['activityHall']}",
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
                                      "${document['activityCoach']}",
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
                                      "${document['blumontEmployee']}",
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
                                      "${document['maleNumber']}",
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
                                      "${document['femaleNumber']}",
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
                                      "${document['ageGroup']}",
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
                                      "${document['activitySupplies']}",
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
                                      "${document['activityTime']}",
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
                                      "${document['challenges']}",
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
                                      "${document['achievements']}",
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
                                      "${document['staffName']}",
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
                                    child: Text(
                                      "${document['Reservations']}",
                                      style: themeText1,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              document['Reservations'].toString() == "true"
                                  ? org(document)
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
      children: [
        Container(
          height: 2,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "اسم المنظمة :  ",
              style: themeText,
            ),
            Expanded(
              child: Text(
                "${document['orgName']}",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "عنوان النشاط :  ",
              style: themeText,
            ),
            Expanded(
              child: Text(
                "${document['orgActivity']}",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "وقت النشاط :  ",
              style: themeText,
            ),
            Expanded(
              child: Text(
                "${document['orgActivityTime']}",
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "عدد الحضور :  ",
              style: themeText,
            ),
            Expanded(
              child: Text(
                "${document['orgNumberGroup']}",
                style: themeText1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  sendMessage(title , bodyMessage,idDevice)async{
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAVRN5BvY:APA91bF-7-qQ0HE1xwnMks5zi0iDSrJ2gzAcvqXPLAZOHD7-abmZ1sdhs6MhlT3yavrsHgrbohPPiqX8sJGojrIBHIkRB6ouTGyZEOqMRcjzqRHPEpfg3k5mxKtnDEVZNwXAyZ_R6ahP'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to":idDevice.toString(),
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
