import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'inspections_widget.dart' show InspectionsWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InspectionsModel extends FlutterFlowModel<InspectionsWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  bool isloading = false;

  ///  State fields for stateful widgets in this page.

  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (GetInspectionsById)] action in Container widget.
  ApiCallResponse? qww123;
  // Stores action output result for [Backend Call - API (StartInspection)] action in Container widget.
  ApiCallResponse? apiResultfn1;
  // Stores action output result for [Backend Call - API (GetInspectionsById)] action in Container widget.
  ApiCallResponse? qww12;

  /// Query cache managers for this widget.

  final _inspectionsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> inspections({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _inspectionsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearInspectionsCache() => _inspectionsManager.clear();
  void clearInspectionsCacheKey(String? uniqueKey) =>
      _inspectionsManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    /// Dispose query cache managers for this widget.

    clearInspectionsCache();
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
