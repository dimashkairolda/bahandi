import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'photo_or_video_model.dart';
export 'photo_or_video_model.dart';

class PhotoOrVideoWidget extends StatefulWidget {
  const PhotoOrVideoWidget({super.key});

  @override
  State<PhotoOrVideoWidget> createState() => _PhotoOrVideoWidgetState();
}

class _PhotoOrVideoWidgetState extends State<PhotoOrVideoWidget> {
  late PhotoOrVideoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhotoOrVideoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      // --- НАЧАЛО ИСПРАВЛЕННОГО КОДА ФОТО ---
                      try {
                        // 1. ВКЛЮЧАЕМ ИНДИКАТОР
                        safeSetState(() {
                          _model.isLoading = true;
                        });

                        // --- 2. Выбор фото ---
                        final selectedMedia = await selectMedia(
                          maxWidth: 1000.00,
                          maxHeight: 1300.00,
                          imageQuality: 71,
                          multiImage: false,
                        );

                        if (!mounted) return;
                        if (selectedMedia == null || selectedMedia.isEmpty) {
                          return; // Выход, если отмена
                        }

                        // --- 3. Обработка файла ---
                        FFUploadedFile? fileToUpload;
                        if (selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                          try {
                            final selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();
                            if (selectedUploadedFiles.length ==
                                selectedMedia.length) {
                              fileToUpload = selectedUploadedFiles.first;
                            }
                          } catch (e) {
                            print('Ошибка обработки файла: $e');
                          }
                        }

                        if (fileToUpload == null) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      ruText:
                                          'Не удалось обработать файл. Попробуйте еще раз.',
                                      kkText:
                                          'Файлды өңдеу мүмкін болмады. Қайта көріңіз.',
                                    )),
                              ),
                            );
                          }
                          return;
                        }
                        if (fileToUpload.bytes == null ||
                            fileToUpload.bytes!.isEmpty) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Файл пустой. Выберите другое фото.',
                                    kkText:
                                        'Файл бос. Басқа фото таңдаңыз.',
                                  ),
                                ),
                              ),
                            );
                          }
                          return;
                        }

                        // --- 4. Загрузка файла ---
                        _model.tet = await PostFilesCall.call(
                          access: currentAuthenticationToken,
                          content: fileToUpload,
                        );

                        if (!mounted) return;

                        // --- 5. Обработка результата ---
                        if (_model.tet != null && _model.tet!.succeeded) {
                          final body = _model.tet!.jsonBody;
                          final firstItem = getJsonField(body, r'$[0]');
                          final url = getJsonField(firstItem, r'$.url')
                                  ?.toString() ??
                              '';
                          if (firstItem != null && url.isNotEmpty) {
                            FFAppState().addToPhotos(firstItem);
                            FFAppState().update(() {});
                          }
                        } else {
                          // API вызов НЕУДАЧНЫЙ
                          print('Ошибка API: ${_model.tet?.statusCode}');
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      ruText:
                                          'Ошибка загрузки. Попробуйте еще раз.',
                                      kkText:
                                          'Жүктеу қатесі. Қайта көріңіз.',
                                    )),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        print('Глобальная ошибка в onTap Фото: $e');
                      } finally {
                        if (mounted) {
                          safeSetState(() {
                            _model.isLoading = false;
                          });
                        }
                      }
                      // --- КОНЕЦ ИСПРАВЛЕННОГО КОДА ФОТО ---
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Icon(
                                        Icons.photo_camera,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Фото',
                                            kkText: 'Фото',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 16),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      // --- НАЧАЛО ИСПРАВЛЕННОГО КОДА ВИДЕО ---
                      try {
                        await requestPermission(cameraPermission);
                        await requestPermission(microphonePermission);

                        // 1. ВКЛЮЧАЕМ ИНДИКАТОР
                        safeSetState(() {
                          _model.isLoading = true;
                        });

                        // --- 2. Съемка видео ---
                        _model.rer = await actions.pickCameraVideo();

                        if (!mounted) return;
                        if (_model.rer?.bytes == null ||
                            _model.rer!.bytes!.isEmpty) {
                          return; // Выход, если отмена
                        }

                        // --- 3. Загрузка файла ---
                        _model.asas = await PostFilesCall.call(
                          access: currentAuthenticationToken,
                          content: _model.rer,
                        );

                        if (!mounted) return;

                        // --- 4. Обработка результата ---
                        if (_model.asas != null && _model.asas!.succeeded) {
                          final body = _model.asas!.jsonBody;
                          final firstItem = getJsonField(body, r'$[0]');
                          final url = getJsonField(firstItem, r'$.url')
                                  ?.toString() ??
                              '';
                          if (firstItem != null && url.isNotEmpty) {
                            FFAppState().addToPhotos(firstItem);
                            FFAppState().update(() {});
                          }
                        } else {
                          // API вызов НЕУДАЧНЫЙ
                          print('Ошибка API: ${_model.asas?.statusCode}');
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    FFLocalizations.of(context)
                                        .getVariableText(
                                      ruText:
                                          'Ошибка загрузки видео. Попробуйте еще раз.',
                                      kkText:
                                          'Бейнені жүктеу қатесі. Қайта көріңіз.',
                                    )),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        print('Глобальная ошибка в onTap Видео: $e');
                      } finally {
                        if (mounted) {
                          safeSetState(() {
                            _model.isLoading = false;
                          });
                        }
                      }
                      // --- КОНЕЦ ИСПРАВЛЕННОГО КОДА ВИДЕО ---
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: FaIcon(
                                        FontAwesomeIcons.video,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Видео',
                                            kkText: 'Видео',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // --- VVV НАЧАЛО ИЗМЕНЕНИЙ VVV ---
            if (_model.isLoading)
              // GestureDetector поглощает все нажатия, не давая окну закрыться
              GestureDetector(
                onTap: () {}, // Пустой onTap "съедает" нажатие
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  // Полупрозрачный фон
                  color: Color(0x8A000000),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getVariableText(
                              ruText: 'Идет загрузка...',
                              kkText: 'Жүктелуде...',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // --- ^^^ КОНЕЦ ИЗМЕНЕНИЙ ^^^ ---
          ],
        ));
  }
}