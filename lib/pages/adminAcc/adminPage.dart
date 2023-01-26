import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../logIn.dart';

class adminPage extends StatefulWidget {
  const adminPage({super.key});

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  Map mapResponse = Map();
  List listOfUser = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome back
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        radius: 60,
                        backgroundColor: Colors.black,
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Please select the options',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),

                      //Edit User Button
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'User Management',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/adminUser');
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      //Edit Seller Button
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Sellers Listing',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/adminSeller');
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ]),
              ),
            )),
      ),
    );
  }

  //adminPage funciton

  //Logout functions that deleted jwt token in storage and returns to login page
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => loginPage()), (route) => false);
    print("after delete");
    print(await storage.read(key: "token"));
  }
}
