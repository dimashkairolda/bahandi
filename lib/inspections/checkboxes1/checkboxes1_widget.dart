import 'package:Etry/media_viewer/media_viewer_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'checkboxes1_model.dart';
export 'checkboxes1_model.dart';

class Checkboxes1Widget extends StatefulWidget {
  const Checkboxes1Widget({
    super.key,
    required this.data,
    required this.index,
    required this.searchID,
    required this.equipmentId,
    required this.name,
    required this.nextIndex,
  });

  final dynamic data;
  final int? index;
  final int? searchID;
  final int? equipmentId;
  final dynamic name;
  final int? nextIndex;

  @override
  State<Checkboxes1Widget> createState() => _Checkboxes1WidgetState();
}

class _Checkboxes1WidgetState extends State<Checkboxes1Widget> {
  late Checkboxes1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Checkboxes1Model());
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
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!_model.redios.contains(radiosItem.text)) {
                                await actions.updateResponseByIdCheckbox(
                                  FFAppState().checkCache,
                                  widget!.equipmentId!,
                                  getJsonField(
                                    widget!.data,
                                    r'''$.data.title''',
                                  ).toString(),
                                  radiosItem.text,
                                  true,
                                );
                                _model.addToRedios(radiosItem.text);
                                safeSetState(() {});
                              } else {
                                await actions.updateResponseByIdCheckbox(
                                  FFAppState().checkCache,
                                  widget!.equipmentId!,
                                  getJsonField(
                                    widget!.data,
                                    r'''$.data.title''',
                                  ).toString(),
                                  radiosItem.text,
                                  false,
                                );
                                _model.removeFromRedios(radiosItem.text);
                                safeSetState(() {});
                              }
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              decoration: BoxDecoration(
                                color: valueOrDefault<Color>(
                                  _model.redios.contains(radiosItem.text)
                                      ? FlutterFlowTheme.of(context)
                                          .primaryBackground
                                      : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  width: 0.3,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 7, 0, 7),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (_model.redios.contains(radiosItem.text))
                                      Icon(
                                        Icons.check_box,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 18,
                                      ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.65,
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
                                    if ((_model.redios
                                                .contains(radiosItem.text) &&
                                            functions
                                                .jsonToList(getJsonField(
                                                  widget!.data,
                                                  r'''$.data.remark''',
                                                ))
                                                .containsMap(
                                                    functions.stringToJson(
                                                        '\"checked\"'))) ||
                                        (!_model.redios
                                                .contains(radiosItem.text) &&
                                            functions
                                                .jsonToList(getJsonField(
                                                  widget!.data,
                                                  r'''$.data.remark''',
                                                ))
                                                .containsMap(
                                                    functions.stringToJson(
                                                        '\"unchecked\"'))))
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24,
                                      ),
                                  ]
                                      .divide(SizedBox(width: 10))
                                      .addToStart(SizedBox(width: 10)),
                                ),
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if ((_model.redios.contains(radiosItem.text) &&
                                      functions
                                          .jsonToList(getJsonField(
                                            widget!.data,
                                            r'''$.data.remark''',
                                          ))
                                          .containsMap(functions
                                              .stringToJson('\"checked\"'))) ||
                                  (!_model.redios.contains(radiosItem.text) &&
                                      functions
                                          .jsonToList(getJsonField(
                                            widget!.data,
                                            r'''$.data.remark''',
                                          ))
                                          .containsMap(functions.stringToJson(
                                              '\"unchecked\"')))) {
                                return Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (functions
                                                  .getResponseByIdCheckboxImage(
                                                      FFAppState().checkCache,
                                                      widget!.equipmentId!,
                                                      getJsonField(
                                                        widget!.data,
                                                        r'''$.data.title''',
                                                      ).toString(),
                                                      radiosItem.text) !=
                                              null &&
                                          functions
                                                  .getResponseByIdCheckboxImage(
                                                      FFAppState().checkCache,
                                                      widget!.equipmentId!,
                                                      getJsonField(
                                                        widget!.data,
                                                        r'''$.data.title''',
                                                      ).toString(),
                                                      radiosItem.text) !=
                                              '')
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
                                                      functions
                                                          .getResponseByIdCheckboxImage(
                                                              FFAppState()
                                                                  .checkCache,
                                                              widget!
                                                                  .equipmentId!,
                                                              getJsonField(
                                                                widget!.data,
                                                                r'''$.data.title''',
                                                              ).toString(),
                                                              radiosItem.text),
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
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await actions
                                                    .updateResponseByIdCheckboxImage(
                                                  FFAppState().checkCache,
                                                  widget!.equipmentId!,
                                                  getJsonField(
                                                    widget!.data,
                                                    r'''$.data.title''',
                                                  ).toString(),
                                                  radiosItem.text,
                                                  null,
                                                );
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (FFAppState()
                                                  .formresult1
                                                  .elementAtOrNull(
                                                      widget!.index!)
                                                  ?.result
                                                  ?.image ==
                                              null ||
                                          FFAppState()
                                                  .formresult1
                                                  .elementAtOrNull(
                                                      widget!.index!)
                                                  ?.result
                                                  ?.image ==
                                              '')
                                        FFButtonWidget(
                                          onPressed: () async {
                                            safeSetState(() {
                                              _model.isDataUploading_uploadDataDnd1 =
                                                  false;
                                              _model.uploadedLocalFile_uploadDataDnd1 =
                                                  FFUploadedFile(
                                                      bytes: Uint8List.fromList(
                                                          []),
                                                      originalFilename: '');
                                            });

                                            final selectedMedia =
                                                await selectMedia(
                                              multiImage: false,
                                            );
                                            if (selectedMedia != null &&
                                                selectedMedia.every((m) =>
                                                    validateFileFormat(
                                                        m.storagePath,
                                                        context))) {
                                              safeSetState(() => _model
                                                      .isDataUploading_uploadDataDnd1 =
                                                  true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              try {
                                                selectedUploadedFiles =
                                                    selectedMedia
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                              originalFilename:
                                                                  m.originalFilename,
                                                            ))
                                                        .toList();
                                              } finally {
                                                _model.isDataUploading_uploadDataDnd1 =
                                                    false;
                                              }
                                              if (selectedUploadedFiles
                                                      .length ==
                                                  selectedMedia.length) {
                                                safeSetState(() {
                                                  _model.uploadedLocalFile_uploadDataDnd1 =
                                                      selectedUploadedFiles
                                                          .first;
                                                });
                                              } else {
                                                safeSetState(() {});
                                                return;
                                              }
                                            }

                                            _model.uuu123 =
                                                await PostFilesCall.call(
                                              access:
                                                  currentAuthenticationToken,
                                              content: _model
                                                  .uploadedLocalFile_uploadDataDnd1,
                                            );

                                            if ((_model.uuu123?.succeeded ??
                                                true)) {
                                              await actions
                                                  .updateResponseByIdCheckboxImage(
                                                FFAppState().checkCache,
                                                widget!.equipmentId!,
                                                getJsonField(
                                                  widget!.data,
                                                  r'''$.data.title''',
                                                ).toString(),
                                                radiosItem.text,
                                                getJsonField(
                                                  (_model.uuu123?.jsonBody ??
                                                      ''),
                                                  r'''$[0].url''',
                                                ).toString(),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Фото',
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.04,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 0, 16, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 0,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
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
