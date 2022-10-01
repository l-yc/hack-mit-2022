import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';
import 'dart:convert';

class Solana {
  static Future<Ed25519HDKeyPair> generateKeyPair() async {
    return Ed25519HDKeyPair.random();
  }

  static Future<Ed25519HDKeyPair> loadKeyPair() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final KEY = "WALLET";

    final saved = prefs.getString(KEY);

    if (saved == null) {
      final keypair = await generateKeyPair();
      final data = await keypair.extract();
      final writeString = base64Encode(data.bytes);
      prefs.setString(KEY, writeString);
      return keypair;
    } else {
      final data = base64.decode(saved);
      return Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: data);
    }
  }
}
