import '/flutter_flow/flutter_flow_util.dart';
import 'diapason_show_widget.dart' show DiapasonShowWidget;
import 'package:flutter/material.dart';

class DiapasonShowModel extends FlutterFlowModel<DiapasonShowWidget> {
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
