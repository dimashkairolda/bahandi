import 'package:Etry/media_viewer/media_viewer_widget.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'checkboxes_show_model.dart';
export 'checkboxes_show_model.dart';

class CheckboxesShowWidget extends StatefulWidget {
  const CheckboxesShowWidget({
    super.key,
    required this.data,
    required this.index,
  });

  final dynamic data;
  final int? index;

  @override
  State<CheckboxesShowWidget> createState() => _CheckboxesShowWidgetState();
}

class _CheckboxesShowWidgetState extends State<CheckboxesShowWidget> {
  late CheckboxesShowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckboxesShowModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11, 11, 10, 0),
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
                      fontSize: 14,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Builder(
                builder: (context) {
                  final radios = (getJsonField(
                        widget!.data,
                        r'''$.data.checkboxes''',
                        true,
                      )
                              ?.toList()
                              .map<CheckboxesStruct?>(
                                  CheckboxesStruct.maybeFromMap)
                              .toList() as Iterable<CheckboxesStruct?>)
                          .withoutNulls
                          ?.toList() ??
                      [];

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(radios.length, (radiosIndex) {
                      final radiosItem = radios[radiosIndex];
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: valueOrDefault<Color>(
                                radiosItem.result.response == true
                                    ? FlutterFlowTheme.of(context)
                                        .primaryBackground
                                    : FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 0.3,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 7, 0, 7),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (radiosItem.result.response == true)
                                    Icon(
                                      Icons.check_box,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18,
                                    ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      radiosItem.text,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(width: 10))
                                    .addToStart(SizedBox(width: 15)),
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (radiosItem.result.response != null) {
                                return Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (radiosItem.result.image != null &&
                                          radiosItem.result.image != '')
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  MediaViewerWidget.routeName,
                                                  queryParameters: {
                                                    'data': serializeParam(
                                                      radiosItem.result.image,
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Text(
                                                'Фото',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ]
                                        .divide(SizedBox(height: 5))
                                        .addToStart(SizedBox(height: 10))
                                        .addToEnd(SizedBox(height: 10)),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 100,
                                  height: 0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }).divide(SizedBox(height: 5)),
                  );
                },
              ),
            ].divide(SizedBox(height: 10)),
          ),
        ),
      ),
    );
  }
}
