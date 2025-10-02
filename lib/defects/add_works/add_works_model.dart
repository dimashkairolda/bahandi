import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'add_works_widget.dart' show AddWorksWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddWorksModel extends FlutterFlowModel<AddWorksWidget> {
  ///  State fields for stateful widgets in this component.

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

  // State field(s) for sum widget.
  FocusNode? sumFocusNode;
  TextEditingController? sumTextController;
  String? Function(BuildContext, String?)? sumTextControllerValidator;
  String? _sumTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    sumTextControllerValidator = _sumTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    sumFocusNode?.dispose();
    sumTextController?.dispose();
  }
}
