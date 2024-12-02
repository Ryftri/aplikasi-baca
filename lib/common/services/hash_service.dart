import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'package:crypto/crypto.dart';

class HashService {
  static String generateSalt([int length = 16]) {
    final random = Random.secure();
    final List<int> saltBytes = List.generate(length, (i) => random.nextInt(256));
    return base64.encode(saltBytes);
  }

  static String hashPassword(String password, String salt, {int iterations = 10000}) {
    if (salt.isEmpty || (salt.length % 4) != 0) {
      throw FormatException("Invalid salt length", salt);
    }

    final key = utf8.encode(password);
    final saltBytes = base64.decode(salt);

    var hmac = Hmac(sha256, key);
    List<int> derivedKey = Uint8List.fromList(saltBytes);

    for (var i = 0; i < iterations; i++) {
      derivedKey = hmac.convert(derivedKey).bytes.toList();
    }

    return base64.encode(Uint8List.fromList(derivedKey));
  }

  static bool verifyPassword(String inputPassword, String storedHash, String salt, {int iterations = 10000}) {
    if (salt.isEmpty || (salt.length % 4) != 0) {
      throw FormatException("Invalid salt length", salt);
    }

    final inputHash = hashPassword(inputPassword, salt, iterations: iterations);
    return inputHash == storedHash;
  }
}
