import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelancer/pages/adminAcc/editUser.dart';

import 'package:http/http.dart' as http;

import 'editSeller.dart';

class adminSellerPage extends StatefulWidget {
  const adminSellerPage({super.key});

  @override
  State<adminSellerPage> createState() => _adminSellerPageState();
}

class _adminSellerPageState extends State<adminSellerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map mapResponse = Map();
  List listOfseller = [];

  @override
  void initState() {
    super.initState();
    getSellers();
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
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: listOfseller.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print(listOfseller[index]['seller_id']);
                                final sellerID =
                                    listOfseller[index]['seller_id'];
                                print(sellerID);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editSellerPage(
                                        id: sellerID,
                                      ),
                                    ));
                              },
                              child: ListTile(
                                title: Text(listOfseller[index]['seller_name']),
                                subtitle:
                                    Text(listOfseller[index]['state_name']),
                              ),
                            );
                          },
                        ),
                      )
                    ]),
              ),
            )),
      ),
    );
  }

  //adminSeller functions

  Future<void> getSellers() async {
    var response = await http.get(
      Uri.parse("http://10.0.2.2:8080/sellerList"),
    );
    if (response.statusCode == 200) {
      print("Success");
      print(response.body);

      List list = jsonDecode(response.body);
      List<dynamic> temp = [];
      for (int i = 0; i < list.length; i++) {
        print(i);
        print(list[i]);
        temp.add(list[i]);

        // Map<String, dynamic> map = list[i];
        // print(map["user_id"]);
        // print(map["username"]);
        // print(map["email"]);
        // print(map["phoneNo"]);
        // print(map["password"]);
        // print(map["role"]);

        // temp.add(map["qualification_type"]);
      }
      setState(() {
        listOfseller.addAll(temp);
      });
      // setState(() {
      //   itemQ.clear();
      //   itemQ.addAll(temp);
      //   selectedValue = itemQ.first;
      //   qualification.text = itemQ.first;
      // });
    } else
      print("failed");

    print("done response body");
  }
}
