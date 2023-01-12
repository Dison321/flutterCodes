import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import '../logIn.dart';

int userID = 0;

class editUserPage extends StatefulWidget {
  final int id;
  // const editUserPage({super.key});
  editUserPage({required this.id});

  @override
  State<editUserPage> createState() => _editUserPageState();
}

class _editUserPageState extends State<editUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var username = "username",
      phoneNo = "phoneNo",
      email = "email",
      role = "role";
  Map mapResponse = Map();
  List listOfUser = [];
  final storage = new FlutterSecureStorage();
  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));

    getUsers(widget.id);
  }

  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 2));

    Navigator.of(context).pop();
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
                appBar: AppBar(
                  title: Text('User\'s Data'),
                ),
                backgroundColor: Colors.white,
                body: Container(
                  child: Column(children: [
                    Container(
                      height: 400,
                      color: Colors.grey[200],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/profile.png'),
                              radius: 60,
                              backgroundColor: Colors.black,
                            ),
                            SizedBox(height: 10),
                            Text(
                              username,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Email : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    email,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Phone No : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    phoneNo,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.people,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Role : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    role,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              'Convert To Admin',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (role == "Admin") {
                          popup2();
                        } else {
                          changeAdmin(widget.id);
                          popup();
                        }
                      },
                    ),
                  ]),
                ))));
  }

  //editUser functions

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Converted Succesfully"),
              content: Row(
                children: [
                  Icon(Icons.people, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text("User is now an Admin"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/adminUser');
                    })
              ],
            ));
  }

  void popup2() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Invalid"),
              content: Row(
                children: [
                  Icon(Icons.people, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text("User is already an Admin"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.pop(context);
                    })
              ],
            ));
  }

  Future<void> changeAdmin(userID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/changeAdmin"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'user_id': userID}));

    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      // Map<String, dynamic> map = jsonDecode(response.body);

      // setState(() {
      //   role = map['role'];
      // });
      print(response.statusCode);
    } else
      print("WRONG");
  }

  Future<void> getUsers(userID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/UserIdAdmin"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'user_id': userID}));

    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['user_id']);
      setState(() {
        username = map['username'];
        email = map['email'];
        phoneNo = map['phoneNo'];
        role = map['role'];
      });
      print(response.statusCode);
    } else
      print("WRONG");
  }
}
