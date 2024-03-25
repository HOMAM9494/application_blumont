
import 'package:application_blumont/employee/reportEmployee.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Manger_HomeScreen/Screenes/profile.dart';
import '../cubit/navbar_bolc.dart';
import '../cubit/naverbar_states.dart';
import '../signin_up/screen_signin.dart';
import 'addReport/add_report.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  final List _pages = [const UserReportOne(), const ProfileUser()];
  final List trans = ["التقارير", "الصفحة الشخصية"];
@override
  void initState() {

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const UserReportOne();
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
          var navBloc = NavbarCubit.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child:const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const AddReport();
                  }),
                );
              },
            ),
            appBar: AppBar(
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "${trans[navBloc.counter]}",
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
            body: _pages[navBloc.counter],
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: navBloc.counter,
              height: 50.0,
              items: const <Widget>[
                Icon(
                  Icons.library_books_sharp,
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
                navBloc.getCounter(index);
              },
            ),
          );
        },
      ),
    );
  }
}
