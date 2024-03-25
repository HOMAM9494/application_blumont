import 'dart:async';
import 'dart:io';
import 'package:application_blumont/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Manger_HomeScreen/home_screen_admin.dart';
import 'employee/employee.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb || Platform.isAndroid?
       await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyAqaxIaPZeltG7mtCV5YUcZvwcluOB2aEw",
            appId: "1:365398918902:android:fd6f6a09da6fefae598ed7",
            messagingSenderId: "365398918902",
            projectId: "blumont-2024",
            storageBucket: "gs://blumont-2024.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String postion = "";

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
          // if (Position == "Manger") {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) {
          //       return HomeAdmin ();
          //     }),
          //   );
          // } else {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) {
          //       return EmployeePage();
          //     }),
          //   );
          // }
          print('User is signed in! $postion');
          setState(() {
          });
        });
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'), // English
      ],
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
              outline: Color(0xFF424242)),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal.shade800,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          fontFamily: 'SFProDisplay-Semibold'),

      // home: (FirebaseAuth.instance.currentUser != null &&
      //         FirebaseAuth.instance.currentUser!.emailVerified)
      //     ? page(postion)
      //     : const ScreenSignin(),
      home: SplashScreen(),
    );
  }
}
