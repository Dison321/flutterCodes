import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final List<String> items = [
  "Accounting and finance",
  "Administration and office support",
  "Advertising, marketing, and PR",
  "Agriculture, forestry, and fishing",
  "Architecture and interior design",
  "Art, entertainment, and media",
  "Banking and financial services",
  "Construction and property",
  "Consulting and strategy",
  "Customer service and call center",
  "Education and training",
  "Engineering",
  "Environmental and sustainability",
  "Healthcare and medical",
  "Hospitality and tourism",
  "Human resources and recruitment",
  "Information technology",
  "Insurance",
  "Legal",
  "Logistics and supply chain",
  "Manufacturing and production",
  "Mining, resources, and energy",
  "Real estate",
  "Retail and consumer products",
  "Sales and business development",
  "Science and technology",
  "Social and community services",
  "Trades and services",
  "Transport and logistics",
  "Veterinary and animal care"
];

String? selectedValue = items.first;

class experiencePage extends StatefulWidget {
  const experiencePage({super.key});

  @override
  State<experiencePage> createState() => _experiencePageState();
}

class _experiencePageState extends State<experiencePage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map mapResponse = Map();
  List listOfUser = [];
  var duplicated, dateTime, dateTime2;

  TextEditingController jobName = TextEditingController();
  TextEditingController cmpName = TextEditingController();
  TextEditingController joinStartv = TextEditingController();
  TextEditingController joinEndv = TextEditingController();
  TextEditingController joinStart = TextEditingController();
  TextEditingController joinEnd = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController industry = TextEditingController();

  @override
  void initState() {
    super.initState();
    isObscured = true;
    myFocusNode = FocusNode();
    duplicated = false;
    dateTime = 'Date Started';
    dateTime2 = 'Date Ended';
    industry.text = items.first;
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
            DateTime? date8 = value;
            String date = "${value.day}/${value.month}/${value.year}";
            joinStartv.text = date8.toString();
            joinStart.text = date;
            dateTime = date;
          });
        }
      });
    }

    Future<void> calendar2() async {
      await showDatePicker(
        context: context,
        initialDate: DateTime(2030),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
      ).then((value) {
        if (value == null) {
        } else {
          setState(() {
            DateTime? date9 = value;
            String date = "${value.day}/${value.month}/${value.year}";
            joinEndv.text = date9.toString();
            joinEnd.text = date;
            dateTime2 = date;
          });
          checkDuration();
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: AppBar(
                      title: Text('experience'),
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
                        'Experience',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // University Name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'Job',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 6, 16, 5),
                    child: TextFormField(
                      controller: jobName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Job\'s Title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Job\'s Title";
                        }
                        return null;
                      },
                    ),
                  ),
                  //Company Name
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'Company Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 6, 16, 5),
                    child: TextFormField(
                      controller: cmpName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Company Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Company Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  //Joined Duration
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'Joined Duration',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                dateTime.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          calendar();
                        },
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                dateTime2.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (dateTime == 'Date Started') {
                            popup();
                            setState(() {
                              dateTime2 = 'Date Ended';
                            });
                          } else {
                            calendar2();
                          }
                        },
                      ),
                    ],
                  ),
                  //Industry
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Industry',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: SizedBox(
                      child: DropdownButton<String>(
                        hint: Text("Select Your Industry"),
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
                            industry.text = selectedValue.toString();
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
                  //Desc
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      child: Text(
                        'Experience Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: TextField(
                      maxLength: 150,
                      controller: desc,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
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
                      if (dateTime == 'Date Joined' ||
                          dateTime2 == 'Date Ended') {
                        popup2();
                      } else {
                        if (_formKey.currentState!.validate()) {
                          print(jobName.text);
                          print(cmpName.text);
                          print(joinStart.text);
                          print(joinEnd.text);
                          print(desc.text);
                          print(industry.text);

                          print("done");
                        }
                      }
                    },
                  ),
                  //back to sign in
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  //experience function
  checkDuration() {
    final date1 = DateTime.parse(joinStartv.text);
    final date2 = DateTime.parse(joinEndv.text);
    final validate = date1.compareTo(date2);

    if (validate < 0) {
      print('join Date is before Date 2');
    } else if (validate == 0) {
      print('join Date is the same as Date 2');
      popup2();
    } else {
      print('join Date is after Date 2');
      popup2();
    }
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Invalid Joined Duration"),
              content: Row(
                children: [
                  Text("Please Enter Start Duration first !"),
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

  void popup2() {
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
                        dateTime = 'Date Started';
                        dateTime2 = 'Date Ended';
                      });

                      Navigator.pop(context);
                    })
              ],
            ));
  }
}
