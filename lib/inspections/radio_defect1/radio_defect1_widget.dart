import 'package:Etry/media_viewer/media_viewer_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'radio_defect1_model.dart';
export 'radio_defect1_model.dart';

class RadioDefect1Widget extends StatefulWidget {
  const RadioDefect1Widget({
    super.key,
    required this.data,
    required this.index,
    required this.name,
    required this.equipmentId,
    required this.searchID,
  });

  final dynamic data;
  final int? index;
  final dynamic name;
  final int? equipmentId;
  final int? searchID;

  @override
  State<RadioDefect1Widget> createState() => _RadioDefect1WidgetState();
}

class _RadioDefect1WidgetState extends State<RadioDefect1Widget> {
  late RadioDefect1Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RadioDefect1Model());

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

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          HapticFeedback.vibrate();
                          if (_model.isTrue == 1) {
                            _model.isTrue = 0;
                            safeSetState(() {});
                            await actions.updateResponseById(
                              FFAppState().checkCache,
                              widget!.equipmentId!,
                              getJsonField(
                                widget!.data,
                                r'''$.data.title''',
                              ).toString(),
                              null,
                            );
                          } else {
                            _model.isTrue = 1;
                            safeSetState(() {});
                            await actions.updateResponseById(
                              FFAppState().checkCache,
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
                        icon: Icon(
                          Icons.check,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.42,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconColor:
                              _model.isTrue == 1 ? Colors.white : Colors.black,
                          color: _model.isTrue == 1
                              ? Color(0xFF2A61ED)
                              : FlutterFlowTheme.of(context).primaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'SFProText',
                                    color: _model.isTrue == 1
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
                        onPressed: () async {
                          HapticFeedback.vibrate();
                          if (_model.isTrue == 2) {
                            _model.isTrue = 0;
                            safeSetState(() {});
                            await actions.updateResponseById(
                              FFAppState().checkCache,
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
                              widget!.equipmentId!,
                              getJsonField(
                                widget!.data,
                                r'''$.data.title''',
                              ).toString(),
                              'defect',
                            );
                          }
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
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          iconColor:
                              _model.isTrue == 2 ? Colors.white : Colors.black,
                          color: _model.isTrue == 2
                              ? FlutterFlowTheme.of(context).error
                              : FlutterFlowTheme.of(context).primaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'SFProText',
                                    color: _model.isTrue == 2
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
              ),
            ),
            Builder(
              builder: (context) {
                if (((_model.isTrue == 1) &&
                        functions
                            .jsonToList(getJsonField(
                              widget!.data,
                              r'''$.data.remark''',
                            ))
                            .containsMap(
                                functions.stringToJson('\"normal\"'))) ||
                    ((_model.isTrue == 2) &&
                        functions
                            .jsonToList(getJsonField(
                              widget!.data,
                              r'''$.data.remark''',
                            ))
                            .containsMap(
                                functions.stringToJson('\"defect\"')))) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.13,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                () async {
                                  await actions.updateResponseByIdComment(
                                    FFAppState().checkCache,
                                    widget!.equipmentId!,
                                    getJsonField(
                                      widget!.data,
                                      r'''$.data.title''',
                                    ).toString(),
                                    _model.textController.text,
                                  );
                                },
                              ),
                              autofocus: false,
                              enabled: true,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
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
                                hintText: 'Введите комментарий',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                suffixIcon:
                                    _model.textController!.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () async {
                                              _model.textController?.clear();
                                              await actions
                                                  .updateResponseByIdComment(
                                                FFAppState().checkCache,
                                                widget!.equipmentId!,
                                                getJsonField(
                                                  widget!.data,
                                                  r'''$.data.title''',
                                                ).toString(),
                                                _model.textController.text,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.clear,
                                              size: 22,
                                            ),
                                          )
                                        : null,
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
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              enableInteractiveSelection: true,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        if (functions.getResponseByIdRadioImage(
                                    FFAppState().checkCache,
                                    widget!.equipmentId!,
                                    getJsonField(
                                      widget!.data,
                                      r'''$.data.title''',
                                    ).toString()) !=
                                null &&
                            functions.getResponseByIdRadioImage(
                                    FFAppState().checkCache,
                                    widget!.equipmentId!,
                                    getJsonField(
                                      widget!.data,
                                      r'''$.data.title''',
                                    ).toString()) !=
                                '')
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
                                        functions.getResponseByIdRadioImage(
                                            FFAppState().checkCache,
                                            widget!.equipmentId!,
                                            getJsonField(
                                              widget!.data,
                                              r'''$.data.title''',
                                            ).toString()),
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
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await actions.updateResponseByIdImage(
                                    FFAppState().checkCache,
                                    widget!.equipmentId!,
                                    getJsonField(
                                      widget!.data,
                                      r'''$.data.title''',
                                    ).toString(),
                                    null,
                                  );
                                  safeSetState(() {});
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        if (FFAppState()
                                    .formresult1
                                    .elementAtOrNull(widget!.index!)
                                    ?.result
                                    ?.image ==
                                null ||
                            FFAppState()
                                    .formresult1
                                    .elementAtOrNull(widget!.index!)
                                    ?.result
                                    ?.image ==
                                '')
                          FFButtonWidget(
                            onPressed: () async {
                              safeSetState(() {
                                _model.isDataUploading_uploadDataDnd = false;
                                _model.uploadedLocalFile_uploadDataDnd =
                                    FFUploadedFile(
                                        bytes: Uint8List.fromList([]),
                                        originalFilename: '');
                              });

                              final selectedMedia = await selectMedia(
                                multiImage: false,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(() => _model
                                    .isDataUploading_uploadDataDnd = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                            originalFilename:
                                                m.originalFilename,
                                          ))
                                      .toList();
                                } finally {
                                  _model.isDataUploading_uploadDataDnd = false;
                                }
                                if (selectedUploadedFiles.length ==
                                    selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadDataDnd =
                                        selectedUploadedFiles.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }

                              _model.uuu = await PostFilesCall.call(
                                access: currentAuthenticationToken,
                                content: _model.uploadedLocalFile_uploadDataDnd,
                              );

                              if ((_model.uuu?.succeeded ?? true)) {
                                await actions.updateResponseByIdImage(
                                  FFAppState().checkCache,
                                  widget!.equipmentId!,
                                  getJsonField(
                                    widget!.data,
                                    r'''$.data.title''',
                                  ).toString(),
                                  getJsonField(
                                    (_model.uuu?.jsonBody ?? ''),
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
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.04,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
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
          ].divide(SizedBox(height: 5)),
        ),
      ),
    );
  }
}
