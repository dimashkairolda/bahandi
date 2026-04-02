import '/flutter_flow/flutter_flow_util.dart';
import 'short_text1_widget.dart' show ShortText1Widget;
import 'package:flutter/material.dart';

class ShortText1Model extends FlutterFlowModel<ShortText1Widget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
