import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'photo_or_video_widget.dart' show PhotoOrVideoWidget;
import 'package:flutter/material.dart';

class PhotoOrVideoModel extends FlutterFlowModel<PhotoOrVideoWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_uploadD = false;
  FFUploadedFile uploadedLocalFile_uploadD =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? tet;
  // Stores action output result for [Custom Action - pickCameraVideo] action in Dropdown_1_Options widget.
  FFUploadedFile? rer;
  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? asas;
  bool isLoading = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
