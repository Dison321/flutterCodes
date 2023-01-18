import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/editLanguage.dart';
import 'package:freelancer/pages/sellerAcc/language.dart';
import 'package:http/http.dart' as http;

class LanguageListPage extends StatefulWidget {
  final int id;
  // const LanguageListPage({super.key});
  LanguageListPage({required this.id});

  @override
  State<LanguageListPage> createState() => _LanguageListPageState();
}

class _LanguageListPageState extends State<LanguageListPage> {
  List listOfLanguage = [];

  @override
  void initState() {
    super.initState();

    getLanguages(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listOfLanguage.length == 0 ? 1 : listOfLanguage.length,
              itemBuilder: (BuildContext context, int index) {
                if (listOfLanguage.length == 0) {
                  return ListTile(
                    title: Text(
                      "< Not Entered Languages Yet >",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(listOfLanguage[index]['language_name']),
                        subtitle: Text(
                            listOfLanguage[index]['language_proficient_level']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => editLanguagePage(
                                  id: listOfLanguage[index]['language_id'],
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
                          print(listOfLanguage[index]['language_id']);
                          deleteLanguage(listOfLanguage[index]['language_id']);
                        },
                        child: Icon(Icons.delete),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

//FUNCTIONS
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

  Future<void> deleteLanguage(languageID) async {
    var response = await http.post(Uri.parse("http://10.0.2.2:8080/deleteLang"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({'language_id': languageID}));
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => languagePage(
              id: widget.id,
            ),
          ));
    } else
      print("failed");

    print("done response body");
  }
}
