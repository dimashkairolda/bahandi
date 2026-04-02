import '/flutter_flow/flutter_flow_util.dart';
import '/inspections/instruction/instruction_widget.dart';
import 'detailed_inspection_done_widget.dart' show DetailedInspectionDoneWidget;
import 'package:flutter/material.dart';

class DetailedInspectionDoneModel
    extends FlutterFlowModel<DetailedInspectionDoneWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for instruction dynamic component.
  late FlutterFlowDynamicModels<InstructionModel> instructionModels;

  @override
  void initState(BuildContext context) {
    instructionModels = FlutterFlowDynamicModels(() => InstructionModel());
  }

  @override
  void dispose() {
    instructionModels.dispose();
  }
}
