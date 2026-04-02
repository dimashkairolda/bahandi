// Automatic FlutterFlow imports
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> downloadVideoToGallery(String videoUrl) async {
  if (videoUrl.isEmpty) return false;

  try {
    // 1. Показываем уведомление о начале
    Fluttertoast.showToast(
      msg: "Начинаю загрузку...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
    );

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/video_temp.mp4';

    // 2. Скачиваем с отслеживанием прогресса
    await Dio().download(
      videoUrl, 
      path,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          // Вычисляем процент
          String progress = (received / total * 100).toStringAsFixed(0);
          
          // ВНИМАНИЕ: Не стоит показывать Toast на каждый процент (будет лагать),
          // но можно выводить в консоль для проверки:
          print("Загрузка: $progress%");
          
          // Если очень хочется обновлять UI, здесь нужна сложная логика со стримами,
          // для простого экшена достаточно консоли.
        }
      },
    );

    // 3. Сохраняем в галерею
    Fluttertoast.showToast(msg: "Сохранение в галерею...");
    await Gal.putVideo(path);

    // 4. Удаляем временный файл
    File(path).delete();
    
    // Успешный финал
    Fluttertoast.showToast(
      msg: "Видео успешно сохранено! ✅",
      backgroundColor: Colors.green,
    );

    return true; 
  } catch (e) {
    print('Error downloading video: $e');
    
    Fluttertoast.showToast(
      msg: "Ошибка загрузки ❌",
      backgroundColor: Colors.red,
    );
    
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!