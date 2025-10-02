import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_service_act_widget.dart' show CreateServiceActWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateServiceActModel extends FlutterFlowModel<CreateServiceActWidget> {
  ///  Local state fields for this page.

  List<dynamic> photos123 = [];
  void addToPhotos123(dynamic item) => photos123.add(item);
  void removeFromPhotos123(dynamic item) => photos123.remove(item);
  void removeAtIndexFromPhotos123(int index) => photos123.removeAt(index);
  void insertAtIndexInPhotos123(int index, dynamic item) =>
      photos123.insert(index, item);
  void updatePhotos123AtIndex(int index, Function(dynamic) updateFn) =>
      photos123[index] = updateFn(photos123[index]);

  int? dd;

  List<RequestStruct> requests = [];
  void addToRequests(RequestStruct item) => requests.add(item);
  void removeFromRequests(RequestStruct item) => requests.remove(item);
  void removeAtIndexFromRequests(int index) => requests.removeAt(index);
  void insertAtIndexInRequests(int index, RequestStruct item) =>
      requests.insert(index, item);
  void updateRequestsAtIndex(int index, Function(RequestStruct) updateFn) =>
      requests[index] = updateFn(requests[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for contractor widget.
  String? contractorValue;
  FormFieldController<String>? contractorValueController;
  // State field(s) for client widget.
  String? clientValue;
  FormFieldController<String>? clientValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for avarinaya widget.
  bool? avarinayaValue;
  // State field(s) for guarantee widget.
  bool? guaranteeValue;
  // State field(s) for lozhnyu widget.
  bool? lozhnyuValue;
  // State field(s) for techobs widget.
  bool? techobsValue;
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in Button widget.
  bool? hh;
  // Stores action output result for [Backend Call - API (CreateServiceAct)] action in Button widget.
  ApiCallResponse? apiResultg8z;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
