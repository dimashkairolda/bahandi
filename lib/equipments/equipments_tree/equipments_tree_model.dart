import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'equipments_tree_widget.dart' show EquipmentsTreeWidget;
import 'package:flutter/material.dart';

class EquipmentsTreeModel extends FlutterFlowModel<EquipmentsTreeWidget> {
  ///  Local state fields for this page.

  int page = 1;

  List<dynamic> equipmentItems = [];

  int totalPages = 1;
  bool isInitialLoading = false;
  bool isLoadingMore = false;
  String? loadErrorMessage;

  String? areaFilter;

  String? criticalityFilter;

  String? statusFilter;

  String? categoryFilter;

  bool showArchived = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for criticality widget.
  String? criticalityValue;
  FormFieldController<String>? criticalityValueController;
  // State field(s) for status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
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
      final requestComplete = !isInitialLoading && !isLoadingMore;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
