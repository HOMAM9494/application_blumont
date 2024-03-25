import 'dart:ui';
import 'package:application_blumont/signin_up/screen_signin.dart';
import 'package:application_blumont/signin_up/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("تسجيل مستخدم"),actions: [
        IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return const ScreenSignin();
                }),
              );
            },
            icon: const Icon(Icons.output_rounded))
      ],) ,
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
      body: SingleChildScrollView(
        primary: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(20, -0.8), //20  -1.2
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-2, -0.5), //-2.7 -1.2
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(2.5, -0.5),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(25),
                  ),
                  child:Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: TabBar(
                              controller: tabController,
                              unselectedLabelColor: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                              labelColor:
                              Theme.of(context).colorScheme.onBackground,
                              tabs: const [
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'اضافة مستخدم جديد',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: const [
                                  SignUpScreen(),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ) ,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
