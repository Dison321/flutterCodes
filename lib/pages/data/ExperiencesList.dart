import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/editExperience.dart';
import 'package:freelancer/pages/sellerAcc/experience.dart';
import 'package:http/http.dart' as http;

class ExperiencesListPage extends StatefulWidget {
  final int id;
  ExperiencesListPage({required this.id});

  @override
  State<ExperiencesListPage> createState() => _ExperiencesListPageState();
}

class _ExperiencesListPageState extends State<ExperiencesListPage> {
  List listOfExp = [];

  @override
  void initState() {
    super.initState();

    getExperience(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listOfExp.length == 0 ? 1 : listOfExp.length,
        itemBuilder: (context, index) {
          if (listOfExp.length == 0) {
            return ListTile(
              tileColor: Colors.grey[200],
              title: Text(
                "< Not Entered Experiences Yet >",
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
                          //Company Name
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfExp[index]['company_name'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfExp[index]['job'],
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
                                  "Date Started : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600]),
                                ),
                                Text(
                                  listOfExp[index]['joined_start'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfExp[index]['joined_end'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
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
                                  listOfExp[index]['industry_type'],
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
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
                                  listOfExp[index]['description'],
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
                              builder: (context) => editExperiencePage(
                                id: listOfExp[index]['experience_id'],
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
                        deleteExperience(listOfExp[index]['experience_id']);
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
  }

  Future<void> deleteExperience(expID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/deleteExperience"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'experience_id': expID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => experiencePage(
              id: widget.id,
            ),
          ));
    } else
      print("failed");

    print("done response body");
  }
}
