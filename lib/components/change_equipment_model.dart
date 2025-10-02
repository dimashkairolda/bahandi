import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'change_equipment_widget.dart' show ChangeEquipmentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeEquipmentModel extends FlutterFlowModel<ChangeEquipmentWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (GetEquipmentsBarcode Copy)] action in Button widget.
  ApiCallResponse? qq;
  // Stores action output result for [Backend Call - API (CreateEquipmentInventory)] action in Button widget.
  ApiCallResponse? apiResult0pr;
  // Stores action output result for [Backend Call - API (UpdateEquipmentInventory)] action in Button widget.
  ApiCallResponse? apiResulttsb;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
