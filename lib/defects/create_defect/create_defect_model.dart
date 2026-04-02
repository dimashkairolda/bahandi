import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/inspections/checkboxes/checkboxes_widget.dart';
import '/inspections/date/date_widget.dart';
import '/inspections/diapason/diapason_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska/iz_spiska_widget.dart';
import '/inspections/radio_defect/radio_defect_widget.dart';
import '/inspections/short_text/short_text_widget.dart';
import '/inspections/zamery/zamery_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'create_defect_widget.dart' show CreateDefectWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CreateDefectModel extends FlutterFlowModel<CreateDefectWidget> {
  ///  Local state fields for this page.

  List<dynamic> photos123 = [];
  void addToPhotos123(dynamic item) => photos123.add(item);
  void removeFromPhotos123(dynamic item) => photos123.remove(item);
  void removeAtIndexFromPhotos123(int index) => photos123.removeAt(index);
  void insertAtIndexInPhotos123(int index, dynamic item) =>
      photos123.insert(index, item);
  void updatePhotos123AtIndex(int index, Function(dynamic) updateFn) =>
      photos123[index] = updateFn(photos123[index]);

  int? dd;

  bool tmc = true;
  bool isLoading = false;

  String priority = 'medium';

  int? selectedAreaId;
  String? selectedAreaTitle;
  FormFieldController<String>? areaValueController;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  bool isDataUploading_uploadD111 = false;
  FFUploadedFile uploadedLocalFile_uploadD111 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? tet;
  // Stores action output result for [Custom Action - pickCameraVideo] action in Dropdown_1_Options widget.
  FFUploadedFile? rer;
  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? asas;
  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  // State field(s) for sum widget.
  FocusNode? sumFocusNode1;
  TextEditingController? sumTextController1;
  String? Function(BuildContext, String?)? sumTextController1Validator;
  // State field(s) for name widget.
  FocusNode? nameFocusNode3;
  TextEditingController? nameTextController3;
  String? Function(BuildContext, String?)? nameTextController3Validator;
  // State field(s) for sum widget.
  FocusNode? sumFocusNode2;
  TextEditingController? sumTextController2;
  String? Function(BuildContext, String?)? sumTextController2Validator;
  // State field(s) for prioritet widget.
  bool? prioritetValue;
  // State field(s) for errormonitoring widget.
  bool? errormonitoringValue;
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in Button widget.
  bool? hh;
  // Stores action output result for [Backend Call - API (CreateDefects)] action in Button widget.
  ApiCallResponse? apiResultg8z;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    sumFocusNode1?.dispose();
    sumTextController1?.dispose();

    nameFocusNode3?.dispose();
    nameTextController3?.dispose();

    sumFocusNode2?.dispose();
    sumTextController2?.dispose();
  }
}
