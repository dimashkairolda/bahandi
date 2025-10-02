// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:web_socket_channel/web_socket_channel.dart'; // Правильный импорт
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'dart:convert';

// Инициализация уведомлений
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(
          'app_icon'); // Убедитесь, что у вас есть файл иконки в проекте

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<bool> showNotificationSnackbar(
    BuildContext context, String userToken) async {
  final completer = Completer<bool>();

  try {
    // Инициализация WebSocket соединения
    final channel = WebSocketChannel.connect(
      Uri.parse('https://magnum.etry.kz/ws/notification/?token=$userToken'),
    );

    // Прослушивание входящих сообщений
    channel.stream.listen(
      (message) {
        // Декодирование и обработка сообщения
        final decodedMessage = jsonDecode(message);

        // Извлечение title и description из сообщения
        final title = decodedMessage['message']['title'] ?? 'Новое уведомление';
        final description =
            decodedMessage['message']['description'] ?? 'Нет описания';

        // Показ уведомления
        _showNotification(title, description);

        // Отображение Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Новое уведомление: $title \n $description'),
            duration: const Duration(seconds: 3),
          ),
        );

        // Успешная обработка
        completer.complete(true);
      },
      onError: (error) {
        // Обработка ошибок
        print('Ошибка WebSocket: $error');
        completer.complete(false);
      },
      cancelOnError: true,
    );
  } catch (error) {
    print('Ошибка подключения к WebSocket: $error');
    completer.complete(false);
  }

  // Ожидание завершения обработки
  return completer.future;
}

Future<void> _showNotification(String title, String description) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    description,
    platformChannelSpecifics,
  );
}
