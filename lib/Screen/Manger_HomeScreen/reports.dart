import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../card_view.dart';


class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final CollectionReference users = FirebaseFirestore.instance.collection('department');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 5.0, // Spacing between columns
          mainAxisSpacing: 5.0, // Spacing between rows
        ),
        itemCount: 5, // Number of items in the GridView
        itemBuilder: (context, index) {
          // A widget to be displayed at each index
          return CardView();
        },
      ),
    );
  }
}
