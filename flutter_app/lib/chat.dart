import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:expandable/expandable.dart';
import 'package:solana/solana.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  String _name = "Chad2";
  int _age = 18;
  String _gender = "M";
  String _introduction = "Lorem ipsum dolor sit";
  List<String> _potential_interests = [
    "math",
    "cats",
    "food",
  ];

  final Future<Ed25519HDKeyPair> _wallet_address = Solana.loadKeyPair();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Ed25519HDKeyPair>(
        future: _wallet_address,
        builder:
            (BuildContext context, AsyncSnapshot<Ed25519HDKeyPair> snapshot) {
          String addr = "initializing...";
          if (snapshot.hasData) {
            addr = snapshot.data?.address ?? "null";
          } else if (snapshot.hasError) {
            addr = "failed to get addr";
          }

          return SingleChildScrollView(
              child: Center(
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
                  child:
                      Text(_name, style: Theme.of(context).textTheme.headline4),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Text('$_age',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(2, 10, 20, 10),
                      child: Icon(Icons.male_rounded)),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Text('Address: $addr',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ExpansionTile(
                        title: Text(
                          "Interests",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text('Brew'),
                          ),
                          ListTile(
                            title: Text('Is'),
                          ),
                          ListTile(
                            title: Text('Finally'),
                          ),
                          ListTile(
                            title: Text('Working'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
