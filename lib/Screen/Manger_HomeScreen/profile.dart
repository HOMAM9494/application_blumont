import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUser extends StatefulWidget {
  ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  var db = FirebaseFirestore.instance;
 late String documentId='';
 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: db
          .collection('users')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get().then((value) {
        for (var dataId in value.docs) {
          String pre = dataId.id.toString();
          documentId = pre;
        };
        return user.doc(documentId).get();
      }),
        // future: user.doc(documentId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {
          if (snap.hasError) {
            return Text("Some thing went wrong");
          }
          if (snap.hasError && snap.data!.exists) {
            return Text("Some thing went wrong");
          }
          if (snap.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snap.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                Text('${data['name']}'),
                Text('${data['email']}'),
                Text('${data['phone']}'),
              ],
            );
          }
          return Text("Loading.........");
        });
  }
}
