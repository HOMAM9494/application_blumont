
import 'dart:io';
import 'package:application_blumont/Screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/profial.dart';
import 'Screen/welcome_screen.dart';
 main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options:FirebaseOptions(
      apiKey: "AIzaSyBBAAGYGBAEAaaTNWAewu-RbbXc-iBMfUk",
      appId: "1:472860537070:android:fb986911035cbc5710c3ff",
      messagingSenderId: "472860537070",
      projectId: "blumontapp-a0bda",
    ),
  ):await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth (){
    bool auth=false;
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
       auth =false;
      } else {
        auth =true;
      }
    });
    return auth;
  }
  @override
  void initState() {

    super.initState();
     isAuth();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.black,
            primary: Color.fromRGBO(206, 147, 216, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(244, 143, 177, 1),
            onSecondary: Colors.white,
            tertiary: Color.fromRGBO(255, 204, 128, 1),
            error: Colors.red,
            outline: Color(0xFF424242)
        ),
      ),
      home: isAuth()?ProfilePage():WelcomeScreen(),
    );
  }
}
