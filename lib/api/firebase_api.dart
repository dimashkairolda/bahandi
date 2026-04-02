import 'package:Etry/api/deviceId.dart';
import 'package:Etry/app_state.dart';
import 'package:Etry/auth/custom_auth/auth_util.dart';
import 'package:Etry/backend/api_requests/api_calls.dart';
import 'package:Etry/defects/defects/defects_widget.dart';
import 'package:Etry/defects/detailed_defects_offline/detailed_defects_offline_widget.dart';
import 'package:Etry/flutter_flow/flutter_flow_util.dart';
import 'package:app_badger/app_badger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initializes notifications and ensures the token is sent to the server.
  Future<void> initNotifications(BuildContext context) async {
    // 1. Request user permission for notifications.
    await _firebaseMessaging.requestPermission(alert: true,
  badge: true,
  sound: true);

    // 2. Get the initial FCM token.
    // This might be null on the very first run, so we handle that.
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null && fcmToken.isNotEmpty) {
      await _updateTokenOnServer(fcmToken, context);
      FFAppState().fcmtoken = fcmToken;
      print("✅ Initial FCM Token sent: $fcmToken");
    } else {
      print("⚠️ Initial FCM token not yet available. It will be sent on refresh.");
    }
 FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageClick);
 
    // 3. Set up a listener for any future token updates.
    // This handles cases where the token expires or the user reinstalls the app.
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      if (newToken.isNotEmpty) {
        await _updateTokenOnServer(newToken, context);
        FFAppState().fcmtoken = newToken;
        print("🔄 Token refreshed and sent to server: $newToken");
      }
    });
  }
void _handleMessageClick(RemoteMessage message) {
  final defectId = message.data['id'];
  print(message.data);

  final context = appNavigatorKey.currentContext!;

  if (defectId != null) {
    GoRouter.of(context).pushNamed(
      DetailedDefectsOfflineWidget.routeName,
      queryParameters: {
        'id': defectId,
         // строка 'null', если нужно именно так
      }.withoutNulls,
    );
  }  else {
    // Покажем диалог, если ни defectId, ни requestId не переданы
    GoRouter.of(context).goNamed(
      DefectsWidget.routeName,
    );
  }
  ViewedNotificationCall.call(
      access: currentAuthenticationToken,
    );
  AppBadger.removeBadge();
}
  /// Sends the FCM token to your backend server.
  Future<void> _updateTokenOnServer(String token, BuildContext context) async {
    // Ensure we have a valid token before proceeding.
    if (token.isEmpty) return;

    // Safely get user and device IDs.
    final userId = getJsonField(FFAppState().account, r'''$.id''');
    final deviceId = await getId();

    if (userId == null || deviceId == null) {
      print("⚠️ Skipped sending FCM token: Missing userId or deviceId.");
      return;
    }

    // Make the API call to update the token.
    try {
      if (currentAuthenticationToken != null) {
        await LogoutFCMCall.call(access: currentAuthenticationToken);
      }
    } catch (_) {}

    final response = await UpdateFCMTokenCall.call(
      access: currentAuthenticationToken,
      fcmtoken: token,
      deviceid: deviceId,
      userId: userId,
    );

    // CORRECTED LOGIC: Check if the response succeeded.
    if (response.succeeded) {
      print("✅ Token successfully updated on the server.");
    } else {
      print("❌ Error sending token to server: ${response.jsonBody}");
    }
  }

  Future<void> logoutNotifications() async {
    try {
      if (currentAuthenticationToken == null) {
        return;
      }
      await LogoutFCMCall.call(
        access: currentAuthenticationToken,
      );
    } catch (_) {}
  }
}