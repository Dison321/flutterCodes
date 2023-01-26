import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  List listOfseller = [], filteredListOfseller = [];
  TextEditingController searchController = TextEditingController();
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkExp());
    getSellers();

    filteredListOfseller = listOfseller;
  }

//When the flutter runs this page, inistate will called first, this calls checkExp() first then getSellers(),
//filteredListOfseller variables is used in searching seller's name in admin page.
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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "List Of Sellers",
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredListOfseller = listOfseller
                            .where((item) => item['seller_name']
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredListOfseller.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          print(filteredListOfseller[index]['seller_id']);
                          final sellerID =
                              filteredListOfseller[index]['seller_id'];
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
                          title:
                              Text(filteredListOfseller[index]['seller_name']),
                          subtitle:
                              Text(filteredListOfseller[index]['state_name']),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/admin');
                      },
                      label: Text('Back'),
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //adminSeller functions

//Check expired time of login session
  Future<void> checkExp() async {
    var securedKey = (await storage.read(key: "token"));
    final String? jwtToken = securedKey;
    print("JWTTOKEN =");
    print(jwtToken);
    print("SECUREDKEY = ");
    print(securedKey);
    var response2 = await http.get(
      Uri.parse("http://10.0.2.2:8080/auth"),
      headers: {
        'Authorization': '$jwtToken',
      },
    );
    if (response2.statusCode == 200) {
      print("Success");
      print(response2.body);
      print("done response body");
    } else
      popup();

    print(response2.statusCode);
  }

//popup that indicates login session expired
  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Login Session Expired"),
              content: Text("Please Login Again"),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () async {
                      await storage.write(key: 'token', value: null);
                      Navigator.pushReplacementNamed(context, '/logIn');
                      // emailController.clear();
                      // passController.clear();
                    })
              ],
            ));
  }

//Get all seller's data and store them using for loop, after that pass it to listOfseller.
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
      }
      setState(() {
        listOfseller.addAll(temp);
      });
    } else
      print("failed");

    print("done response body");
  }
}
