import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class resetPassPage extends StatefulWidget {
  const resetPassPage({super.key});

  @override
  State<resetPassPage> createState() => _resetPassPageState();
}

class _resetPassPageState extends State<resetPassPage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map mapResponse = Map();
  List listOfUser = [];
  var duplicated, validateReset;

  TextEditingController resetEmail = TextEditingController();
  //database
  // static const platform = const MethodChannel("com.flutter.epic/epic");

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    validateReset = true;
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: AppBar(
                          title: Text('Reset Password'),
                          centerTitle: true,
                          backgroundColor: Colors.grey[700],
                          elevation: 0,
                        ),
                      ),

                      // Welcome back
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        radius: 60,
                        backgroundColor: Colors.black,
                      ),
                      Text(
                        'Reset Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                          child: Text(
                            'Please enter your email address to reset your password.',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
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
                              controller: resetEmail,
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

                      //Sign in button
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print('Completed');
                            validate();
                            return;
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/logIn');
                        },
                        child: Text(
                          'Back to log in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ]),
              ),
            )),
      ),
    );
  }

  //login validate
  Future<void> getData() async {
    var url = Uri.parse("http://10.0.2.2:8080/Users");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          listOfUser = json.decode(response.body);
          // listOfUser = mapResponse['fname'];
        });
      }
    } else
      print('Not Receiving');

    return;
  }

//validating func
  Future<void> validate() async {
    getData();
    print(resetEmail.text);
    for (int i = 0; i < listOfUser.length; i++) {
      print(listOfUser[i]);
      Map<String, dynamic> map = listOfUser[i];
//map['fname'] == emailController.text
      if (await map.containsValue(resetEmail.text)) {
        setState(() {
          validateReset = true;
        });
        break;
      } else {
        print("Email Does Not Exist");
        setState(() {
          validateReset = false;
        });
      }
    }

    if (validateReset == false) {
      print("Failed to Reset");
    } else {
      print("Reset Success");
      Navigator.pushNamed(context, '/signIn');
    }
    getData();

    return;
  }
}
