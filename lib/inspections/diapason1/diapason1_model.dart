import '/flutter_flow/flutter_flow_util.dart';
import 'diapason1_widget.dart' show Diapason1Widget;
import 'package:flutter/material.dart';

class Diapason1Model extends FlutterFlowModel<Diapason1Widget> {
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
