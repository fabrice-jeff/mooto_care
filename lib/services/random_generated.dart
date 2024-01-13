import 'dart:convert';
import 'dart:math';

class RandomGeneratedString {
  static String getRandString({int len = 12}) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
