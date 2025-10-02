import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/edit_defect2_widget.dart';
import '/components/editcomment_widget.dart';
import '/defects/add_comment_copy/add_comment_copy_widget.dart';
import '/defects/add_t_m_c/add_t_m_c_widget.dart';
import '/defects/add_works/add_works_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'detailed_defects_offline_widget.dart' show DetailedDefectsOfflineWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DetailedDefectsOfflineModel
    extends FlutterFlowModel<DetailedDefectsOfflineWidget> {
  ///  Local state fields for this page.

  List<dynamic> photos123 = [];
  void addToPhotos123(dynamic item) => photos123.add(item);
  void removeFromPhotos123(dynamic item) => photos123.remove(item);
  void removeAtIndexFromPhotos123(int index) => photos123.removeAt(index);
  void insertAtIndexInPhotos123(int index, dynamic item) =>
      photos123.insert(index, item);
  void updatePhotos123AtIndex(int index, Function(dynamic) updateFn) =>
      photos123[index] = updateFn(photos123[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultg8zCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultg8zCopyCopy;
  bool isDataUploading_uploadDataTbt501123 = false;
  FFUploadedFile uploadedLocalFile_uploadDataTbt501123 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileAndConvertToBase64toList] action in Button widget.
  dynamic? qq;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiRes;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9;
  var aa = '';
  // Stores action output result for [Backend Call - API (GetEquipmentsBarcode)] action in Button widget.
  ApiCallResponse? qqq123;
  // Stores action output result for [Custom Action - addLocationData] action in Button widget.
  List<double>? scan;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9Copy123;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResusdsdf;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaa;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsss;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsss1;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaaa;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsssCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9CopyCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9Copy1Copy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
