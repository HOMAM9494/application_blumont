import 'package:application_blumont/Screen/Manger_HomeScreen/reports.dart';
import 'package:application_blumont/Screen/signin_up/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'department.dart';
import 'profile.dart';

class HomeAdmin extends StatefulWidget {
  final User user;

  HomeAdmin(this.user);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _currentIndex = 0;
  late User us = widget.user!;
  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  String iddoc = '';
  final List _pages = [Department(), Reports(), ProfileUser(), ProfileUser()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "welcame",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return ProfileUser();
                  }),
                );
              },
              icon: const Icon(Icons.output_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 45,
        ),
        backgroundColor: Color(0xff368983),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _currentIndex,
        height: 50.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.bar_chart_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.teal.shade800,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black54,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
// Icons.bar_chart_outlined
//Icon(
//                   Icons.account_balance_wallet_outlined,
//                   size: 30,
//                   color: _currentIndex == 2 ? Color(0xff368983) : Colors.grey,
//                 ),
// Icon(
//                   Icons.person_outlined,
//                   size: 30,
//                   color: _currentIndex == 3 ? Color(0xff368983) : Colors.grey,
//                 ),
//Icon(
//                   Icons.bar_chart_outlined,
//                   size: 30,
//                   color: _currentIndex == 1 ? Color(0xff368983) : Colors.grey,
//                 ),
