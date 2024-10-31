import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class HashService {
  static String generateSalt([int length = 16]) {
    final rand = Random.secure();
    final saltBytes = List<int>.generate(length, (i) => rand.nextInt(256));
    return base64Url.encode(saltBytes);
  }

  static String hashPassword(String password, String salt, {int iterations = 100000, int keyLength = 32}) {
    final key = utf8.encode(password);
    final saltBytes = utf8.encode(salt);

    final pbkdf2Result = _pbkdf2(hmac: Hmac(sha256, key), salt: saltBytes, iterations: iterations, keyLength: keyLength);
    return base64Url.encode(pbkdf2Result);
  }

  static bool verifyPassword(String inputPassword, String storedHash, String salt, {int iterations = 100000}) {
    final inputHash = hashPassword(inputPassword, salt, iterations: iterations);
    return inputHash == storedHash;
  }

  static List<int> _pbkdf2({required Hmac hmac, required List<int> salt, required int iterations, required int keyLength}) {
    final hashLength = hmac.convert([]).bytes.length;
    final numBlocks = (keyLength / hashLength).ceil();

    final output = <int>[];

    for (int blockNum = 1; blockNum <= numBlocks; blockNum++) {
      var block = _F(hmac, salt, iterations, blockNum);
      output.addAll(block);
    }

    return output.sublist(0, keyLength);
  }

  static List<int> _F(Hmac hmac, List<int> salt, int iterations, int blockNum) {
    var block = List<int>.from(salt)
      ..addAll([
        (blockNum >> 24) & 0xff,
        (blockNum >> 16) & 0xff,
        (blockNum >> 8) & 0xff,
        blockNum & 0xff,
      ]);

    var u = hmac.convert(block).bytes;
    var output = List<int>.from(u);

    for (int i = 1; i < iterations; i++) {
      u = hmac.convert(u).bytes;
      for (int j = 0; j < output.length; j++) {
        output[j] ^= u[j];
      }
    }

    return output;
  }
}
