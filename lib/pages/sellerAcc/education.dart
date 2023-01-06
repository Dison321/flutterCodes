import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final List<String> items = [
  'Primary/Secondary School/SPM/\'O\' Level',
  'Higher Secondary/STPM/\'A\' Level/Pre-U',
  'Diploma',
  'Advanced/Higher/Graduate Diploma',
  'Bachelor\'s Degree',
  'Post Graduate Diploma',
  'Professional Degree',
  'Master\'s Degree',
  'Doctorate (PHD)',
];

String? selectedValue = items.first;

class educationPage extends StatefulWidget {
  const educationPage({super.key});

  @override
  State<educationPage> createState() => _educationPageState();
}

class _educationPageState extends State<educationPage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map mapResponse = Map();
  List listOfUser = [];
  var duplicated, dateTime;

  TextEditingController uniName = TextEditingController();
  TextEditingController gradDate = TextEditingController();
  TextEditingController fieldOfStudy = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController cgpa = TextEditingController();

  @override
  void initState() {
    super.initState();
    isObscured = true;
    myFocusNode = FocusNode();
    duplicated = false;
    dateTime = 'Choose Date';
    qualification.text = items.first;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> calendar() async {
      await showDatePicker(
        context: context,
        initialDate: DateTime(2030),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
      ).then((value) {
        if (value == null) {
        } else {
          setState(() {
            String date = "${value.day}/${value.month}/${value.year}";
            gradDate.text = date;
            dateTime = date;
          });
        }
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: AppBar(
                    title: Text('Education'),
                    centerTitle: true,
                    backgroundColor: Colors.grey[700],
                    elevation: 0,
                  ),
                ),
                //Title

                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.school),
                    title: Text(
                      'Education',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // University Name
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    'University / College',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 6, 16, 5),
                  child: TextFormField(
                    controller: uniName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'University/College Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your University/College";
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                //Graduation date
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    'Graduation Date',
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
                //Field Of Study
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Field of Study',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: TextFormField(
                    controller: fieldOfStudy,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Field Of Study',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Field of Study";
                      }
                      return null;
                    },
                  ),
                ),
                //Qualification
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Qualification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: SizedBox(
                    child: DropdownButton<String>(
                      hint: Text("Select Your Qualification"),
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
                          qualification.text = selectedValue.toString();
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
//CGPA
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Text(
                    'CGPA Score',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 90, 10),
                  child: TextFormField(
                    controller: cgpa,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CGPA',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your CGPA score";
                      } else if (!RegExp('[0-9.,]+').hasMatch(value))
                        return "Invalid CGPA value";
                    },
                  ),
                ),
                TextButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: Container(
                      padding: EdgeInsets.all(10),
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
                    if (_formKey.currentState!.validate()) {
                      print(uniName.text);
                      print(gradDate.text);
                      print(fieldOfStudy.text);
                      print(qualification.text);
                      print(cgpa.text);

                      print("done");
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

  //education function

}
