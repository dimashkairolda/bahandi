import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'inspections_time_list_widget.dart' show InspectionsTimeListWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InspectionsTimeListModel
    extends FlutterFlowModel<InspectionsTimeListWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Auth)] action in Icon widget.
  ApiCallResponse? authResponse;
  // Stores action output result for [Backend Call - API (StartInspection)] action in Icon widget.
  ApiCallResponse? apiResultfn1;
  // Stores action output result for [Backend Call - API (InspectionFinish)] action in Icon widget.
  ApiCallResponse? apiResultw4j;
  // Stores action output result for [Backend Call - API (GetAllInspections)] action in Icon widget.
  ApiCallResponse? apiResultcb9;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
