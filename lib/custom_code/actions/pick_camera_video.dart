// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_compress/video_compress.dart';

/// Съёмка видео с камеры → сжатие [VideoCompress] (MediumQuality) → [FFUploadedFile].
/// Состояние [FFAppState.videoAttachmentUploadBusy] / фаза / прогресс — для оверлея на экране заявки.
Future<FFUploadedFile?> pickCameraVideo() async {
  final app = FFAppState();

  void resetBusy() {
    app.update(() {
      app.videoAttachmentUploadBusy = false;
      app.videoAttachmentUploadPhase = '';
      app.videoAttachmentCompressProgress = 0.0;
    });
  }

  try {
    try {
      await VideoCompress.cancelCompression();
    } catch (_) {}

    resetBusy();

    final camera = await Permission.camera.request();
    final microphone = await Permission.microphone.request();
    if (!camera.isGranted || !microphone.isGranted) {
      resetBusy();
      return null;
    }

    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.camera,
    );

    if (video == null) {
      return null;
    }

    app.update(() {
      app.videoAttachmentUploadBusy = true;
      app.videoAttachmentUploadPhase = 'compress';
      app.videoAttachmentCompressProgress = 0.0;
    });

    dynamic progressSub;
    try {
      progressSub = VideoCompress.compressProgress$.subscribe((double p) {
        app.update(() {
          app.videoAttachmentCompressProgress =
              (p / 100.0).clamp(0.0, 1.0);
        });
      });

      final mediaInfo = await VideoCompress.compressVideo(
        video.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
      );

      if (mediaInfo == null || mediaInfo.file == null) {
        resetBusy();
        return null;
      }

      final compressedFile = mediaInfo.file!;
      if (!await compressedFile.exists()) {
        resetBusy();
        return null;
      }

      final fileBytes = await compressedFile.readAsBytes();

      try {
        await VideoCompress.deleteAllCache();
      } catch (_) {}

      app.update(() {
        app.videoAttachmentCompressProgress = 1.0;
        app.videoAttachmentUploadPhase = 'upload';
      });

      return FFUploadedFile(
        name: 'compressed_${video.name}',
        bytes: fileBytes,
      );
    } finally {
      try {
        progressSub?.unsubscribe();
      } catch (_) {}
    }
  } catch (_) {
    resetBusy();
    return null;
  }
}
