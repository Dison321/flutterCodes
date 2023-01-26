import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freelancer/pages/data/EducationsList.dart';
import 'package:freelancer/pages/data/ExperiencesList.dart';
import 'package:freelancer/pages/data/LanguageList.dart';
import 'package:freelancer/pages/data/SkillsList.dart';

import 'package:http/http.dart' as http;

class editSellerPage extends StatefulWidget {
  final int id;
  // const editSellerPage({super.key});
  editSellerPage({required this.id});

  @override
  State<editSellerPage> createState() => _editSellerPageState();
}

class _editSellerPageState extends State<editSellerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Seller's Data
  var username = "-",
      phoneNo = "-",
      dof = "-",
      address = "-",
      state = "-",
      occupation = "-",
      expectedSalary = "-",
      workExp = 0;
  //Education's Data
  var qualification = "-",
      university = "-",
      graduationDate = "-",
      fos = "-",
      cgpa = 0;
  //Experience's Data
  var job = "-",
      joinedStart = "-",
      joinedEnd = "-",
      desc = "-",
      cmpName = "-",
      industryName = "-";
  Map mapResponse = Map();
  List listOfSkills = [], listOfLanguage = [], listOfEdu = [], listOfExp = [];
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData(context));

    getSeller(widget.id);
    getSkills(widget.id);
    getEducations(widget.id);
    getLanguages(widget.id);
    getExperience(widget.id);
  }

  void _fetchData(BuildContext context) async {
    // show the loading dialog
    showDialog(
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

  //fetchData() functions is used to display a loading circle when this page runs.
  //In inistate(), all the get...() functions is used to get all the list of data that the seller had by passing
  //sellerID to the API.

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
                        height: 550,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
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
                      SkillsListPage(
                        id: widget.id,
                      ),

//Educations Sections
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Educations",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      EducationsListPage(
                        id: widget.id,
                      ),

                      //Experiences Sections
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Experiences",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      ExperiencesListPage(
                        id: widget.id,
                      ),

                      //LANGUAGES Sections
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          "Languages",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      LanguageListPage(
                        id: widget.id,
                      ),
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

//getSeller
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

  //getEducations
  Future<void> getEducations(sellerID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/findEduData"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'seller_id': sellerID}));

    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);
      }
      setState(() {
        listOfEdu.addAll(temp);
      });
    } else
      print("failed");

    print("done response body");
  }

//getExperiences
  Future<void> getExperience(sellerID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/findExpData"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'seller_id': sellerID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);
      }
      setState(() {
        listOfExp.addAll(temp);
      });
    } else
      print("failed");

    print("done response body");
    // if (response.statusCode == 200) {
    //   print("Success");
    //   print(response.body);
    //   Map<String, dynamic> map = jsonDecode(response.body);
    //   print(map['seller_id']);
    //   setState(() {
    //     job = map['job'];
    //     joinedStart = map['joined_start'];
    //     joinedEnd = map['joined_end'];
    //     desc = map['description'];
    //     cmpName = map['company_name'];
    //     industryName = map['industry_type'];
    //   });
    //   print(response.statusCode);
    // } else
    //   print("WRONG");
  }

  //getSkills
  Future<void> getSkills(sellerID) async {
    var response = await http.post(Uri.parse("http://10.0.2.2:8080/findSkills"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'seller_id': sellerID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);
      }
      setState(() {
        listOfSkills.addAll(temp);
      });
    } else
      print("failed");

    print("done response body");
  }

  //getLanguage
  Future<void> getLanguages(sellerID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/findLanguages"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'seller_id': sellerID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);
      }
      setState(() {
        listOfLanguage.addAll(temp);
      });
    } else
      print("failed");

    print("done response body");
  }
}
