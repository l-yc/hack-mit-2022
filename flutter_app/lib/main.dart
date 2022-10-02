import 'package:flutter/material.dart';

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

  String _name = "Chad Chaddest";
  int _age = 18;
  String _gender = "M";
  String _introduction = "Lorem ipsum dolor sit";
  List<String> _potential_interests = [
    "math",
    "cats",
    "food",
  ];

  String _wallet_address = "abcdef";

  Widget profileWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 75,
                child: CircleAvatar(
                  child: Image.asset('images/profile.png', scale: 6),
                  radius: 70,
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
            child: Text(_name, style: Theme.of(context).textTheme.headline4),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
              child:
                  Text('$_age', style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(2, 10, 20, 10),
                child: Icon(Icons.male_rounded)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
              child: Text('Address: $_wallet_address',
                  style: Theme.of(context).textTheme.headline5),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_nav_index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        child = profileWidget(context);
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
