import '/flutter_flow/flutter_flow_util.dart';
import 'add_t_m_c_widget.dart' show AddTMCWidget;
import 'package:flutter/material.dart';

class AddTMCModel extends FlutterFlowModel<AddTMCWidget> {
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

  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  String? _attributeTextControllerValidator(BuildContext context, String? val) {
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
    attributeTextControllerValidator = _attributeTextControllerValidator;
    sumTextControllerValidator = _sumTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    sumFocusNode?.dispose();
    sumTextController?.dispose();
  }
}
