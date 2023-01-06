import 'package:flutter/material.dart';
import 'package:freelancer/pages/homePage.dart';
import 'package:freelancer/pages/logIn.dart';
import 'package:freelancer/pages/sellerAcc/education.dart';
import 'package:freelancer/pages/sellerAcc/experience.dart';
import 'package:freelancer/pages/sellerAcc/language.dart';
import 'package:freelancer/pages/sellerAcc/profile.dart';
import 'package:freelancer/pages/sellerAcc/sellerAcc1.dart';
import 'package:freelancer/pages/sellerAcc/skill.dart';
import 'package:freelancer/pages/signUp.dart';
import 'package:freelancer/pages/resetPass.dart';
import 'package:freelancer/api.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/homePage',
      routes: {
        '/signIn': (context) => signUpPage(),
        '/logIn': (context) => loginPage(),
        '/resetPass': (context) => resetPassPage(),
        '/homePage': (context) => homePage(),
        '/api': (context) => apiPage(),
        '/profile': (context) => profilePage(),
        '/seller1': (context) => sellerAcc1Page(),
        '/education': (context) => educationPage(),
        '/skill': (context) => skillPage(),
        '/language': (context) => languagePage(),
        '/experience': (context) => experiencePage(),
      },
    ),
  );
}
