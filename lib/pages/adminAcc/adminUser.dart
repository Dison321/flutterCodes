import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/adminAcc/editUser.dart';

import 'package:http/http.dart' as http;

class adminUserPage extends StatefulWidget {
  const adminUserPage({super.key});

  @override
  State<adminUserPage> createState() => _adminUserPageState();
}

class _adminUserPageState extends State<adminUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map mapResponse = Map();
  List listOfUser = [];

  @override
  void initState() {
    super.initState();
    getUsers();
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //  for (int i = 0; i < listOfUser.length; i++)
                      //       print(listOfUser[i]["username"]);
                      //   },
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: listOfUser.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       for (int i = 0; i < listOfUser.length; i++) {
                      //         print(listOfUser[i]["username"]);
                      //       }
                      //       return ListTile(
                      //         title: Text(listOfUser[index]['username']),
                      //         subtitle: Text(listOfUser[index]['email']),
                      //       );
                      //     },
                      //   ),
                      // )
                      Expanded(
                        child: ListView.builder(
                          itemCount: listOfUser.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print(listOfUser[index]['user_id']);
                                final userid = listOfUser[index]['user_id'];
                                // Navigator.pushNamed(context, '/editUser',
                                //     arguments: listOfUser[index]['user_id']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editUserPage(
                                        id: userid,
                                      ),
                                    ));
                              },
                              child: ListTile(
                                title: Text(listOfUser[index]['username']),
                                subtitle: Text(listOfUser[index]['email']),
                              ),
                            );
                          },
                        ),
                      )
                    ]),
              ),
            )),
      ),
    );
  }

  //adminUser functions

  Future<void> getUsers() async {
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/Users"),
    );
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);

        // Map<String, dynamic> map = list[i];
        // print(map["user_id"]);
        // print(map["username"]);
        // print(map["email"]);
        // print(map["phoneNo"]);
        // print(map["password"]);
        // print(map["role"]);

        // temp.add(map["qualification_type"]);
      }
      setState(() {
        listOfUser.addAll(temp);
      });
      // setState(() {
      //   itemQ.clear();
      //   itemQ.addAll(temp);
      //   selectedValue = itemQ.first;
      //   qualification.text = itemQ.first;
      // });
    } else
      print("failed");

    print("done response body");
  }
}
