import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  Map mapResponse = Map();
  List listOfUser = [];
  var validateLogin, errorType, errorTxt;
  final storage = new FlutterSecureStorage();

  //database
  // static const platform = const MethodChannel("com.flutter.epic/epic");

  @override
  void initState() {
    super.initState();
    isObscured = true;
    myFocusNode = FocusNode();
    validateLogin = true;
    errorTxt = "Email Does Not Exist";
    WidgetsBinding.instance.addPostFrameCallback((_) => checkLogged());
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
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Please sign in to continue',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),

                      // enter email info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: myFocusNode.hasFocus
                                        ? Colors.blue
                                        : Colors.black),
                                errorStyle: TextStyle(height: 0.05),
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                        .hasMatch(value)) {
                                  return "Invalid Email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Password entry
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: TextFormField(
                              controller: passController,
                              obscureText: isObscured,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: myFocusNode.hasFocus
                                          ? Colors.blue
                                          : Colors.black),
                                  errorStyle: TextStyle(height: 0.05),
                                  suffixIcon: IconButton(
                                    color: Colors.grey[800],
                                    padding: EdgeInsets.only(right: 12),
                                    icon: isObscured
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isObscured = !isObscured;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                } else if (value.length < 8)
                                  return "Ensure Password length is atleast 8";
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Forget Password? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/resetPass');
                              // Navigator.pushNamed(context, '/homePage');
                            },
                            child: Text(
                              'Click Here',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                      //Sign in button
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
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // validate();
                            postData();
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Not a member ? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () async {
                                final token = await storage.read(key: "token");
                                print(storage.read(key: "token"));
                                Navigator.pushNamed(context, '/signIn');
                              },
                              child: Text(
                                'Register now',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            )),
      ),
    );
  }

  Future<void> postData() async {
    var response = await http.post(Uri.parse("http://10.0.2.2:8080/login"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
            {'email': emailController.text, 'password': passController.text}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map["token"]);
      print(map['user_id']);
      await storage.write(key: 'token', value: map['token']);

      print("STORAGE");
      print(await storage.read(key: "token"));

      print(storage.write(key: "token", value: map["token"]));
      print(response.statusCode);
      Navigator.pushNamed(context, '/homePage');
    } else
      popup();
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Login Failed"),
              content: Text("Email or Password Error"),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                      // emailController.clear();
                      // passController.clear();
                    })
              ],
            ));
  }

  Future<void> checkLogged() async {
    final token = await storage.read(key: "token");
    print(await storage.read(key: "token"));
    if (token == null) {
      // token is null, stay in the login page
      print("THIS IS NULL");
    } else {
      // token is not null, go to the homepage
      print("THIS IS NOT NULL");
      Navigator.pushReplacementNamed(context, '/homePage');
    }
  }

  // Future<void> checkLogged() async {
  //   var securedKey = (await storage.read(key: "token"));
  //   var response2 = await http.get(
  //     Uri.parse("http://10.0.2.2:8080/test3"),
  //     headers: {
  //       'Authorization': '$securedKey',
  //     },
  //   );
  //   if (response2.statusCode == 200 && securedKey != null) {
  //     Navigator.pushReplacementNamed(context, '/homePage');
  //   } else
  //     Navigator.pushReplacementNamed(context, '/logIn');

  //   print(response2.statusCode);
  // }
}
