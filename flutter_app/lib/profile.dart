import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:expandable/expandable.dart';
import 'package:solana/solana.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String _name = "Chad Tan";
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

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 75,
                    child: CircleAvatar(
                      child: Image.asset('images/profile.png', scale: 6),
                      radius: 70,
                    ),
                  )),
              Expanded(
                child: Container(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        )),
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black12,
                              offset: Offset.fromDirection(pi / 2, -6),
                              spreadRadius: -2)
                        ]),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 20, 20, 10),
                        child: Text(_name,
                            style: Theme.of(context).textTheme.headline4),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('$_age',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 18,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                              child: Icon(Icons.male_rounded,
                                  color: Colors.black38, size: 18),
                            ),
                          ]),
                      ExpansionTile(
                          title: Text(
                            "Key",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          children: <Widget>[
                            ListTile(
                                title:
                                    Text('$addr', overflow: TextOverflow.clip)),
                          ]),
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
                    ]))),
              ),
            ],
          );
        });
  }
}
