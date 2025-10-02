import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_equipment_widget.dart' show CreateEquipmentWidget;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateEquipmentModel extends FlutterFlowModel<CreateEquipmentWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите наименование';
    }

    return null;
  }

  // State field(s) for type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // State field(s) for proizvoditel widget.
  String? proizvoditelValue1;
  FormFieldController<String>? proizvoditelValueController1;
  Completer<ApiCallResponse>? apiRequestCompleter2;
  // State field(s) for proizvoditel widget.
  String? proizvoditelValue2;
  FormFieldController<String>? proizvoditelValueController2;
  // State field(s) for model widget.
  String? modelValue1;
  FormFieldController<String>? modelValueController1;
  // State field(s) for model widget.
  String? modelValue2;
  FormFieldController<String>? modelValueController2;
  // State field(s) for department widget.
  List<int>? departmentValue;
  FormFieldController<List<int>>? departmentValueController;
  // State field(s) for zavodskoi widget.
  FocusNode? zavodskoiFocusNode;
  TextEditingController? zavodskoiTextController;
  String? Function(BuildContext, String?)? zavodskoiTextControllerValidator;
  String? _zavodskoiTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите заводской номер ';
    }

    return null;
  }

  // State field(s) for inventarnyi widget.
  FocusNode? inventarnyiFocusNode;
  TextEditingController? inventarnyiTextController;
  String? Function(BuildContext, String?)? inventarnyiTextControllerValidator;
  String? _inventarnyiTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите инвентарный номер';
    }

    return null;
  }

  // State field(s) for dispatch widget.
  FocusNode? dispatchFocusNode;
  TextEditingController? dispatchTextController;
  String? Function(BuildContext, String?)? dispatchTextControllerValidator;
  String? _dispatchTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите диспетчерский номер';
    }

    return null;
  }

  // State field(s) for narabotka widget.
  FocusNode? narabotkaFocusNode;
  TextEditingController? narabotkaTextController;
  String? Function(BuildContext, String?)? narabotkaTextControllerValidator;
  String? _narabotkaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите наработку ';
    }

    return null;
  }

  DateTime? datePicked;
  // State field(s) for barcodee widget.
  FocusNode? barcodeeFocusNode;
  TextEditingController? barcodeeTextController;
  String? Function(BuildContext, String?)? barcodeeTextControllerValidator;
  String? _barcodeeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите штрих-код ';
    }

    return null;
  }

  // State field(s) for nomernasxeme widget.
  FocusNode? nomernasxemeFocusNode;
  TextEditingController? nomernasxemeTextController;
  String? Function(BuildContext, String?)? nomernasxemeTextControllerValidator;
  String? _nomernasxemeTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Введите номер';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (CreateEquipment)] action in Button widget.
  ApiCallResponse? apiResult25k;
  // Stores action output result for [Backend Call - API (CreateEquipmentInventory)] action in Button widget.
  ApiCallResponse? apiResult0pr;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    zavodskoiTextControllerValidator = _zavodskoiTextControllerValidator;
    inventarnyiTextControllerValidator = _inventarnyiTextControllerValidator;
    dispatchTextControllerValidator = _dispatchTextControllerValidator;
    narabotkaTextControllerValidator = _narabotkaTextControllerValidator;
    barcodeeTextControllerValidator = _barcodeeTextControllerValidator;
    nomernasxemeTextControllerValidator = _nomernasxemeTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    zavodskoiFocusNode?.dispose();
    zavodskoiTextController?.dispose();

    inventarnyiFocusNode?.dispose();
    inventarnyiTextController?.dispose();

    dispatchFocusNode?.dispose();
    dispatchTextController?.dispose();

    narabotkaFocusNode?.dispose();
    narabotkaTextController?.dispose();

    barcodeeFocusNode?.dispose();
    barcodeeTextController?.dispose();

    nomernasxemeFocusNode?.dispose();
    nomernasxemeTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
