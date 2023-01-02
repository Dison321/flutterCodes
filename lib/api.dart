// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class apiPage extends StatefulWidget {
//   const apiPage({key});

//   @override
//   State<apiPage> createState() => _apiPageState();
// }

// class _apiPageState extends State<apiPage> {
//   String stringResponse = 'not changed';
//   Map mapResponse = Map();
//   List listOfFact = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future fetchData() async {
//     var url = Uri.parse('https://www.thegrowingdeveloper.org/apiview?id=2');
//     http.Response response = await http.get(url);
//     if (response.statusCode == 200) {
//       setState(() {
//         mapResponse = json.decode(response.body);
//         listOfFact = mapResponse['facts'];
//       });
//     } else
//       print('Not Receiving');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fetch data from internet'),
//         backgroundColor: Colors.blue,
//       ),
//       body: mapResponse == null
//           ? Container()
//           : Column(
//               children: <Widget>[
//                 Text(
//                   mapResponse['category'].toString(),
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Container(
//                         child: Column(
//                       children: <Widget>[
//                         Image.network(listOfFact[index]['image_url'])
//                       ],
//                     ));
//                   },
//                   itemCount: listOfFact == null ? 0 : listOfFact.length,
//                 )
//               ],
//             ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class apiPage extends StatefulWidget {
  const apiPage({key});

  @override
  State<apiPage> createState() => _apiPageState();
}

class _apiPageState extends State<apiPage> {
  String stringResponse = 'not changed';
  Map mapResponse = Map();
  List listOfFact = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    print('first');
    try {
      var url = Uri.parse("http://10.0.2.2:8080/Users/1");

      http.Response response = await http.get(url);
      print('hi');

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          mapResponse = json.decode(response.body);
          listOfFact = mapResponse['fname'];
        });
      } else
        print('Not Receiving');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch data from internet'),
        backgroundColor: Colors.blue,
      ),
      body: mapResponse == null
          ? Container()
          : Column(
              children: <Widget>[
                Text(
                  mapResponse['fname'].toString(),
                  style: TextStyle(fontSize: 30),
                ),
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
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    print('clicked');
                    print(mapResponse.toString());
                    print(mapResponse['fname'].toString());
                  },
                ),
              ],
            ),
    );
  }

  //String API

  // var stringResponse;
  // int counter = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  //   print('ini state');
  // }

  // Future fetchData() async {
  //   // http.Response response;
  //   // response = await http
  //   //     .get(Uri.parse('https://www.thegrowingdeveloper.org/apiview?id=1'));
  //   // var url = Uri.parse('https://www.thegrowingdeveloper.org/apiview?id=1');
  //   http.Response response = await http
  //       .get(Uri.parse('https://www.thegrowingdeveloper.org/apiview?id=1'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       stringResponse = response.body;
  //     });
  //     counter++;
  //   } else
  //     print('Not Receiving');
  // }

  // @override
  // Widget build(BuildContext context) {
  //   print(stringResponse.toString());
  //   print(counter);
  //   return Container();
  // }
}
