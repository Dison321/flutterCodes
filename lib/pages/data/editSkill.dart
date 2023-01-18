import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelancer/pages/data/SkillsList.dart';
import 'package:http/http.dart' as http;

final List<String> items = [
  'Beginner',
  'Advanced',
  'Intermediate',
];
String? selectedValue = items.first;

class editSkillPage extends StatefulWidget {
  // const editSkillPage({super.key});

  // const editSellerPage({super.key});
  final int id;
  editSkillPage({required this.id});

  @override
  State<editSkillPage> createState() => _editSkillPageState();
}

class _editSkillPageState extends State<editSkillPage> {
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List listOfSkills = [];
  TextEditingController skillName = TextEditingController();
  TextEditingController skillProfiency = TextEditingController();

  @override
  void initState() {
    super.initState();
    skillProfiency.text = items.first;
    myFocusNode = FocusNode();

    getSkills(widget.id);
    selectedValue = items.first;
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: AppBar(
                      title: Text('Skill'),
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
                        'Skills',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Skills
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      'Skills',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 6, 16, 5),
                    child: TextFormField(
                      controller: skillName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Skills',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Skills";
                        }
                        return null;
                      },
                    ),
                  ),
                  //Profiency
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Text(
                      'Profiency',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                            skillProfiency.text = selectedValue.toString();
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
                            'Edit',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print(skillName.text);
                        print(skillProfiency.text);
                        editSkill(widget.id);
                        print("done");
                        popup();
                      }
                    },
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

  //skill function
  Future<void> editSkill(var skillID) async {
    var getSkillProfID =
        await http.post(Uri.parse("http://10.0.2.2:8080/SkillProfID"),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
            },
            body: jsonEncode({'skill_proficient_type': skillProfiency.text}));

    if (getSkillProfID.statusCode == 200) {
      print("Success");
      print(getSkillProfID.body);
    } else
      print("WRONG");
    Map<String, dynamic> map2 = jsonDecode(getSkillProfID.body);
    print(map2['skill_proficient_id']);
    var skillProfID = map2['skill_proficient_id'];
    print("THIS IS SkillProfID");
    print(skillProfID);

    var response3 = await http.post(Uri.parse("http://10.0.2.2:8080/editSkill"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode({
          "skill_id": skillID,
          "skill_name": skillName.text,
          "skill_proficient_id": skillProfID
        }));

    if (response3.statusCode == 200) {
      print("nice");
    } else
      print("Invalid controller");
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Skills Edited !"),
              content: Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 8.0),
                  Text("Skill changed successfully"),
                ],
              ),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            ));
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
}
