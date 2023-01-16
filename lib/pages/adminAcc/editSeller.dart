import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  List listOfSkills = [], listOfLanguage = [];
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

                      Container(
                        color: Colors.grey[200],
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
//
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listOfSkills.length == 0
                                    ? 1
                                    : listOfSkills.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (listOfSkills.length == 0) {
                                    return ListTile(
                                      title: Text(
                                        "< Not Entered Skills Yet >",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  return ListTile(
                                    title:
                                        Text(listOfSkills[index]['skill_name']),
                                    subtitle: Text(listOfSkills[index]
                                        ['skill_proficient_type']),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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
                      Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //University
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.school,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "University : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      university,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ), //field of study
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.library_books,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Field Of Study : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      fos,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Qualification
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                            size: 24.0,
                                          ),
                                        ),
                                        Text(
                                          "Qualification : ",
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
                                      qualification,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Graduation Date
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Graduation Date : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      graduationDate,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //CGPA
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
                                      "CGPA : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      cgpa.toString(),
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

                      Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Company Name
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.work_outline_outlined,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Company Name : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      cmpName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //job
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
                                      "Job : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      job,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //joinedStarted Date
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Date Started : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      joinedStart,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //joinedEnd Date
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Date Ended : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      joinedEnd,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //industry
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.factory,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),
                                    ),
                                    Text(
                                      "Industry : ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600]),
                                    ),
                                    Text(
                                      industryName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //desc
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
                                            Icons.description,
                                            color: Colors.grey,
                                            size: 24.0,
                                          ),
                                        ),
                                        Text(
                                          "Description : ",
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
                                      desc,
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

                      Container(
                        color: Colors.grey[200],
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
//
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listOfLanguage.length == 0
                                    ? 1
                                    : listOfLanguage.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (listOfLanguage.length == 0) {
                                    return ListTile(
                                      title: Text(
                                        "< Not Entered Languages Yet >",
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }
                                  return ListTile(
                                    title: Text(
                                        listOfLanguage[index]['language_name']),
                                    subtitle: Text(listOfLanguage[index]
                                        ['language_proficient_level']),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
//
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
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['seller_id']);
      setState(() {
        qualification = map['qualification_type'];
        university = map['university'];
        graduationDate = map['graduation_date'];
        fos = map['field_of_study'];
        cgpa = map['cgpa'];
      });
      print(response.statusCode);
    } else
      print("WRONG");
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
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map['seller_id']);
      setState(() {
        job = map['job'];
        joinedStart = map['joined_start'];
        joinedEnd = map['joined_end'];
        desc = map['description'];
        cmpName = map['company_name'];
        industryName = map['industry_type'];
      });
      print(response.statusCode);
    } else
      print("WRONG");
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
