import 'package:Etry/media_viewer/media_viewer_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'radio_defect_show_model.dart';
export 'radio_defect_show_model.dart';

class RadioDefectShowWidget extends StatefulWidget {
  const RadioDefectShowWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final dynamic data;
  final int? index;

  @override
  State<RadioDefectShowWidget> createState() => _RadioDefectShowWidgetState();
}

class _RadioDefectShowWidgetState extends State<RadioDefectShowWidget> {
  late RadioDefectShowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioDefectShowModel());

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
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.83,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getJsonField(
                            widget!.data,
                            r'''$.data.title''',
                          ).toString(),
                          textAlign: TextAlign.start,
                          maxLines: _model.maxlines,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        if (functions.jsonToStringCopy(getJsonField(
                              widget!.data,
                              r'''$.data.description''',
                            )) !=
                            '\"\"')
                          Text(
                            getJsonField(
                              widget!.data,
                              r'''$.data.description''',
                            ).toString(),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: getJsonField(
                      widget!.data,
                      r'''$.data.normal''',
                    ).toString(),
                    icon: Icon(
                      Icons.check,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 0.42,
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconColor: getJsonField(
                                widget!.data,
                                r'''$.result.response''',
                              ) ==
                              functions.stringToJson('\"normal\"')
                          ? Colors.white
                          : Colors.black,
                      color: getJsonField(
                                widget!.data,
                                r'''$.result.response''',
                              ) ==
                              functions.stringToJson('\"normal\"')
                          ? Color(0xFF2A61ED)
                          : FlutterFlowTheme.of(context).primaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'SFProText',
                                color: getJsonField(
                                          widget!.data,
                                          r'''$.result.response''',
                                        ) ==
                                        functions.stringToJson('\"normal\"')
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: getJsonField(
                      widget!.data,
                      r'''$.data.defect''',
                    ).toString(),
                    icon: Icon(
                      Icons.close,
                      size: 15,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 0.42,
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconColor: getJsonField(
                                widget!.data,
                                r'''$.result.response''',
                              ) ==
                              functions.stringToJson('\"defect\"')
                          ? Colors.white
                          : Colors.black,
                      color: getJsonField(
                                widget!.data,
                                r'''$.result.response''',
                              ) ==
                              functions.stringToJson('\"defect\"')
                          ? FlutterFlowTheme.of(context).error
                          : FlutterFlowTheme.of(context).primaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'SFProText',
                                color: getJsonField(
                                          widget!.data,
                                          r'''$.result.response''',
                                        ) ==
                                        functions.stringToJson('\"defect\"')
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                if (functions
                    .jsonToList(getJsonField(
                      widget!.data,
                      r'''$.data.remark''',
                    ))
                    .containsMap(getJsonField(
                      widget!.data,
                      r'''$.result.response''',
                    ))) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          decoration: BoxDecoration(),
                          child: Text(
                            valueOrDefault<String>(
                              getJsonField(
                                widget!.data,
                                r'''$.result.comment''',
                              )?.toString(),
                              '-',
                            ),
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
                        ),
                        if (getJsonField(
                              widget!.data,
                              r'''$.result.image''',
                            ) !=
                            null)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    MediaViewerWidget.routeName,
                                    queryParameters: {
                                      'data': serializeParam(
                                        getJsonField(
                                          widget!.data,
                                          r'''$.result.image''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Text(
                                  'Фото',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                            ],
                          ),
                      ].divide(SizedBox(height: 5)),
                    ),
                  );
                } else {
                  return Container(
                    width: 100,
                    height: 0,
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
                    width: MediaQuery.sizeOf(context).width,
                    height: 0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                } else {
                  return Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).error,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
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
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ].divide(SizedBox(height: 5)),
        ),
      ),
    );
  }
}
