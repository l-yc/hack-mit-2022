import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:solana/solana.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
  List<Ed25519HDPublicKey> _recent_users = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    //callApi();
    timer = new Timer.periodic(Duration(seconds: 1), (Timer t) async {
      final keyPair = await _wallet_address;
      final latest = await Solana.getRecentHeartbeats(keyPair);
      setState(() {
        _recent_users = latest;
        _recent_users.add(Solana.HEARTBEAT_PROGRAM_ID);
      });
    });
  }

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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Text(_name,
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Image.asset('images/profile.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Text('$_age',
                        style: Theme.of(context).textTheme.headline4),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Text(_gender,
                        style: Theme.of(context).textTheme.headline4),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                  child: Text(
                    'Address: $addr',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  children:
                      _recent_users.map((e) => Text(e.toBase58())).toList(),
                ),
              ],
            ),
          );
        });
  }
}
