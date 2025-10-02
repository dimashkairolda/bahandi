import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/radio_defect_copy/radio_defect_copy_widget.dart';
import '/inspections/zamery_copy/zamery_copy_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detailed_inspections_ended_model.dart';
export 'detailed_inspections_ended_model.dart';

class DetailedInspectionsEndedWidget extends StatefulWidget {
  const DetailedInspectionsEndedWidget({
    super.key,
    required this.name,
    required this.index,
  });

  final dynamic name;
  final int? index;

  static String routeName = 'detailedInspectionsEnded';
  static String routePath = '/detailedInspectionsEnded';

  @override
  State<DetailedInspectionsEndedWidget> createState() =>
      _DetailedInspectionsEndedWidgetState();
}

class _DetailedInspectionsEndedWidgetState
    extends State<DetailedInspectionsEndedWidget> {
  late DetailedInspectionsEndedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionsEndedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().inspectionsTemp = 0;
      FFAppState().loopFormResult = 0;
      safeSetState(() {});
      await actions.updateStartedOn(
        FFAppState().checkCache,
        getJsonField(
          widget!.name,
          r'''$.id''',
        ),
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFEEF1F2),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF2A61ED),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            '${dateTimeFormat(
              "Hm",
              functions.stringToDateTime(getJsonField(
                widget!.name,
                r'''$.available_from''',
              ).toString()),
              locale: FFLocalizations.of(context).languageCode,
            )}-${dateTimeFormat(
              "Hm",
              functions.stringToDateTime(getJsonField(
                widget!.name,
                r'''$.available_to''',
              ).toString()),
              locale: FFLocalizations.of(context).languageCode,
            )}',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'SFProText',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 18.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.07,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 0.0, 10.0),
                            child: Text(
                              getJsonField(
                                widget!.name,
                                r'''$.regulation_info.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) {
                        final responses = getJsonField(
                          functions.findJsonElementByID(
                              FFAppState().checkCache,
                              getJsonField(
                                widget!.name,
                                r'''$.id''',
                              )),
                          r'''$.responses''',
                        ).toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(responses.length, (responsesIndex) {
                            final responsesItem = responses[responsesIndex];
                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        getJsonField(
                                          responsesItem,
                                          r'''$.regulation_work_info.equipment_info.title''',
                                        ).toString(),
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'SFProText',
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final formresult = getJsonField(
                                          responsesItem,
                                          r'''$.form_result''',
                                        ).toList();

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              List.generate(formresult.length,
                                                  (formresultIndex) {
                                            final formresultItem =
                                                formresult[formresultIndex];
                                            return Builder(
                                              builder: (context) {
                                                if (getJsonField(
                                                      formresultItem,
                                                      r'''$.type''',
                                                    ) ==
                                                    'radio_defect') {
                                                  return wrapWithModel(
                                                    model: _model
                                                        .radioDefectCopyModels
                                                        .getModel(
                                                      '',
                                                      formresultIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        RadioDefectCopyWidget(
                                                      key: Key(
                                                        'Keyafe_${''}',
                                                      ),
                                                      searchID: getJsonField(
                                                        widget!.name,
                                                        r'''$.id''',
                                                      ),
                                                      equipmentId: getJsonField(
                                                        formresultItem,
                                                        r'''$.regulation_work_info.equipment''',
                                                      ),
                                                      data: formresultItem,
                                                    ),
                                                  );
                                                } else {
                                                  return wrapWithModel(
                                                    model: _model
                                                        .zameryCopyModels
                                                        .getModel(
                                                      '',
                                                      formresultIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: ZameryCopyWidget(
                                                      key: Key(
                                                        'Key9e9_${''}',
                                                      ),
                                                      searchID: getJsonField(
                                                        widget!.name,
                                                        r'''$.id''',
                                                      ),
                                                      equipmentId: getJsonField(
                                                        responsesItem,
                                                        r'''$.regulation_work_info.equipment''',
                                                      ),
                                                      index: widget!.index!,
                                                      data: formresultItem,
                                                      name: widget!.name!,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          }).divide(SizedBox(height: 5.0)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).divide(SizedBox(height: 5.0)),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
