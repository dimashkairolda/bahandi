import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'iz_spiska_model.dart';
export 'iz_spiska_model.dart';

class IzSpiskaWidget extends StatefulWidget {
  const IzSpiskaWidget({
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
  State<IzSpiskaWidget> createState() => _IzSpiskaWidgetState();
}

class _IzSpiskaWidgetState extends State<IzSpiskaWidget> {
  late IzSpiskaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IzSpiskaModel());
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
              Text(
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
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowRadioButton(
                    options: (getJsonField(
                      widget!.data,
                      r'''$.data.radios[:].text''',
                      true,
                    ) as List?)!
                        .map<String>((e) => e.toString())
                        .toList()
                        .cast<String>()
                        .toList(),
                    onChanged: (val) async {
                      safeSetState(() {});
                      await actions.updateResponseByIdRadio(
                        FFAppState().checkCache,
                        widget!.searchID!,
                        widget!.equipmentId!,
                        getJsonField(
                          widget!.data,
                          r'''$.data.title''',
                        ).toString(),
                        _model.radioButtonValue!,
                      );
                    },
                    controller: _model.radioButtonValueController ??=
                        FormFieldController<String>(null),
                    optionHeight: 32.0,
                    textStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.readexPro(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    selectedTextStyle: FlutterFlowTheme.of(context)
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    buttonPosition: RadioButtonPosition.left,
                    direction: Axis.vertical,
                    radioButtonColor: FlutterFlowTheme.of(context).primary,
                    inactiveRadioButtonColor:
                        FlutterFlowTheme.of(context).secondaryText,
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.start,
                    verticalAlignment: WrapCrossAlignment.start,
                  ),
                ],
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
