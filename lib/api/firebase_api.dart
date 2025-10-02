import 'package:Bahandi/api/deviceId.dart';
import 'package:Bahandi/app_state.dart';
import 'package:Bahandi/auth/custom_auth/auth_util.dart';
import 'package:Bahandi/backend/api_requests/api_calls.dart';
import 'package:Bahandi/flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Инициализация уведомлений и токена
  Future<void> initNotifications(BuildContext context) async {
    // Запрашиваем разрешение на отправку уведомлений
    await _firebaseMessaging.requestPermission();
    

    // Получаем текущий FCM токен
    final fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);
    if (fcmToken != null) {
      await _updateTokenOnServer(fcmToken, context); // Отправляем токен на сервер
      FFAppState().fcmtoken = fcmToken;
      print("FCM Token: ${FFAppState().fcmtoken}");
    }

    // Слушаем обновления токена
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await _updateTokenOnServer(newToken, context); // Обновляем токен на сервере
      FFAppState().fcmtoken = newToken;
      print("Обновленный FCM Token: $newToken");
    });
  }

  // Метод для отправки токена на сервер
  Future<void> _updateTokenOnServer(String token, BuildContext context) async {
    await Future(() async {
      await UpdateFCMTokenCall.call(
        access: currentAuthenticationToken,
        fcmtoken: token,
        deviceid:await getId(),
        userId: getJsonField(
      FFAppState().account,
      r'''$.id''',
    ),
      );
    });
  }
}
