import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'radio_defect_model.dart';
export 'radio_defect_model.dart';

class RadioDefectWidget extends StatefulWidget {
  const RadioDefectWidget({
    super.key,
    required this.data,
    required this.searchID,
    required this.equipmentId,
    required this.name,
    required this.index,
    required this.nextIndex,
  });

  final dynamic data;
  final int? searchID;
  final int? equipmentId;
  final dynamic name;
  final int? index;
  final int? nextIndex;

  @override
  State<RadioDefectWidget> createState() => _RadioDefectWidgetState();
}

class _RadioDefectWidgetState extends State<RadioDefectWidget> {
  late RadioDefectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioDefectModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (getJsonField(
            widget!.data,
            r'''$.result.response''',
          ) ==
          null) {
        _model.isTrue = 0;
        safeSetState(() {});
      } else {
        if (getJsonField(
              widget!.data,
              r'''$.result.response''',
            ) ==
            functions.stringToJson('\"normal\"')) {
          _model.isTrue = 1;
          safeSetState(() {});
        } else {
          _model.isTrue = 2;
          safeSetState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.83,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(28.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.maxlines = 15;
                            safeSetState(() {});
                          },
                          child: Text(
                            getJsonField(
                              widget!.data,
                              r'''$.data.title''',
                            ).toString(),
                            textAlign: TextAlign.start,
                            maxLines: _model.maxlines,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        if (_model.maxlines == 4)
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.maxlines = 15;
                              safeSetState(() {});
                            },
                            child: Text(
                              '...',
                              textAlign: TextAlign.start,
                              maxLines: _model.maxlines,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    HapticFeedback.vibrate();
                    if (_model.isTrue == 1) {
                      await actions.updateResponseById(
                        FFAppState().checkCache,
                        widget!.searchID!,
                        widget!.equipmentId!,
                        getJsonField(
                          widget!.data,
                          r'''$.data.title''',
                        ).toString(),
                        null,
                      );
                      _model.isTrue = 0;
                      safeSetState(() {});
                    } else {
                      _model.isTrue = 1;
                      safeSetState(() {});
                      await actions.updateResponseById(
                        FFAppState().checkCache,
                        widget!.searchID!,
                        widget!.equipmentId!,
                        getJsonField(
                          widget!.data,
                          r'''$.data.title''',
                        ).toString(),
                        'normal',
                      );
                    }
                  },
                  text: getJsonField(
                    widget!.data,
                    r'''$.data.normal''',
                  ).toString(),
                  options: FFButtonOptions(
                    width: valueOrDefault<double>(
                      () {
                        if (_model.isTrue == 1) {
                          return 300.0;
                        } else if (_model.isTrue == 2) {
                          return 0.0;
                        } else {
                          return 150.0;
                        }
                      }(),
                      100.0,
                    ),
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF2A61ED),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: Colors.white,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    HapticFeedback.vibrate();
                    if (_model.isTrue == 2) {
                      _model.isTrue = 0;
                      safeSetState(() {});
                      await actions.updateResponseById(
                        FFAppState().checkCache,
                        widget!.searchID!,
                        widget!.equipmentId!,
                        getJsonField(
                          widget!.data,
                          r'''$.data.title''',
                        ).toString(),
                        null,
                      );
                    } else {
                      _model.isTrue = 2;
                      safeSetState(() {});
                      await actions.updateResponseById(
                        FFAppState().checkCache,
                        widget!.searchID!,
                        widget!.equipmentId!,
                        getJsonField(
                          widget!.data,
                          r'''$.data.title''',
                        ).toString(),
                        'defect',
                      );

                      context.pushNamed(
                        CreateDefectFromInspectionWidget.routeName,
                        queryParameters: {
                          'searchid': serializeParam(
                            widget!.searchID,
                            ParamType.int,
                          ),
                          'equipid': serializeParam(
                            widget!.equipmentId,
                            ParamType.int,
                          ),
                          'formTitle': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.data.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'name': serializeParam(
                            widget!.name,
                            ParamType.JSON,
                          ),
                          'index': serializeParam(
                            widget!.index,
                            ParamType.int,
                          ),
                          'title': serializeParam(
                            '',
                            ParamType.String,
                          ),
                          'text': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.data.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'event': serializeParam(
                            '',
                            ParamType.String,
                          ),
                          'isfixedonplace': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.isFixedOnPlace''',
                            ),
                            ParamType.int,
                          ),
                          'isemergencysituation': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.isEmergencySituation''',
                            ),
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    }
                  },
                  text: getJsonField(
                    widget!.data,
                    r'''$.data.defect''',
                  ).toString(),
                  options: FFButtonOptions(
                    width: () {
                      if (_model.isTrue == 2) {
                        return 300.0;
                      } else if (_model.isTrue == 1) {
                        return 0.0;
                      } else {
                        return 150.0;
                      }
                    }(),
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).error,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: Colors.white,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if ((getJsonField(
                          widget!.data,
                          r'''$.result.defect''',
                        ) ==
                        null) &&
                    (_model.isTrue == 2)) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              CreateDefectFromInspectionWidget.routeName,
                              queryParameters: {
                                'searchid': serializeParam(
                                  widget!.searchID,
                                  ParamType.int,
                                ),
                                'equipid': serializeParam(
                                  widget!.equipmentId,
                                  ParamType.int,
                                ),
                                'formTitle': serializeParam(
                                  getJsonField(
                                    widget!.data,
                                    r'''$.data.title''',
                                  ).toString(),
                                  ParamType.String,
                                ),
                                'index': serializeParam(
                                  widget!.index,
                                  ParamType.int,
                                ),
                                'name': serializeParam(
                                  widget!.name,
                                  ParamType.JSON,
                                ),
                                'text': serializeParam(
                                  getJsonField(
                                    widget!.data,
                                    r'''$.data.title''',
                                  ).toString(),
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: '+ Добавить дефект',
                          options: FFButtonOptions(
                            width: 220.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF2A61ED),
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(
                    width: 100.0,
                    height: 0.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                }
              },
            ),
            Builder(
              builder: (context) {
                if (getJsonField(
                      widget!.data,
                      r'''$.result.defect''',
                    ) ==
                    null) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 0.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                } else {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed(
                        CreateDefectFromInspectionWidget.routeName,
                        queryParameters: {
                          'searchid': serializeParam(
                            widget!.searchID,
                            ParamType.int,
                          ),
                          'equipid': serializeParam(
                            widget!.equipmentId,
                            ParamType.int,
                          ),
                          'formTitle': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.data.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'text': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.data.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'title': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'reason': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.reason''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'event': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.event''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'type': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.type''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'isfixedonplace': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.isFixedOnPlace''',
                            ),
                            ParamType.int,
                          ),
                          'isemergencysituation': serializeParam(
                            getJsonField(
                              widget!.data,
                              r'''$.result.defect.isEmergencySituation''',
                            ),
                            ParamType.int,
                          ),
                          'name': serializeParam(
                            widget!.name,
                            ParamType.JSON,
                          ),
                          'index': serializeParam(
                            widget!.index,
                            ParamType.int,
                          ),
                        }.withoutNulls,
                      );
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).error,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getJsonField(
                                widget!.data,
                                r'''$.result.defect.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Icon(
                              Icons.remove_red_eye,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
