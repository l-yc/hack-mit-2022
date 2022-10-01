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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  String _name = "Chad";
  int _age = 18;
  String _gender = "M";
  String _introduction = "Lorem ipsum dolor sit";
  List<String> _potential_interests = [
    "math",
    "cats",
    "food",
  ];

  String _wallet_address = "abcdef";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget basicWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Widget profileWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: Text(_name, style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child:
                  Text('$_age', style: Theme.of(context).textTheme.headline4),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child:
                  Text(_gender, style: Theme.of(context).textTheme.headline4),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: Text('Address: $_wallet_address',
                  style: Theme.of(context).textTheme.headline4),
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
        child = basicWidget(context);
        break;
      case 3:
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
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: "My Account",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
