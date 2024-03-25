import 'dart:async';

import 'package:application_blumont/signin_up/screen_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'Manger_HomeScreen/home_screen_admin.dart';
import 'employee/employee.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
String postion = "";
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  Widget page(String Position) {
    if (Position == "Manger") {
      return HomeAdmin();
    } else {
      return const EmployeePage();
    }
  }
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        users.where('userid', isEqualTo: user.uid).get().then((value) {
          for (var dataId in value.docs) {
            postion = dataId["Position"].toString();
            setState(() {});
          }
        }).then((value) {
          print('User is signed in! $postion');
          setState(() {});

        });
      }
    });
    super.initState();
    loadData();
  }

  void loadData() async {
    // Simulating data fetching from Firebase
    await Future.delayed(Duration(seconds: 5));
    // Simulating 2 seconds delay
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? Lottie.asset('assets/login/a0.json')
            : (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser!.emailVerified)
            ? page(postion)
            : const ScreenSignin(),
      ),
    );
  }
}
