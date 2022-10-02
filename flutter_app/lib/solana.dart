import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/dto.dart' as dto;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'dart:convert';

class Solana {
  static final HEARTBEAT_PROGRAM_ID = Ed25519HDPublicKey.fromBase58(
      "69RDX41xVyXoqpjGigrF2FfkVmbfoFhcxQKkAwmGXjnh");

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

  static RpcClient getClient() {
    return new RpcClient("https://api.devnet.solana.com");
  }

  static Future<TransactionId> initDebugWallet(Ed25519HDKeyPair keyPair) async {
    return getClient().requestAirdrop(keyPair.publicKey.toBase58(), 1000000000);
  }

  static Future<TransactionId> sendHeartbeat(Ed25519HDKeyPair keyPair) async {
    final ix = new Instruction(
        programId: HEARTBEAT_PROGRAM_ID,
        accounts: [
          new AccountMeta(
              pubKey: keyPair.publicKey, isWriteable: true, isSigner: true)
        ],
        data: ByteArray.empty());

    final msg = new Message(instructions: [ix]);

    return getClient().signAndSendTransaction(msg, List.from([keyPair]));

    //final instruction = new TransactionInstruction({
    //  keys: [
    //    {pubkey: greetedPubkey, isSigner: false, isWritable: true}
    //  ],
    //  programId,
    //  data: Buffer.alloc(0), // All instructions are hellos
    //});
    //await sendAndConfirmTransaction(
    //  connection,
    //  new Transaction().add(instruction),
    //  [payer],
    //);
  }

  static Future<List<Ed25519HDPublicKey>> getRecentHeartbeats(
      Ed25519HDKeyPair keyPair) async {
    final client = getClient();
    final signatures = await client
        .getSignaturesForAddress(HEARTBEAT_PROGRAM_ID.toBase58(), limit: 10);

    List<Ed25519HDPublicKey> ret = List.empty(growable: true);

    for (int i = 0; i < signatures.length; ++i) {
      final s = signatures[i];
      final tx = await client.getTransaction(s.signature,
          encoding: dto.Encoding.jsonParsed);
      if (tx != null) {
        final acc =
            (tx.transaction as dto.ParsedTransaction).message.accountKeys[0];
        ret.add(Ed25519HDPublicKey.fromBase58(acc.pubkey));
      }
    }

    // deduplicate
    return ret.toSet().toList();
  }
}
