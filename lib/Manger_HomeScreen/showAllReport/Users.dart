import 'package:application_blumont/Manger_HomeScreen/showAllReport/userallReport.dart';
import 'package:application_blumont/signin_up/screen_signup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../sharing/not.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  CollectionReference<Map<String, dynamic>> items =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ScreenSignup();
            }),
          );
        },
      ),
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
              var document = snapshot.data!.docs[index];
              return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: BookNote.notesColor[index],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        document['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${document['email']}",
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document['Position'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document['phone'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document['address'],
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       IconButton(onPressed: (){
                      //         showDialog(
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return AlertDialog(
                      //               title: const Text('تنبيه هام '),
                      //               content: const Text('هل تريد حذف هذا هذا المستخدم'),
                      //               actions: <Widget>[
                      //                 TextButton(
                      //                   child: const Text('ألغاء'),
                      //                   onPressed: () {
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 ),
                      //                 TextButton(
                      //                     child: const Text('تأكيد'),
                      //
                      //                     onPressed: ()async {
                      //                        // await FirebaseAuth.instance.currentUser!.delete();
                      //                        await  items.doc(document.id).delete();
                      //                         print ((document['userid']));
                      //                       Navigator.of(context).pop();
                      //
                      //                       // Handle the confirm action
                      //                     }
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         ).then((value){
                      //           setState(() {
                      //           });
                      //         });
                      //       }, icon: Icon(Icons.delete_forever,size: 32,),),
                      // ],),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return UsersAllReport(userid: document["userid"]);
                    }),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
