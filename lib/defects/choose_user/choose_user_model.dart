import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'choose_user_widget.dart' show ChooseUserWidget;
import 'package:flutter/material.dart';

class ChooseUserModel extends FlutterFlowModel<ChooseUserWidget> {
  ///  Local state fields for this component.

  int? chosenId;

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultss9;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResults;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
