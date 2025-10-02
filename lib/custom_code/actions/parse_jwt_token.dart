// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:jwt_decode/jwt_decode.dart';

Future<DateTime?> parseJwtToken(String jwtToken) async {
  try {
    Map<String, dynamic> payload = Jwt.parseJwt(jwtToken);
    int? expiration = payload['exp'];

    if (expiration != null) {
      return DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
    } else {
      print('Срок действия токена не найден.');
      return null;
    }
  } catch (e) {
    print('Ошибка при расшифровке токена: $e');
    return null;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
