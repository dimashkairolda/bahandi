import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'checkboxes_widget.dart' show CheckboxesWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckboxesModel extends FlutterFlowModel<CheckboxesWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxListTile widget.
  Map<dynamic, bool> checkboxListTileValueMap = {};
  List<dynamic> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
