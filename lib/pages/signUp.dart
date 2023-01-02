import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  var isObscured;
  late FocusNode myFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map mapResponse = Map();
  List listOfUser = [];
  var duplicated;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    isObscured = true;
    myFocusNode = FocusNode();
    duplicated = false;
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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AppBar(
                    title: Text('Join Us'),
                    centerTitle: true,
                    backgroundColor: Colors.grey[700],
                    elevation: 0,
                  ),
                ),

                // Username
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                        hintText: 'Your Username, e.g: John Doe',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Username";
                        } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value))
                          return "Ensure username only consist of alphabet";
                        else if (value.length < 4 || value.length > 20)
                          return "Ensure username in between 6-20 characters";
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Email
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Your email,e.g: johndoe@gmail.com',
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Phone Number
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      controller: phoneNo,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Your phone number, e.g: 012 123XXXX',
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp('[0-9.,]+').hasMatch(value) ||
                            value.length != 10) {
                          return "Invalid Phone Number";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Password
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      obscureText: isObscured,
                      controller: _password,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            color: Colors.grey[800],
                            padding: EdgeInsets.only(right: 12),
                            icon: isObscured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        } else if (value.length < 8)
                          return "Ensure Password length is atleast 8";
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //Confirm Password
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      obscureText: isObscured,
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Re-type your password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm your password";
                        } else if (_password.text != _confirmPassword.text)
                          return "Password does not match";
                        else if (value.length < 8)
                          return "Ensure Password length is atleast 8";
                        return null;
                      },
                    ),
                  ),
                ),
                TextButton(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                ),

                //Terms & Condition
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'By joining, you agree to Freelance\'s ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //back to sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Have an acount ? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/logIn');
                        },
                        child: Text(
                          'Sign In now',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Padding(
                //     padding: EdgeInsets.only(
                //         bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  //signUp function
  Future<void> signUp() async {
    if (_password.text.isNotEmpty && email.text.isNotEmpty) {
      var response = await http.post(Uri.parse("http://10.0.2.2:8080/SignUp"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode({
            'username': username.text,
            'email': email.text,
            'password': _password.text,
            'phoneNo': phoneNo.text
          }));

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/resetPass');
      } else
        popUp();
    } else {
      print("Invalid controller");
    }
  }

  void popUp() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Sign Up Failed"),
              content: Text("Email Already Existed"),
              actions: [
                TextButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                      username.clear();
                      email.clear();
                      phoneNo.clear();
                      _password.clear();
                      _confirmPassword.clear();
                    })
              ],
            ));
  }
}
