import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KiranApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Welcome'),
    );
  }
}

Future fetchPoem() async {
  final response =
      await http.get('https://andruxnet-random-famous-quotes.p.mashape.com/?cat=famous&count=1',
       headers: { "X-Mashape-Key": "LIuRAtNbnrmshOkKroI7anyJl04hp1bVynkjsnHL0Lx22EOWnS", HttpHeaders.acceptHeader: "application/json"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  static getPoem(){
    fetchPoem();
    return     
    '''
      From off a hill whose concave womb reworded
      A plaintful story from a sistering vale,
      My spirits to attend this double voice accorded,
      And down I laid to list the sad-tuned tale;
      Ere long espied a fickle maid full pale,
      Tearing of papers, breaking rings a-twain,
      Storming her world with sorrow's wind and rain.
      ''';
  }
  Widget textSection = Container(
    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
    child: Text(
      '''
Hi! My name is Kiran Gautam. Here is a short poem, only for you:
        ''',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  Widget poemSection = Container(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      getPoem(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          Image.asset('images/kiran.jpg', fit: BoxFit.cover),
          textSection,
          poemSection
        ],
      ),
    );
  }
}
