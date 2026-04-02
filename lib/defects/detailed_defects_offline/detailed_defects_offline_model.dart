import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'detailed_defects_offline_widget.dart' show DetailedDefectsOfflineWidget;
import 'package:flutter/material.dart';

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

  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Icon widget.
  ApiCallResponse? apiResur;
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  // State field(s) for sum widget.
  FocusNode? sumFocusNode1;
  TextEditingController? sumTextController1;
  String? Function(BuildContext, String?)? sumTextController1Validator;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Container widget.
  ApiCallResponse? apiResultg8zCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Icon widget.
  ApiCallResponse? apiResur2;
  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  // State field(s) for sum widget.
  FocusNode? sumFocusNode2;
  TextEditingController? sumTextController2;
  String? Function(BuildContext, String?)? sumTextController2Validator;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Container widget.
  ApiCallResponse? wewe;
  bool isDataUploading_uploadD1112 = false;
  FFUploadedFile uploadedLocalFile_uploadD1112 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? tet;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Dropdown_1_Options widget.
  ApiCallResponse? apiResultg8zCo;
  // Stores action output result for [Custom Action - pickCameraVideo] action in Dropdown_1_Options widget.
  FFUploadedFile? rer;
  // Stores action output result for [Backend Call - API (PostFiles)] action in Dropdown_1_Options widget.
  ApiCallResponse? asas;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Dropdown_1_Options widget.
  ApiCallResponse? apiResultg8zCopy12;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResusdsdf;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9CopyCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9Copy1Copy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9Copy123;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResusdsdfz;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaa;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsss;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsss1;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaaa;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResul;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiRe;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResu;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaaa1;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaaaaaa;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaaaasd;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfsssas;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResuldfsdfs;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9Copy123q;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? aaaasd;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiR;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? ap;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    sumFocusNode1?.dispose();
    sumTextController1?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    sumFocusNode2?.dispose();
    sumTextController2?.dispose();
  }
}
