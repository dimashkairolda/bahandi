// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

String convertToBase64(FFUploadedFile uploadedFile) {
  Map<String, dynamic> imageData = jsonDecode(uploadedFile.serialize());
  List<int> bytesList = List<int>.from(imageData['bytes']);
  String base64String = base64Encode(bytesList);

  return base64String;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
