import 'dart:io';
import 'package:application_blumont/Screen/Manger_HomeScreen/home_screen_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/signin_up/welcome_screen.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Platform.isAndroid
  //     ? await Firebase.initializeApp(
  //         options: const FirebaseOptions(
  //           apiKey: "AIzaSyAqaxIaPZeltG7mtCV5YUcZvwcluOB2aEw",
  //           appId: "1:365398918902:android:80acb25a4fc5e6a2598ed7",
  //           messagingSenderId: "365398918902",
  //           projectId: "blumont-2024",
  //         ),
  //       )
  //     : await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
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
            outline: Color(0xFF424242)),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade800,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ?  HomeAdmin(FirebaseAuth.instance.currentUser!)
          : const WelcomeScreen(),
    );
  }
}
