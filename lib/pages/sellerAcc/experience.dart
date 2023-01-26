import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/ExperiencesList.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// final List<String> items = [
//   "Accounting and finance",
//   "Administration and office support",
//   "Advertising, marketing, and PR",
//   "Agriculture, forestry, and fishing",
//   "Architecture and interior design",
//   "Art, entertainment, and media",
//   "Banking and financial services",
//   "Construction and property",
//   "Consulting and strategy",
//   "Customer service and call center",
//   "Education and training",
//   "Engineering",
//   "Environmental and sustainability",
//   "Healthcare and medical",
//   "Hospitality and tourism",
//   "Human resources and recruitment",
//   "Information technology",
//   "Insurance",
//   "Legal",
//   "Logistics and supply chain",
//   "Manufacturing and production",
//   "Mining, resources, and energy",
//   "Real estate",
//   "Retail and consumer products",
//   "Sales and business development",
//   "Science and technology",
//   "Social and community services",
//   "Trades and services",
//   "Transport and logistics",
//   "Veterinary and animal care"
// ];

String? selectedValue;
List<String> items = [];

class experiencePage extends StatefulWidget {
  // const experiencePage({super.key});
  final int id;
  experiencePage({required this.id});

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
    getIndustry();
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
            joinStartv.text = date8.toString();
            final dateFormat = DateFormat('yyyy-MM-dd');
            String formattedDate = dateFormat.format(value);
            joinStart.text = formattedDate;
            dateTime = formattedDate;
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
            joinEndv.text = date9.toString();
            final dateFormat = DateFormat('yyyy-MM-dd');
            String formattedDate = dateFormat.format(value);
            joinEnd.text = formattedDate;
            dateTime2 = formattedDate;
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
                          registerExp(widget.id);
                          print("done");
                        }
                      }
                    },
                  ),
                  ExperiencesListPage(
                    id: widget.id,
                  ),
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

  //functions to ensure that the joinedStart date will never same as joinedEnd date or joinedStart date is after joinedEnd date
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

// /getExpIndustryID is used to read the selected industry form dropdowns and get its id,
// after that in /createExp ,  Pass industry's data inserted by users to the API
  Future<void> registerExp(var sellerID) async {
    var getExpIndustryID =
        await http.post(Uri.parse("http://10.0.2.2:8080/ExpIndustryID"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'industry_type': industry.text}));

    if (getExpIndustryID.statusCode == 200) {
      print("Success");
      print(getExpIndustryID.body);
    } else
      print("WRONG");
    Map<String, dynamic> map2 = jsonDecode(getExpIndustryID.body);
    print(map2['industry_id']);
    var ExpIndustryID = map2['industry_id'];
    print("THIS IS ExpIndustryID");
    print(ExpIndustryID);

    var response3 = await http.post(Uri.parse("http://10.0.2.2:8080/createExp"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode({
          "job": jobName.text,
          "joined_start": joinStart.text,
          "joined_end": joinEnd.text,
          "description": desc.text,
          "company_name": cmpName.text,
          "seller_id": sellerID,
          "industry_id": ExpIndustryID,
        }));

    if (response3.statusCode == 200) {
      print("nice");
      popup3();
    } else
      print("Invalid controller");
  }

//popup indicates invalid joined durations when users didnt enter the date
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

//Functions to get all the industry from API and pass it into dropdowns.
  Future<void> getIndustry() async {
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/Industry"),
    );
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<String> temp = [];
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> map = list[i];
        print(map["industry_type"]);

        temp.add(map["industry_type"]);
      }
      setState(() {
        items.clear();
        items.addAll(temp);
        selectedValue = items.first;
        industry.text = items.first;
      });
    } else
      print("failed");

    print("done response body");
  }

//popup indicates invalid joined durations when the calender date is illogical
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

//popup indicates experiences is added successfully
  void popup3() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Experiences Added !"),
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text("Experiences is added !"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Add More'),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => experiencePage(
                              id: widget.id,
                            ),
                          ));
                    }),
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            ));
  }
}
