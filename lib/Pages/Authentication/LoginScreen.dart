import 'dart:ffi';
import 'dart:io';

import 'package:e_commerce_app/utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../Routes/RouteHelper.dart';
import '../../utils/Dimensions.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignUpScreen = false;
  bool isPasswordField = false;
  bool isPassworduppercase = false;
  bool isPasswordnumber = false;
  bool isPasswordspecialcharacter = false;

  late String _emailLogIn, _passwordLogIn;
  late String _emailSignUp, _passwordSignUp;
  final auth = FirebaseAuth.instance;

  final storage = new FlutterSecureStorage();

  onPasswordChanged(String value) {
    final ucaseRegex = RegExp(r'[A-Z]');
    setState(() {
      isPassworduppercase = false;
      if (ucaseRegex.hasMatch(value)) isPassworduppercase = true;
    });
    final numberRegex = RegExp(r'[0-9]');
    setState(() {
      isPasswordnumber = false;
      if (numberRegex.hasMatch(value)) isPasswordnumber = true;
    });
    final specialcharacterRegex = RegExp(r"[!@#$%^&*()]");
    setState(() {
      isPasswordspecialcharacter = false;
      if (specialcharacterRegex.hasMatch(value))
        isPasswordspecialcharacter = true;
    });
  }

  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 80, 170, 0),
              child: Container(
                height: 35,
                width: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: mainColor, width: 3),
                  color: buttonBackgroundColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignUpScreen = false;
                        });
                      },
                      child: isSignUpScreen
                          ? Container(
                              height: 35,
                              width: 89,
                              alignment: Alignment.center,
                              child: Text("Log In",
                                  style: TextStyle(
                                    fontSize: 13,
                                  )),
                            )
                          : Container(
                              height: 35,
                              width: 89,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpScreen = true;
                          });
                        },
                        child: isSignUpScreen
                            ? Container(
                                height: 35,
                                width: 89,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Container(
                                height: 35,
                                width: 89,
                                alignment: Alignment.center,
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ))
                  ],
                ),
              ),
            ),
            isSignUpScreen
                ? Container(
                    margin: EdgeInsets.fromLTRB(30, 60, 30, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1.3,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                                "Welcome to DairyOnGo! For a fresh start..",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _emailSignUp = value.trim();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter E-mail",
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                  hintStyle: TextStyle(fontSize: 16),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    _passwordSignUp = value.trim();
                                    onPasswordChanged(value);
                                  });
                                },
                                onTap: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 500));
                                  setState(() {
                                    isPasswordField = true;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Password",
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                  hintStyle: TextStyle(fontSize: 16),
                                )),
                          ),
                          isPasswordField
                              ? AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  margin: EdgeInsets.only(top: 20),
                                  duration: Duration(seconds: 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Make The Strong Password",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              letterSpacing: 1.7,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: 13,
                                              width: 13,
                                              decoration: BoxDecoration(
                                                  color: isPassworduppercase
                                                      ? mainColor
                                                      : Colors.transparent,
                                                  border: isPassworduppercase
                                                      ? Border.all(
                                                          color: Colors
                                                              .transparent)
                                                      : Border.all(
                                                          color: Colors.grey,
                                                          width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                "Contains at least one uppercase",
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    letterSpacing: 1.2,
                                                    fontSize: 12))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: 13,
                                              width: 13,
                                              decoration: BoxDecoration(
                                                  color: isPasswordnumber
                                                      ? mainColor
                                                      : Colors.transparent,
                                                  border: isPasswordnumber
                                                      ? Border.all(
                                                          color: Colors
                                                              .transparent)
                                                      : Border.all(
                                                          color: Colors.grey,
                                                          width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("Contains at least one number",
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    letterSpacing: 1.2,
                                                    fontSize: 12))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              height: 13,
                                              width: 13,
                                              decoration: BoxDecoration(
                                                  color:
                                                      isPasswordspecialcharacter
                                                          ? mainColor
                                                          : Colors.transparent,
                                                  border:
                                                      isPasswordspecialcharacter
                                                          ? Border.all(
                                                              color:
                                                                  Colors
                                                                      .transparent)
                                                          : Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                "Contains at least one special character",
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    letterSpacing: 1.2,
                                                    fontSize: 12))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 5,
                                ),
                          Center(
                            child: Image.asset(
                              "assets/image/signup.png",
                              scale: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Material(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () async {
                                  auth
                                      .createUserWithEmailAndPassword(
                                    email: _emailSignUp,
                                    password: _passwordSignUp,
                                  )
                                      .then((_) {
                                    setState(() {
                                      isSignUpScreen = false;
                                    });
                                    Get.offAndToNamed(
                                        RouteHelper.getAuthentication());
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 400,
                                  child: Text(
                                    "Sign Up !! Let`s Go!",
                                    style: TextStyle(
                                        color: buttonBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  )
                : Container(
                    margin: EdgeInsets.fromLTRB(30, 60, 30, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1.3,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                                "Welcome to DairyOnGo, please fill the details below to Log In",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _emailLogIn = value.trim();
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Enter E-mail",
                                  labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                  labelText: "Email",
                                  hintStyle: TextStyle(fontSize: 16),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _passwordLogIn = value.trim();
                                });
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                                hintStyle: TextStyle(fontSize: 16),
                                labelText: "Password",
                              ),
                            ),
                          ),
                          Center(
                            child: Image.asset("assets/image/login.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Material(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () async {
                                  try {
                                    await auth
                                        .signInWithEmailAndPassword(
                                          email: _emailLogIn,
                                          password: _passwordLogIn,
                                        )
                                        .then((_) => Get.toNamed(
                                            RouteHelper.getInitial()));

                                    var user =
                                        FirebaseAuth.instance.currentUser!;
                                    ref.child(user.uid);
                                  } on FirebaseAuthException catch (e) {
                                    print('Failed with error code: ${e.code}');
                                    print(e.message);
                                    Get.snackbar(
                                      "Wrong Credential",
                                      "Re-Enter Email & Password !!",
                                      backgroundColor: mainColor,
                                      colorText: white,
                                      duration:
                                          const Duration(milliseconds: 1500),
                                    );
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 400,
                                  child: Text(
                                    "Log In !! Let`s Go!",
                                    style: TextStyle(
                                        color: buttonBackgroundColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
          ],
        ),
      )),
    );
  }
}
