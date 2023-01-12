import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

int userID = 0;

class editSellerPage extends StatefulWidget {
  final int id;
  // const editSellerPage({super.key});
  editSellerPage({required this.id});

  @override
  State<editSellerPage> createState() => _editSellerPageState();
}

class _editSellerPageState extends State<editSellerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var username = "Seller Name",
      phoneNo = "phoneNo",
      dof = "dof",
      address = "address",
      state = "State Name",
      occupation = "Occupation",
      expectedSalary = "expectedSalary",
      workExp = 0;
  Map mapResponse = Map();
  List listOfUser = [];
  final storage = new FlutterSecureStorage();
  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));

    getSeller(widget.id);
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
                  title: Text('Seller\'s Data'),
                ),
                backgroundColor: Colors.white,
                body: Container(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: 500,
                        color: Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                                radius: 60,
                                backgroundColor: Colors.black,
                              ),
                              SizedBox(height: 10),
                              Text(
                                username,
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              //DOF
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.cake,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Date Of Birth : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      dof,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ), //Phone No
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                              //Address
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Address : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      address,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //State
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.location_city_outlined,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "State : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      state,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Occupation
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.work,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Occupation : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      occupation,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Expected Salary
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.monetization_on_outlined,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Expected Salary : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      expectedSalary,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Working Experiences
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Working Experience Year : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      workExp.toString(),
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

//Skills Sections

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Skills",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      Container(
                        color: Colors.grey[200],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.cake,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Date Of Birth : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    dof,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.cake,
                                      color: Colors.grey,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    "Date Of Birth : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                  Text(
                                    dof,
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
                        //
                      ), //P
                      // TextButton(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 15),
                      //     child: Container(
                      //       padding: EdgeInsets.all(20),
                      //       decoration: BoxDecoration(
                      //           color: Colors.green,
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: Center(
                      //         child: Text(
                      //           'Convert To Admin',
                      //           style:
                      //               TextStyle(color: Colors.white, fontSize: 15),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ]),
                  ),
                ))));
  }

  //editSeller functions

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

  Future<void> getSeller(sellerID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/findSellerData"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'seller_id': sellerID}));

    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['seller_id']);
      setState(() {
        username = map['seller_name'];
        phoneNo = map['tel_no'];
        dof = map['dof'];
        address = map['address'];
        state = map['state_name'];
        occupation = map['occupation'];
        expectedSalary = map['ex_salary'];
        workExp = map['work_expyr'];
      });
      print(response.statusCode);
    } else
      print("WRONG");
  }
}
