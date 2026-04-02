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

Future<void> showNotificationSnackbar(
  BuildContext context,
  String userToken,
  Future<dynamic> Function() onMessageReceived, // <--- Новый параметр (Action)
) async {
  try {
    // 1. Создаем соединение
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://app.etry.kz/ws/notification/?token=$userToken'),
    );

    // 2. Слушаем поток вечно (пока экран жив)
    channel.stream.listen(
      (message) async {
        // --- Обработка сообщения ---
        final decodedMessage = jsonDecode(message);
        final title = decodedMessage['message']['title'] ?? 'Новое уведомление';
        final description =
            decodedMessage['message']['description'] ?? 'Нет описания';

        // Показываем UI
        _showNotification(title, description);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Новое уведомление: $title \n $description'),
            duration: const Duration(seconds: 3),
          ),
        );

        // --- ГЛАВНОЕ: Вызываем обновление API ---
        // Это запустит цепочку действий, которую вы настроите в FlutterFlow
        await onMessageReceived(); 
      },
      onError: (error) {
        print('Ошибка WebSocket: $error');
      },
      cancelOnError: true,
    );
  } catch (error) {
    print('Ошибка подключения к WebSocket: $error');
  }
  
  // Мы ничего не возвращаем и не ждем completer, соединение работает в фоне
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
