import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/solana.dart';
import 'package:solana/solana.dart';
import 'package:collection/collection.dart';

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

  Widget makeBackground(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Colors.green,
            Colors.greenAccent,
          ],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(top: 48, left: 24.0),
        child: Text(
          'Browse',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  Widget makeUserCard(BuildContext context, Ed25519HDPublicKey e) {
    //return Text(e.toBase58());
    return Container(
      width: double.infinity,
      height: 400,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          color: Colors.white,
          shadows: [
            BoxShadow(
                blurRadius: 8,
                color: Colors.black12,
                offset: Offset.fromDirection(pi / 2, 6),
                spreadRadius: -2)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: CircleAvatar(
              child: Image.asset('images/profile.png', scale: 6),
              radius: 70,
            ),
          ),
          Text(
            e.toBase58(),
            style: TextStyle(
              fontFamily: 'Nunito',
              //fontWeight: FontWeight.w800,
              color: Colors.black,
              //fontSize: 36,
            ),
          )
        ]),
      ),
    );
  }

  Widget makeUsers(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
      child: _recent_users.isEmpty
          ? Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreen,
                color: Colors.green,
                strokeWidth: 5,
              ))
          : Stack(
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              //padding: EdgeInsets.all(20),
              children: _recent_users.mapIndexed((index, keypair) {
                return makeUserCard(context, keypair);
              }).toList(),
              //children: _recent_users.mapIndexed((index, keypair) {
              //  return Positioned(
              //      top: index * 20, child: makeUserCard(context, keypair));
              //}).toList(),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      makeBackground(context),
      makeUsers(context),
    ]);
  }
}
