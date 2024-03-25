

import 'package:application_blumont/Manger_HomeScreen/showAllReport/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/navbar_bolc.dart';
import '../cubit/naverbar_states.dart';
import '../signin_up/screen_signin.dart';
import 'Report/report.dart';
import 'Screenes/profile.dart';

class HomeAdmin extends StatefulWidget {


  HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();

  final List _pages = [const Reports(),const Users(), const ProfileUser()];
  final List trans = ["التقارير","المستخدمين", "الصفحة الشخصية"];



  getInit()async{
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return  HomeAdmin();
        }),

      );
    }
  }
  subscribeManger()async{
    await FirebaseMessaging.instance.subscribeToTopic('Manger');
  }
@override
  void initState() {
  getInit();
  subscribeManger();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return  HomeAdmin();
      }),
    );

  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    if(message!=null){
      print("/////////////////////////////////////");
      print(message.notification!.title);
      print(message.notification!.body);
      print("/////////////////////////////////////");
    }
  });

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NavbarCubit(),
      child: BlocConsumer<NavbarCubit, NavbarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var navbloc = NavbarCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "${trans[navbloc.counter]}",
              ),
              actions: [
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
              ],
            ),

            body: _pages[navbloc.counter],
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: navbloc.counter,
              height: 50.0,
              items: const <Widget>[
                Icon(
                  Icons.library_books_sharp,
                  size: 30,
                  color: Colors.white,
                ),
                Icon(
                  Icons.groups,
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
                navbloc.getCounter(index);
              },
            ),
          );
        },
      ),
    );
  }
}
