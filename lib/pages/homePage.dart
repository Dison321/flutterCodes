import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/BottomNavBar.dart';
import 'package:freelancer/pages/logIn.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) => checkExp());
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

                    Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        'Please sign in to continue',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),

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
                              'Log Out',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        logout();
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
                              loggedIn();
                              checkExp();
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
          ),
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => loginPage()), (route) => false);
    print("after delete");
    print(await storage.read(key: "token"));
  }

  Future<void> loggedIn() async {
    var securedKey = (await storage.read(key: "token"));
    print(await storage.read(key: "token"));
    print("SECURED");
    print(securedKey);
    Map<String, dynamic> payload = Jwt.parseJwt(securedKey!);
    print(payload);
    print(payload["email"]);
    var response = await http.post(Uri.parse("http://10.0.2.2:8080/loginId"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'email': payload["email"]}));
    final value = await storage.read(key: "token");
    if (value == null) {
      print("TRUE");
    } else {
      print("FALSE");
    }
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['user_id']);
      print(response.statusCode);
    } else
      print("WRONG");

    Map<String, dynamic> map = jsonDecode(response.body);
    var userId = map['user_id'];
    print(map['user_id']);
    var response2 = await http.post(Uri.parse("http://10.0.2.2:8080/UserId"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'user_id': userId}));

    if (response2.statusCode == 200) {
      print("Success");
      print(response2.body);
      Map<String, dynamic> map = jsonDecode(response2.body);
      print(map['user_id']);
      print(response2.statusCode);
      if (map['role'] == "Admin") {
        Navigator.pushReplacementNamed(context, '/admin');
      }
    } else
      print("WRONG");
  }

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
      loggedIn();
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
}
