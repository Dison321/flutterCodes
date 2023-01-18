import 'package:flutter/material.dart';
import 'package:freelancer/pages/adminAcc/adminPage.dart';
import 'package:freelancer/pages/adminAcc/adminSeller.dart';
import 'package:freelancer/pages/adminAcc/adminUser.dart';
import 'package:freelancer/pages/adminAcc/editUser.dart';
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

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/logIn',
      routes: {
        '/signIn': (context) => signUpPage(),
        '/logIn': (context) => loginPage(),
        '/resetPass': (context) => resetPassPage(),
        '/homePage': (context) => homePage(),
        '/profile': (context) => profilePage(),
        '/seller1': (context) => sellerAcc1Page(),
        '/education': (context) => educationPage(id: 0),
        '/skill': (context) => skillPage(id: 0),
        '/language': (context) => languagePage(id: 0),
        '/experience': (context) => experiencePage(id: 0),
        '/admin': (context) => adminPage(),
        '/adminUser': (context) => adminUserPage(),
        '/editUser': (context) => editUserPage(
              id: 0,
            ),
        '/adminSeller': (context) => adminSellerPage(),
      },
    ),
  );
}
