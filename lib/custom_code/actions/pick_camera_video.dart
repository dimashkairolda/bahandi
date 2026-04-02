// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart'; // Импорт компрессора

Future<FFUploadedFile?> pickCameraVideo() async {
  final ImagePicker picker = ImagePicker();

  // 1. Открываем камеру для съемки
  final XFile? video = await picker.pickVideo(
    source: ImageSource.camera,
  );

  if (video == null) {
    return null;
  }

  // 2. Сжимаем видео
  // Вы можете менять качество: DefaultQuality, LowQuality, MediumQuality, HighQuality
  MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    video.path,
    quality: VideoQuality.MediumQuality, 
    deleteOrigin: false, // Удалить ли оригинал (по желанию)
    includeAudio: true,
  );

  if (mediaInfo == null || mediaInfo.file == null) {
    return null;
  }

  // 3. Конвертируем СЖАТЫЙ файл (File) в FFUploadedFile
  final File compressedFile = mediaInfo.file!;
  final Uint8List fileBytes = await compressedFile.readAsBytes();
  
  // Создаем имя файла (можно добавить префикс compressed_)
  final String fileName = 'compressed_${video.name}';

  // Очищаем кэш компрессора, чтобы не забивать память телефона
  // (но файл, который мы считали в fileBytes, уже у нас в памяти)
  await VideoCompress.deleteAllCache();

  return FFUploadedFile(
    name: fileName,
    bytes: fileBytes,
  );
}