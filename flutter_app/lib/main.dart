import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/browse.dart';
import 'package:flutter_app/chat.dart';
import 'package:flutter_app/profile.dart';
import 'package:flutter_app/chatPage.dart';

void main() {
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const TITLE = "D(E)ATE";
  int _nav_index = 0;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    switch (_nav_index) {
      case 0:
        child = BrowseWidget();
        break;
      case 1:
        child = ChatPageWidget();
        break;
      case 2:
        //child = profileWidget(context);
        child = ProfileWidget();
        break;
    }

    return MaterialApp(
      title: 'D(E)ATE',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        //appBar: AppBar(
        //  title: Text(TITLE),
        //),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _nav_index,
          onTap: (int index) => setState(() => _nav_index = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green[700],
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
      ),
    );
  }
}
