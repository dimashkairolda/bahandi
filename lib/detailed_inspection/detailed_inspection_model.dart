import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/shkala1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/checkboxes1/checkboxes1_widget.dart';
import '/inspections/date1/date1_widget.dart';
import '/inspections/diapason1/diapason1_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska1/iz_spiska1_widget.dart';
import '/inspections/radio_defect1/radio_defect1_widget.dart';
import '/inspections/short_text1/short_text1_widget.dart';
import '/inspections/zamery1/zamery1_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'detailed_inspection_widget.dart' show DetailedInspectionWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailedInspectionModel
    extends FlutterFlowModel<DetailedInspectionWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for instruction dynamic component.
  late FlutterFlowDynamicModels<InstructionModel> instructionModels;
  // Models for radio_defect1 dynamic component.
  late FlutterFlowDynamicModels<RadioDefect1Model> radioDefect1Models;
  // Models for checkboxes1 dynamic component.
  late FlutterFlowDynamicModels<Checkboxes1Model> checkboxes1Models;
  // Models for diapason1 dynamic component.
  late FlutterFlowDynamicModels<Diapason1Model> diapason1Models;
  // Models for izSpiska1 dynamic component.
  late FlutterFlowDynamicModels<IzSpiska1Model> izSpiska1Models;
  // Models for shortText1 dynamic component.
  late FlutterFlowDynamicModels<ShortText1Model> shortText1Models;
  // Models for date1 dynamic component.
  late FlutterFlowDynamicModels<Date1Model> date1Models;
  // Models for shkala1 dynamic component.
  late FlutterFlowDynamicModels<Shkala1Model> shkala1Models;
  // Models for zamery1 dynamic component.
  late FlutterFlowDynamicModels<Zamery1Model> zamery1Models;
  // Stores action output result for [Backend Call - API (InspectionFinish)] action in Button widget.
  ApiCallResponse? apiResultw4j;

  @override
  void initState(BuildContext context) {
    instructionModels = FlutterFlowDynamicModels(() => InstructionModel());
    radioDefect1Models = FlutterFlowDynamicModels(() => RadioDefect1Model());
    checkboxes1Models = FlutterFlowDynamicModels(() => Checkboxes1Model());
    diapason1Models = FlutterFlowDynamicModels(() => Diapason1Model());
    izSpiska1Models = FlutterFlowDynamicModels(() => IzSpiska1Model());
    shortText1Models = FlutterFlowDynamicModels(() => ShortText1Model());
    date1Models = FlutterFlowDynamicModels(() => Date1Model());
    shkala1Models = FlutterFlowDynamicModels(() => Shkala1Model());
    zamery1Models = FlutterFlowDynamicModels(() => Zamery1Model());
  }

  @override
  void dispose() {
    instructionModels.dispose();
    radioDefect1Models.dispose();
    checkboxes1Models.dispose();
    diapason1Models.dispose();
    izSpiska1Models.dispose();
    shortText1Models.dispose();
    date1Models.dispose();
    shkala1Models.dispose();
    zamery1Models.dispose();
  }
}
