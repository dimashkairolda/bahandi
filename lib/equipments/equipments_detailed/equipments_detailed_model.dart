import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'equipments_detailed_widget.dart' show EquipmentsDetailedWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EquipmentsDetailedModel
    extends FlutterFlowModel<EquipmentsDetailedWidget> {
  ///  Local state fields for this page.

  List<dynamic> parameters = [];
  void addToParameters(dynamic item) => parameters.add(item);
  void removeFromParameters(dynamic item) => parameters.remove(item);
  void removeAtIndexFromParameters(int index) => parameters.removeAt(index);
  void insertAtIndexInParameters(int index, dynamic item) =>
      parameters.insert(index, item);
  void updateParametersAtIndex(int index, Function(dynamic) updateFn) =>
      parameters[index] = updateFn(parameters[index]);

  int xarakteristic = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<dynamic>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    paginatedDataTableController.dispose();
  }
}
