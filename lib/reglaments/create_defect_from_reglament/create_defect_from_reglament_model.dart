import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_defect_from_reglament_widget.dart'
    show CreateDefectFromReglamentWidget;
import 'package:flutter/material.dart';

class CreateDefectFromReglamentModel
    extends FlutterFlowModel<CreateDefectFromReglamentWidget> {
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
