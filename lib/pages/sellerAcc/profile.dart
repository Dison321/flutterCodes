import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/logIn.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../BottomNavBar.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var username = "username", phoneNo = "phoneNo", email = "email";
  Map mapResponse = Map();
  List listOfUser = [];
  var validateprofile, errorType, errorTxt;
  final storage = new FlutterSecureStorage();

  //database
  // static const platform = const MethodChannel("com.flutter.epic/epic");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkExp());
    asyncMethod();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));
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

    // Close the dialog programmatically
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: 270,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                          phoneNo,
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
          SizedBox(height: 5),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _detailsCard(),
            SizedBox(
              height: 10,
            ),
          ])
        ]),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            //row for each deatails

            TextButton(
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text("Education"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (() {
                  Navigator.pushNamed(context, '/education');
                })),
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            TextButton(
                child: ListTile(
                  leading: Icon(Icons.lightbulb),
                  title: Text("Skills"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (() {
                  Navigator.pushNamed(context, '/skill');
                })),
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            TextButton(
                child: ListTile(
                  leading: Icon(Icons.workspace_premium),
                  title: Text("Experience"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (() {
                  Navigator.pushNamed(context, '/experience');
                })),
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            TextButton(
                child: ListTile(
                  leading: Icon(Icons.language),
                  title: Text("Language"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onPressed: (() {
                  Navigator.pushNamed(context, '/language');
                })),
            Container(
              height: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            TextButton(
                child: ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text("Log Out"),
                  trailing: Icon(Icons.exit_to_app),
                ),
                onPressed: (() {
                  logout();
                })),
          ],
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

  Future<void> checkExp() async {
    var securedKey = (await storage.read(key: "token"));
    final String? jwtToken = securedKey;
    print("JWTTOKEN =");
    print(jwtToken);
    print("SECUREDKEY = ");
    print(securedKey);
    var response2 = await http.get(
      Uri.parse("http://10.0.2.2:8080/test3"),
      headers: {
        'Authorization': '$jwtToken',
      },
    );
    if (response2.statusCode == 200) {
      print("Success");
      print(response2.body);
      print("done response body");
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
      setState(() {
        username = map['username'];
        email = map['email'];
        phoneNo = map['phoneNo'];
      });
      print(response2.statusCode);
    } else
      print("WRONG");
  }

  void asyncMethod() async {
    await loggedIn();
  }
}
