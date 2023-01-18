import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/editLanguage.dart';
import 'package:freelancer/pages/data/editSkill.dart';
import 'package:freelancer/pages/sellerAcc/skill.dart';
import 'package:http/http.dart' as http;

class SkillsListPage extends StatefulWidget {
  final int id;
  // const SkillsListPage({super.key});
  SkillsListPage({required this.id});

  @override
  State<SkillsListPage> createState() => _SkillsListPageState();
}

class _SkillsListPageState extends State<SkillsListPage> {
  List listOfSkills = [];

  @override
  void initState() {
    super.initState();

    getSkills(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (listOfSkills.length == 0)
              ListTile(
                title: Text(
                  "< Not Entered Skills Yet >",
                  textAlign: TextAlign.center,
                ),
              )
            else
              for (var i = 0; i < listOfSkills.length; i++)
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(listOfSkills[i]['skill_name']),
                        subtitle:
                            Text(listOfSkills[i]['skill_proficient_type']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => editSkillPage(
                                  id: listOfSkills[i]['skill_id'],
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
                          deleteSkill(listOfSkills[i]['skill_id']);
                        },
                        child: Icon(Icons.delete),
                      ),
                    )
                  ],
                ),
          ],
        ),
      ),
    );
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
    print("sellerID equals to");
    print(sellerID);
  }

  Future<void> deleteSkill(skillID) async {
    var response =
        await http.post(Uri.parse("http://10.0.2.2:8080/deleteSkill"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'skill_id': skillID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => skillPage(
              id: widget.id,
            ),
          ));
    } else
      print("failed");

    print("done response body");
  }
}
