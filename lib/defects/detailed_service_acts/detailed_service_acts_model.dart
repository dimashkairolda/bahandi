import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'detailed_service_acts_widget.dart' show DetailedServiceActsWidget;
import 'package:flutter/material.dart';

class DetailedServiceActsModel
    extends FlutterFlowModel<DetailedServiceActsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultg8zCopy;
  // Stores action output result for [Backend Call - API (UpdateDefectsById)] action in Button widget.
  ApiCallResponse? apiResultg8zCopyCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
