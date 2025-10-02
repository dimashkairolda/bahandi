import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/change_equipment_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'barcode_widget.dart' show BarcodeWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BarcodeModel extends FlutterFlowModel<BarcodeWidget> {
  ///  State fields for stateful widgets in this page.

  var aa = '';
  // Stores action output result for [Backend Call - API (GetEquipmentsBarcode)] action in barcode widget.
  ApiCallResponse? qq;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
