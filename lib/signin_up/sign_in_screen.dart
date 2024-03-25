import 'package:application_blumont/signin_up/screen_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Manger_HomeScreen/home_screen_admin.dart';
import '../employee/employee.dart';
import '../sharing/my_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String? Position;
  var tokenid;

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }

  Future<void> setupToken(token) async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  @override
  Widget build(BuildContext context) {
    var nav = Navigator.of(context);
    var scaffold = ScaffoldMessenger.of(context);
    var them = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                  controller: emailController,
                  hintText: 'الإيميل',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  errorMsg: _errorMsg,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'الرجاء تعبئة هذا الحقل';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                        .hasMatch(val)) {
                      return 'الرجاء ادخال الايميل بشكل صحيح';
                    }
                    return null;
                  })),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              controller: passwordController,
              hintText: 'كلمة السر ',
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(CupertinoIcons.lock_fill),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'الرجاء تعبئة هذا الحقل';
                } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                    .hasMatch(val)) {
                  return 'الرجاء ادخل كلمة السر صحيحة';
                }
                return null;
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                    if (obscurePassword) {
                      iconPassword = CupertinoIcons.eye_fill;
                    } else {
                      iconPassword = CupertinoIcons.eye_slash_fill;
                    }
                  });
                },
                icon: Icon(iconPassword),
              ),
            ),
          ),
          const SizedBox(height: 25),
          if (!signInRequired)
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        signInRequired = true;
                      });
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                        if (credential.user!.emailVerified) {
                          String? token =
                              await FirebaseMessaging.instance.getToken();
                          users
                              .where('userid', isEqualTo: credential.user!.uid)
                              .get()
                              .then((value) async {
                            for (var dataId in value.docs) {
                              setState(() {
                                Position = dataId["Position"].toString();
                                tokenid = dataId.id;
                              });
                            } ///////////////////////////////////
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(tokenid.toString())
                                .update({
                              'tokens': FieldValue.arrayUnion([token]),
                            });
                          }).then((value) {
                            if (Position == "Manger") {
                              nav.pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return HomeAdmin();
                                }),
                              );
                            } else {
                              nav.pushReplacement(
                                MaterialPageRoute(builder: (context) {
                                  return const EmployeePage();
                                }),
                              );
                            }
                          });
                        } else {
                          nav.pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const ScreenSignin();
                            }),
                          );
                          scaffold.showSnackBar(
                            SnackBar(
                              content: const Text(
                                " الرجاء التحقق من الايميل ",
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor:
                                  them.colorScheme.primary.withOpacity(0.9),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          scaffold.showSnackBar(const SnackBar(
                              content: Text(
                            'لا يوجد مستخدم لهذا الايميل.',
                            style: TextStyle(fontSize: 16),
                          )));
                        } else if (e.code == 'wrong-password') {
                          scaffold.showSnackBar(const SnackBar(
                              content: Text(
                            'خطا في كلمة السر .',
                            style: TextStyle(fontSize: 16),
                          )));
                        }
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text(
                              'خطأ في الايميل او كلمة السر ',
                              style: TextStyle(fontSize: 16),
                            ),
                            backgroundColor:
                                them.colorScheme.primary.withOpacity(0.6),
                          ),
                        );
                        setState(() {
                          signInRequired = false;
                        });
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                      elevation: 3.0,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            )
          else
            const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
