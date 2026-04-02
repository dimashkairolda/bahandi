import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_defect_copy_widget.dart' show CreateDefectCopyWidget;
import 'package:flutter/material.dart';

class CreateDefectCopyModel extends FlutterFlowModel<CreateDefectCopyWidget> {
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

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for prioritet widget.
  bool? prioritetValue;
  // State field(s) for errormonitoring widget.
  bool? errormonitoringValue;
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in Button widget.
  bool? hh;
  // Stores action output result for [Backend Call - API (CreateDefects)] action in Button widget.
  ApiCallResponse? apiResultg8z;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
