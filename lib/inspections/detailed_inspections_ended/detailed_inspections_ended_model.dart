import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/radio_defect_copy/radio_defect_copy_widget.dart';
import '/inspections/zamery_copy/zamery_copy_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'detailed_inspections_ended_widget.dart'
    show DetailedInspectionsEndedWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailedInspectionsEndedModel
    extends FlutterFlowModel<DetailedInspectionsEndedWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for radio_defectCopy dynamic component.
  late FlutterFlowDynamicModels<RadioDefectCopyModel> radioDefectCopyModels;
  // Models for zameryCopy dynamic component.
  late FlutterFlowDynamicModels<ZameryCopyModel> zameryCopyModels;

  @override
  void initState(BuildContext context) {
    radioDefectCopyModels =
        FlutterFlowDynamicModels(() => RadioDefectCopyModel());
    zameryCopyModels = FlutterFlowDynamicModels(() => ZameryCopyModel());
  }

  @override
  void dispose() {
    radioDefectCopyModels.dispose();
    zameryCopyModels.dispose();
  }
}
