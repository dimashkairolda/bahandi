import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'checkboxes1_widget.dart' show Checkboxes1Widget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Checkboxes1Model extends FlutterFlowModel<Checkboxes1Widget> {
  ///  Local state fields for this component.

  bool isBig = false;

  List<String> redios = [];
  void addToRedios(String item) => redios.add(item);
  void removeFromRedios(String item) => redios.remove(item);
  void removeAtIndexFromRedios(int index) => redios.removeAt(index);
  void insertAtIndexInRedios(int index, String item) =>
      redios.insert(index, item);
  void updateRediosAtIndex(int index, Function(String) updateFn) =>
      redios[index] = updateFn(redios[index]);

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadDataDnd1 = false;
  FFUploadedFile uploadedLocalFile_uploadDataDnd1 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (PostFiles)] action in Button widget.
  ApiCallResponse? uuu123;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
