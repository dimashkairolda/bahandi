import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/checkboxes/checkboxes_widget.dart';
import '/inspections/date/date_widget.dart';
import '/inspections/diapason/diapason_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska/iz_spiska_widget.dart';
import '/inspections/radio_defect/radio_defect_widget.dart';
import '/inspections/shkala/shkala_widget.dart';
import '/inspections/short_text/short_text_widget.dart';
import '/inspections/zamery/zamery_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'detailed_inspections_widget.dart' show DetailedInspectionsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailedInspectionsModel
    extends FlutterFlowModel<DetailedInspectionsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for radio_defect dynamic component.
  late FlutterFlowDynamicModels<RadioDefectModel> radioDefectModels;
  // Models for instruction dynamic component.
  late FlutterFlowDynamicModels<InstructionModel> instructionModels;
  // Models for checkboxes dynamic component.
  late FlutterFlowDynamicModels<CheckboxesModel> checkboxesModels;
  // Models for diapason dynamic component.
  late FlutterFlowDynamicModels<DiapasonModel> diapasonModels;
  // Models for izSpiska dynamic component.
  late FlutterFlowDynamicModels<IzSpiskaModel> izSpiskaModels;
  // Models for shortText dynamic component.
  late FlutterFlowDynamicModels<ShortTextModel> shortTextModels;
  // Models for date dynamic component.
  late FlutterFlowDynamicModels<DateModel> dateModels;
  // Models for shkala dynamic component.
  late FlutterFlowDynamicModels<ShkalaModel> shkalaModels;
  // Models for zamery dynamic component.
  late FlutterFlowDynamicModels<ZameryModel> zameryModels;

  @override
  void initState(BuildContext context) {
    radioDefectModels = FlutterFlowDynamicModels(() => RadioDefectModel());
    instructionModels = FlutterFlowDynamicModels(() => InstructionModel());
    checkboxesModels = FlutterFlowDynamicModels(() => CheckboxesModel());
    diapasonModels = FlutterFlowDynamicModels(() => DiapasonModel());
    izSpiskaModels = FlutterFlowDynamicModels(() => IzSpiskaModel());
    shortTextModels = FlutterFlowDynamicModels(() => ShortTextModel());
    dateModels = FlutterFlowDynamicModels(() => DateModel());
    shkalaModels = FlutterFlowDynamicModels(() => ShkalaModel());
    zameryModels = FlutterFlowDynamicModels(() => ZameryModel());
  }

  @override
  void dispose() {
    radioDefectModels.dispose();
    instructionModels.dispose();
    checkboxesModels.dispose();
    diapasonModels.dispose();
    izSpiskaModels.dispose();
    shortTextModels.dispose();
    dateModels.dispose();
    shkalaModels.dispose();
    zameryModels.dispose();
  }
}
