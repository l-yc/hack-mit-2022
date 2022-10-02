import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/browse.dart';
import 'package:flutter_app/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D(E)ATE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'D(E)ATE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _nav_index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_nav_index) {
      case 0:
        child = BrowseWidget();
        break;
      case 1:
        break;
      case 2:
        //child = profileWidget(context);
        child = ProfileWidget();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _nav_index,
        onTap: (int index) => setState(() => _nav_index = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Browse",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Chat",
            icon: Icon(Icons.chat_bubble_rounded),
          ),
          BottomNavigationBarItem(
            label: "My Account",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
