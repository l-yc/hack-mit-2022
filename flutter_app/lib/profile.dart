import 'dart:convert';
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
  String _name = "Michael Tan";
  int _age = 28;
  String _gender = "M";
  String _sexual_orientation = "Pansexual Demiromantic";
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
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.green,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight)),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 75,
                      child: CircleAvatar(
                        child: Image.asset('images/profile.png', scale: 10),
                        radius: 70,
                      ),
                    )),
              ),
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
                        padding: EdgeInsets.fromLTRB(15, 20, 20, 10),
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
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Icon(Icons.male_rounded,
                                  color: Colors.black38, size: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Text('$_sexual_orientation',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 18,
                                  )),
                            ),
                          ]),
                      ElevatedButton(
                        onPressed: () async {
                          final keyPair = await _wallet_address;
                          try {
                            final txId = await Solana.sendHeartbeat(keyPair);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Heartbeat sent! (debug=$txId)")));
                          } catch (e) {
                            final err = e as JsonRpcException;
                            final jsonErr = err.data["err"];
                            switch (jsonErr) {
                              case "AccountNotFound":
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "You need SOL to make this transaction!")));
                                break;
                              default:
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Unknown error: $jsonErr")));
                            }
                          }
                        },
                        child: Text("Broadcast availability"),
                      ),
                      ExpansionTile(
                          title: Text(
                            "ID",
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
                            title: Text('Rock Music'),
                          ),
                          ListTile(
                            title: Text('Thriller Movies'),
                          ),
                          ListTile(
                            title: Text('Web3 development'),
                          ),
                          ListTile(
                            title: Text('Hiking'),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final keyPair = await _wallet_address;
                          final txId = await Solana.initDebugWallet(keyPair);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("tx=$txId")));
                        },
                        child: Text("DEBUG"),
                      ),
                    ]))),
              ),
            ],
          );
        });
  }
}
