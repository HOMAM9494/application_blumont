import 'package:application_blumont/Manger_HomeScreen/home_screen_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../sharing/dropdownbutton.dart';
import '../sharing/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;
  String positionController = 'Employee';
  List<String> type = ['Employee', 'Manger'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: nameController,
                    hintText: 'الاسم',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      } else if (val.length > 50) {
                        return 'الاسم طويل';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: phoneController,
                    hintText: '07_********',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      } else if (!RegExp(r'^07+(?=.*?[0-9]).{8}$')
                          .hasMatch(val)) {
                        return 'الرجاء التاكد من رقم الهاتف';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: addressController,
                    hintText: 'العنوان',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.location_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: emailController,
                    hintText: 'الإيميل',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'الرجاء ادخال الايميل بشكل صحيح';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                    controller: passwordController,
                    hintText: 'كلمة السر',
                    obscureText: obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    onChanged: (val) {
                      if (val!.contains(RegExp(r'[A-Z]'))) {
                        setState(() {
                          containsUpperCase = true;
                        });
                      } else {
                        setState(() {
                          containsUpperCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[a-z]'))) {
                        setState(() {
                          containsLowerCase = true;
                        });
                      } else {
                        setState(() {
                          containsLowerCase = false;
                        });
                      }
                      if (val.contains(RegExp(r'[0-9]'))) {
                        setState(() {
                          containsNumber = true;
                        });
                      } else {
                        setState(() {
                          containsNumber = false;
                        });
                      }
                      if (val.contains(RegExp(
                          r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                        setState(() {
                          containsSpecialChar = true;
                        });
                      } else {
                        setState(() {
                          containsSpecialChar = false;
                        });
                      }
                      if (val.length >= 8) {
                        setState(() {
                          contains8Length = true;
                        });
                      } else {
                        setState(() {
                          contains8Length = false;
                        });
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'الرجاء تعبئة الحقل';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                          .hasMatch(val)) {
                        return 'الرجاء ادخال كلمة السر صحيحة ';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 حرف كبير",
                        style: TextStyle(
                            color: containsUpperCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground),
                      ),
                      Text(
                        "⚈  1 حرف صغير",
                        style: TextStyle(
                            color: containsLowerCase
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground),
                      ),
                      Text(
                        "⚈  1 رقم",
                        style: TextStyle(
                            color: containsNumber
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 رمز خاص",
                        style: TextStyle(
                            color: containsSpecialChar
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground),
                      ),
                      Text(
                        "⚈  8 خانات فأكثر",
                        style: TextStyle(
                            color: contains8Length
                                ? Colors.green
                                : Theme.of(context).colorScheme.onBackground),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DropdownButtonWidget(
                list1: type,
                dropdownValue: positionController,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              !signUpRequired
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                signUpRequired = true;
                              });
                              try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ).then((value) {
                                 CollectionReference userdata =
                                      FirebaseFirestore.instance
                                          .collection("users");
                                  userdata.add(({
                                    'name': nameController.text.trim(),
                                    'Position': positionController.trim(),
                                    'address': addressController.text.trim(),
                                    'email': value.user!.email,
                                    'password': passwordController.text.trim(),
                                    'phone': phoneController.text.trim(),
                                    'userid': value.user!.uid,
                                  }));
                                  value.user!.sendEmailVerification();
                                }).asStream()  ;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Column(
                                      children: [
                                        const Text(
                                          " تم اضافة مستخدم جديد",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const Text(
                                          " الرجاء التاكد من الايميل",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.9),
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return (HomeAdmin());
                                  }),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.code,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.9),
                                  ),
                                );
                                setState(() {
                                  signUpRequired = false;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      e.toString(),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.9),
                                  ),
                                );
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              'تسجيل ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    )
                  : const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
