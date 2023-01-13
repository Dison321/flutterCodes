import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freelancer/pages/adminAcc/editUser.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

String email = "";

class adminUserPage extends StatefulWidget {
  const adminUserPage({super.key});

  @override
  State<adminUserPage> createState() => _adminUserPageState();
}

class _adminUserPageState extends State<adminUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  Map mapResponse = Map();
  List listOfUser = [], filteredListOfUsers = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkExp());

    getUsers();
    filteredListOfUsers = listOfUser;
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('List Of Users'),
            ),
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredListOfUsers = listOfUser
                                  .where((item) => item['username']
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredListOfUsers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                if (email ==
                                    filteredListOfUsers[index]['email']) {
                                  return;
                                }
                                print(filteredListOfUsers[index]['user_id']);
                                final userID =
                                    filteredListOfUsers[index]['user_id'];

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editUserPage(
                                        id: userID,
                                      ),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: email ==
                                          filteredListOfUsers[index]['email']
                                      ? Colors.grey[300]
                                      : Colors.white,
                                ),
                                child: ListTile(
                                  title: Text(
                                      filteredListOfUsers[index]['username']),
                                  subtitle:
                                      Text(filteredListOfUsers[index]['email']),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/admin');
                            },
                            label: Text('Back'),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      )
                    ]),
              ),
            )),
      ),
    );
  }

  //adminUser functions
  Future<void> checkExp() async {
    var securedKey = (await storage.read(key: "token"));
    final String? jwtToken = securedKey;
    print("JWTTOKEN =");
    print(jwtToken);
    print("SECUREDKEY = ");
    print(securedKey);
    var response2 = await http.get(
      Uri.parse("http://10.0.2.2:8080/auth"),
      headers: {
        'Authorization': '$jwtToken',
      },
    );
    if (response2.statusCode == 200) {
      print("Success");
      print(response2.body);
      print("done response body");
      getEmail();
    } else
      popup();

    print(response2.statusCode);
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Login Session Expired"),
              content: Text("Please Login Again"),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      await storage.write(key: 'token', value: null);
                      Navigator.pushReplacementNamed(context, '/logIn');
                      // emailController.clear();
                      // passController.clear();
                    })
              ],
            ));
  }

  Future<void> getEmail() async {
    var securedKey = (await storage.read(key: "token"));
    print(await storage.read(key: "token"));
    print("SECURED");
    print(securedKey);
    Map<String, dynamic> payload = Jwt.parseJwt(securedKey!);
    print(payload);
    print(payload["email"]);
    email = payload["email"];
  }

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
