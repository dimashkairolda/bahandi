import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/defects/choose_user/choose_user_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'defects_widget.dart' show DefectsWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DefectsModel extends FlutterFlowModel<DefectsWidget> {
  ///  Local state fields for this page.

  int page = 1;

  List<dynamic> defectsItems = [];

  int totalPages = 1;

  bool isInitialLoading = false;

  bool isLoadingMore = false;

  String? loadErrorMessage;

  bool isEdited = false;

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - showNotificationSnackbar] action in Defects widget.
  bool? aaa;
  // Stores action output result for [Backend Call - API (Auth)] action in Defects widget.
  ApiCallResponse? authResponse1;
  var aa = '';
  // Stores action output result for [Backend Call - API (GetEquipmentsBarcode)] action in Button widget.
  ApiCallResponse? qq;
  // Stores action output result for [Backend Call - API (GetDefectsForm)] action in Button widget.
  ApiCallResponse? zz;
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
  // State field(s) for type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;
  // State field(s) for contractor widget.
  String? contractorValue;
  FormFieldController<String>? contractorValueController;
  // Мои заявки (API: только при true передаётся my_request=true)
  bool myRequestsOnly = false;
  // Критичность: high | medium | low | null (все)
  String? criticalityFilter;
  FormFieldController<String>? criticalityFilterController;

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
      final requestComplete = !isInitialLoading && !isLoadingMore;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

}
