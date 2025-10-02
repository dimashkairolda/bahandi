import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/radio_defect/radio_defect_widget.dart';
import '/inspections/zamery/zamery_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'detailed_inspections2_widget.dart' show DetailedInspections2Widget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailedInspections2Model
    extends FlutterFlowModel<DetailedInspections2Widget> {
  ///  State fields for stateful widgets in this page.

  // Models for radio_defect dynamic component.
  late FlutterFlowDynamicModels<RadioDefectModel> radioDefectModels;
  // Models for zamery dynamic component.
  late FlutterFlowDynamicModels<ZameryModel> zameryModels;

  @override
  void initState(BuildContext context) {
    radioDefectModels = FlutterFlowDynamicModels(() => RadioDefectModel());
    zameryModels = FlutterFlowDynamicModels(() => ZameryModel());
  }

  @override
  void dispose() {
    radioDefectModels.dispose();
    zameryModels.dispose();
  }
}
