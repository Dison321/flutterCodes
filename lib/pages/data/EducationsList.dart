import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/editEducation.dart';
import 'package:freelancer/pages/sellerAcc/education.dart';
import 'package:http/http.dart' as http;

class EducationsListPage extends StatefulWidget {
  final int id;
  // const EducationsListPage({super.key});
  EducationsListPage({required this.id});

  @override
  State<EducationsListPage> createState() => _EducationsListPageState();
}

class _EducationsListPageState extends State<EducationsListPage> {
  List listOfEdu = [];

  @override
  void initState() {
    super.initState();

    getEducations(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listOfEdu.length == 0 ? 1 : listOfEdu.length,
        itemBuilder: (context, index) {
          if (listOfEdu.length == 0) {
            return ListTile(
              tileColor: Colors.grey[200],
              title: Text(
                "< Not Entered Educations Yet >",
                textAlign: TextAlign.center,
              ),
            );
          }
          return Container(
            height: 300,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //University
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfEdu[index]['university'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ), //field of study
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfEdu[index]['field_of_study'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
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
                                  listOfEdu[index]['qualification_type'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfEdu[index]['graduation_date'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfEdu[index]['cgpa'].toString(),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editEducationPage(
                                id: listOfEdu[index]['education_id'],
                              ),
                            ));
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                    child: InkWell(
                      onTap: () {
                        // handle delete button press
                        // print(listOfLanguage[index]['language_id']);
                        deleteEducation(listOfEdu[index]['education_id']);
                      },
                      child: Icon(Icons.delete),
                    ),
                  )
                ],
              ),
            ),
          );
        });
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

  Future<void> deleteEducation(educationID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/deleteEducation"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'education_id': educationID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => educationPage(
              id: widget.id,
            ),
          ));
    } else
      print("failed");

    print("done response body");
  }
}
