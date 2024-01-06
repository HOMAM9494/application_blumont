import 'package:application_blumont/Screen/profial.dart';
import 'package:application_blumont/Screen/signin_up/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../firebace_user/user.dart';
import '../../sharing/my_text_field.dart';

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
  late UserInformation userinfo;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (val.length > 30) {
                        return 'Name too long';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: MyTextField(
                    controller: phoneController,
                    hintText: '07_********',
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(CupertinoIcons.phone_fill),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(r'^07+(?=.*?[0-9]).{8}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid phone';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: MyTextField(
                    controller: addressController,
                    hintText: 'Address',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.location_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (val.length > 30) {
                        return 'address too long';
                      }
                      return null;
                    }),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid email';
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
                        "⚈  1 uppercase",
                        style: TextStyle(
                            color: containsUpperCase
                                ? Colors.green
                                : Theme
                                .of(context)
                                .colorScheme
                                .onBackground),
                      ),
                      Text(
                        "⚈  1 lowercase",
                        style: TextStyle(
                            color: containsLowerCase
                                ? Colors.green
                                : Theme
                                .of(context)
                                .colorScheme
                                .onBackground),
                      ),
                      Text(
                        "⚈  1 number",
                        style: TextStyle(
                            color: containsNumber
                                ? Colors.green
                                : Theme
                                .of(context)
                                .colorScheme
                                .onBackground),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚈  1 special character",
                        style: TextStyle(
                            color: containsSpecialChar
                                ? Colors.green
                                : Theme
                                .of(context)
                                .colorScheme
                                .onBackground),
                      ),
                      Text(
                        "⚈  8 minimum character",
                        style: TextStyle(
                            color: contains8Length
                                ? Colors.green
                                : Theme
                                .of(context)
                                .colorScheme
                                .onBackground),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
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
                        return 'Please fill in this field';
                      } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    }),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
              !signUpRequired
                  ? SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          signUpRequired = true;
                        });
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          ).then((value) {
                            CollectionReference userdata = FirebaseFirestore
                                .instance.collection("users");
                            userdata.add(({
                              'name':nameController.text,
                              'Position':'manger',
                              'address':addressController.text,
                              'email':value.user!.email,
                              'password':passwordController.text,
                              'phone':phoneController.text,
                              'userid':value.user!.uid,
                            }));
                          });
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                " Please verification your email",
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.9),
                            ),
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return (WelcomeScreen());
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
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.9),
                            ),
                          );
                          setState(() {
                            signUpRequired = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor:
                        Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25, vertical: 5),
                      child: Text(
                        'Sign Up',
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
