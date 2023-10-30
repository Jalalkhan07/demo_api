import 'dart:async';
import 'dart:convert';
import 'package:flutter_api_test_jalal/modal.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Person> person;

  @override
  void initState() {
    super.initState();
    print('+++++++++++++++++initial state');
    person = fetchPerson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter REST API Example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter REST API Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: person,
            builder: (context, indexPerson) {
              if (indexPerson.hasData) {
                return Text(indexPerson.data!.userId.toString());
              } else if (indexPerson.hasError) {
                return Text('${indexPerson.error}');
              }
              // by default,it show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future<Person> fetchPerson() async {
    final _authority = "jsonplaceholder.typicode.com";
    final _path = "/albums/1";
    final _uri = Uri.https(_authority, _path);
    final response = await http.get(_uri);
    print("----HTPP URL -----${_uri.toString()}");

    if (response.statusCode == 200) {
      print('---RESPONSE BODY -----${response.body}');

      return Person.fromJson(jsonDecode(response.body));;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
