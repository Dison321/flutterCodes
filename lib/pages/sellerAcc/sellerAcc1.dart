import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:intl/intl.dart';

final List<String> items = [
  'Sabah',
  'Kelantan',
  'Kedah',
  'Sarawak',
  'Selangor',
  'Johor',
  'Pahang',
  'Negeri Sembilan',
  'Terengganu',
  'Perak',
  'Malacca',
  'Perlis',
  'Penang',
];
String? selectedValue = items.first;

class sellerAcc1Page extends StatefulWidget {
  const sellerAcc1Page({super.key});

  @override
  State<sellerAcc1Page> createState() => _sellerAcc1PageState();
}

class _sellerAcc1PageState extends State<sellerAcc1Page> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map mapResponse = Map();
  List listOfUser = [];
  var duplicated, dateTime;
  final DateTime now = DateTime.now();
  final storage = new FlutterSecureStorage();
  final int sellerIdp = 0;

  TextEditingController dof = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController states = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController expectedSalary = TextEditingController();
  TextEditingController workExp = TextEditingController();

  @override
  void initState() {
    super.initState();
    isObscured = true;
    myFocusNode = FocusNode();
    duplicated = false;
    dateTime = 'Select Time';
    states.text = items.first;
    // check();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> calendar() async {
      await showDatePicker(
        context: context,
        initialDate: DateTime(2010),
        firstDate: DateTime(1900),
        lastDate: DateTime(2010),
      ).then((value) {
        setState(() {
          // String date = "${value!.year}-${value.month}-${value.day}";
          final dateFormat = DateFormat('yyyy-MM-dd');
          String formattedDate = dateFormat.format(value ?? DateTime.now());

          dof.text = formattedDate;
          dateTime = formattedDate;
        });
      });
    }

    return Form(
      key: _formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AppBar(
                    title: Text('Join Us'),
                    centerTitle: true,
                    backgroundColor: Colors.grey[700],
                    elevation: 0,
                  ),
                ),

                // DOF
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Date Of Birth',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                TextButton(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 200, 0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          dateTime.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    calendar();
                  },
                ),

                //Address
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: address,
                      maxLength: 150,
                      decoration: InputDecoration(
                        hintText: 'Your address',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Invalid Address";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //State
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'State',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      menuMaxHeight: 200.0,
                      value: selectedValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedValue = value!;
                          states.text = selectedValue.toString();
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Occupation
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Occupation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: occupation,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: 'Enter your occupation',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Occupation";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //Expected salary
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Expected Salary',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      maxLength: 9,
                      controller: expectedSalary,
                      decoration: InputDecoration(
                        hintText: 'Enter your expected salary',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Expected Salary";
                        } else if (!RegExp(r'^[0-9.]*$').hasMatch(value))
                          return "Invalid Value";
                        return null;
                      },
                    ),
                  ),
                ),
                //Working exp
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Working Experiences (Years)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      maxLength: 2,
                      controller: workExp,
                      decoration: InputDecoration(
                        hintText: "Enter years of Working Experience",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter years of Working Experience";
                        } else if (!RegExp(r'^[0-9]*$').hasMatch(value))
                          return "Invalid Value";
                        return null;
                      },
                    ),
                  ),
                ),
                TextButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (dateTime == 'Select Time') {
                      popup();
                    } else {
                      if (_formKey.currentState!.validate()) {
                        print(dof.text);
                        print(address.text);
                        print(occupation.text);
                        print(states.text);
                        print(expectedSalary.text);
                        print(workExp.text);
                        print("done");
                        registerData();
                      }
                    }
                  },
                ),

                //Terms & Condition
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'By joining, you agree to Freelance\'s ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //back to sign in

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  //sellerAcc1 function
  Future<void> registerData() async {
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
    var username = map['username'];

    var phoneNo = map['phoneNo'];
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
    } else
      print("WRONG");

    var getStateID = await http.post(Uri.parse("http://10.0.2.2:8080/StateID"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'state_name': states.text}));

    if (getStateID.statusCode == 200) {
      print("Success");
      print(getStateID.body);
    } else
      print("WRONG");
    Map<String, dynamic> map2 = jsonDecode(getStateID.body);
    print(map2['state_id']);
    var stateID = map2['state_id'];
    print("THIS IS STATEID");
    print(stateID);
    print(userId);
    print(username);

    print(phoneNo);
    var response3 = await http.post(Uri.parse("http://10.0.2.2:8080/seller"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode({
          'user_id': userId,
          "seller_name": username,
          'dof': dof.text,
          'tel_no': phoneNo,
          'address': address.text,
          'state_id': stateID,
          'occupation': occupation.text,
          'ex_salary': expectedSalary.text,
          'work_expyr': workExp.text,
        }));

    if (response3.statusCode == 200) {
      print("nice");
    } else
      print("Invalid controller");
  }

////
  ///
  ///
  ///
  ///
  Future<void> check() async {
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
    } else
      print("WRONG");

    Map<String, dynamic> map = jsonDecode(response.body);
    var userId = map['user_id'];
    var response2 = await http.post(Uri.parse("http://10.0.2.2:8080/UserId"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'user_id': userId}));
    if (response2.statusCode == 200) {
      print("Success");
      Navigator.pushNamed(context, '/homePage');
    } else
      print("WRONG");
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Invalid Joined Duration"),
              content: Row(
                children: [
                  Text("Please Re-enter Dates !"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      setState(() {
                        dateTime = 'Select Time';
                      });

                      Navigator.pop(context);
                    })
              ],
            ));
  }
}
