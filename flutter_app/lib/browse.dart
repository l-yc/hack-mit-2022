import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:solana/solana.dart';

class BrowseWidget extends StatefulWidget {
  const BrowseWidget({super.key});

  @override
  State<BrowseWidget> createState() => _BrowseWidgetState();
}

class _BrowseWidgetState extends State<BrowseWidget> {
  List<Ed25519HDPublicKey> _recent_users = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    //callApi();
    timer = new Timer.periodic(Duration(seconds: 1), (Timer t) async {
      final keyPair = await Solana.loadKeyPair();
      final latest = await Solana.getRecentHeartbeats(keyPair);
      if (t.isActive) {
        setState(() {
          _recent_users = latest;
          _recent_users.add(Solana.HEARTBEAT_PROGRAM_ID);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            children: _recent_users.map((e) => Text(e.toBase58())).toList(),
          ),
        ],
      ),
    );
  }
}
