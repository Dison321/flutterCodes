import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final List<String> items = [
  'Beginner',
  'Advanced',
  'Intermediate',
];

String? selectedValue = items.first;

final List<String> language = [
  'English',
  'Arabic',
  'Bahase Indonesia',
  'Bahase Malaysia',
  'Bengali',
  'Dutch',
  'Filipino',
  'French',
  'German',
  'Hebrew',
  'Hindi',
  'Italian',
  'Japanese',
  'Korean',
  'Mandarin',
  'Portuguese'
      'Russian',
  'Spanish',
  'Tamil',
  'Thai',
  'Vietnamese',
];

String? selectedLanguage = language.first;

class languagePage extends StatefulWidget {
  const languagePage({super.key});

  @override
  State<languagePage> createState() => _languagePageState();
}

class _languagePageState extends State<languagePage> {
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController languageName = TextEditingController();
  TextEditingController languageProfiency = TextEditingController();

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    languageName.text = language.first;
    languageProfiency.text = items.first;
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
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: AppBar(
                    title: Text('Language'),
                    centerTitle: true,
                    backgroundColor: Colors.grey[700],
                    elevation: 0,
                  ),
                ),
                //Title

                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.lightbulb),
                    title: Text(
                      'Languages',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //languages
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    'Languages',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      menuMaxHeight: 200.0,
                      value: selectedLanguage,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          selectedLanguage = value!;
                          languageName.text = selectedLanguage.toString();
                        });
                      },
                      items: language
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
//Profiency
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Text(
                    'Profiency',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                    child: DropdownButton<String>(
                      hint: Text("Profiency"),
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
                          languageProfiency.text = selectedValue.toString();
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
//BUTTON
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
                          'Add language',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(languageName.text);
                      print(languageProfiency.text);
                      print("done");
                      popup();
                    }
                  },
                ),
                //back to sign in
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  //language function
  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Languages Added !"),
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text("Language is added !"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Add More'),
                    onPressed: () async {
                      Navigator.pop(context);
                    }),
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.pop(context);
                    })
              ],
            ));
  }
}
