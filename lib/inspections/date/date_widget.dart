import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'date_model.dart';
export 'date_model.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({
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
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late DateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DateModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11.0, 11.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                child: Text(
                  getJsonField(
                    widget!.data,
                    r'''$.data.title''',
                  ).toString(),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SFProText',
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final _datePickedDate = await showDatePicker(
                    context: context,
                    initialDate: getCurrentTimestamp,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2050),
                    builder: (context, child) {
                      return wrapInMaterialDatePickerTheme(
                        context,
                        child!,
                        headerBackgroundColor:
                            FlutterFlowTheme.of(context).primary,
                        headerForegroundColor:
                            FlutterFlowTheme.of(context).info,
                        headerTextStyle:
                            FlutterFlowTheme.of(context).headlineLarge.override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .fontStyle,
                                  ),
                                  fontSize: 32.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                        pickerBackgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        pickerForegroundColor:
                            FlutterFlowTheme.of(context).primaryText,
                        selectedDateTimeBackgroundColor:
                            FlutterFlowTheme.of(context).primary,
                        selectedDateTimeForegroundColor:
                            FlutterFlowTheme.of(context).info,
                        actionButtonForegroundColor:
                            FlutterFlowTheme.of(context).primaryText,
                        iconSize: 24.0,
                      );
                    },
                  );

                  if (_datePickedDate != null) {
                    safeSetState(() {
                      _model.datePicked = DateTime(
                        _datePickedDate.year,
                        _datePickedDate.month,
                        _datePickedDate.day,
                      );
                    });
                  } else if (_model.datePicked != null) {
                    safeSetState(() {
                      _model.datePicked = getCurrentTimestamp;
                    });
                  }
                  await actions.updateResponseByIdZamery(
                    FFAppState().checkCache,
                    widget!.searchID!,
                    widget!.equipmentId!,
                    getJsonField(
                      widget!.data,
                      r'''$.data.title''',
                    ).toString(),
                    valueOrDefault<String>(
                      dateTimeFormat(
                        "y-MM-d",
                        _model.datePicked,
                        locale: FFLocalizations.of(context).languageCode,
                      ),
                      'Время исправления',
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.0, 10.0, 0.0, 10.0),
                            child: Text(
                              valueOrDefault<String>(
                                dateTimeFormat(
                                  "y-MM-d",
                                  _model.datePicked,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                ),
                                'Время исправления',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
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
                        'text': serializeParam(
                          getJsonField(
                            widget!.data,
                            r'''$.data.title''',
                          ).toString(),
                          ParamType.String,
                        ),
                        'title': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'reason': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'event': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'type': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'isfixedonplace': serializeParam(
                          0,
                          ParamType.int,
                        ),
                        'isemergencysituation': serializeParam(
                          0,
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
                  text: '+ Добавить дефект',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF2A61ED),
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
