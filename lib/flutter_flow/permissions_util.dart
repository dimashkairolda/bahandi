import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '/flutter_flow/flutter_flow_util.dart';

const kPermissionStateToBool = {
  PermissionStatus.granted: true,
  PermissionStatus.limited: true,
  PermissionStatus.denied: false,
  PermissionStatus.restricted: false,
  PermissionStatus.permanentlyDenied: false,
};

final cameraPermission = Permission.camera;
final microphonePermission = Permission.microphone;
final photoLibraryPermission = Permission.photos;

Future<bool> getPermissionStatus(Permission setting) async {
  final status = await setting.status;
  return kPermissionStateToBool[status]!;
}

Future<void> requestPermission(Permission setting) async {
  if (setting == Permission.photos && isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      await Permission.storage.request();
    } else {
      await Permission.photos.request();
    }
  }
  final status = await setting.request();
  // Если пользователь ранее выбрал "Don't ask again" / запреты политики,
  // системный диалог больше не появится — только настройки приложения.
  if (status == PermissionStatus.permanentlyDenied ||
      status == PermissionStatus.restricted) {
    await openAppSettings();
  }
}
