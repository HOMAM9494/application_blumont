import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookNote {
  String title;
  String date;
  String content;

  BookNote({required this.title, required this.date, required this.content});
  CollectionReference dataReport = FirebaseFirestore.instance.collection('activity');
  static List getListOfNotes() {
    List list = [];
    FirebaseFirestore.instance
        .collection('activity')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(doc);
      }
    });
    return list;
  }

  static List<Color> notesColor = [
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
    Colors.blueGrey.shade100,
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.yellow.shade200,
    Colors.orange.shade200,
    Colors.pink.shade200,
    Colors.blueGrey.shade100,
  ];
}
