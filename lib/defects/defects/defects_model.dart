import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'defects_widget.dart' show DefectsWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DefectsModel extends FlutterFlowModel<DefectsWidget> {
  ///  Local state fields for this page.

  int page = 10;

  bool isEdited = false;

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Auth)] action in Defects widget.
  ApiCallResponse? authResponse1;
  // Stores action output result for [Backend Call - API (UpdateFCMToken)] action in Defects widget.
  ApiCallResponse? test;
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  DateTime? datePicked;
  // State field(s) for status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;
  // State field(s) for filial widget.
  String? filialValue;
  FormFieldController<String>? filialValueController;
  // State field(s) for contractor widget.
  String? contractorValue;
  FormFieldController<String>? contractorValueController;
  // State field(s) for type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
