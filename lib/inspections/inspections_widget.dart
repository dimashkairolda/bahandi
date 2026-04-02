import 'package:Etry/detailed_inspection/detailed_inspection_widget.dart';
import 'package:Etry/detailed_inspection_done/detailed_inspection_done_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'inspections_model.dart';
export 'inspections_model.dart';

class InspectionsWidget extends StatefulWidget {
  const InspectionsWidget({super.key});

  static String routeName = 'Inspections';
  static String routePath = '/inspections';

  @override
  State<InspectionsWidget> createState() => _InspectionsWidgetState();
}

class _InspectionsWidgetState extends State<InspectionsWidget> {
  late InspectionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InspectionsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = getCurrentTimestamp;
      safeSetState(() {});
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

    return FutureBuilder<ApiCallResponse>(
      future: _model
          .inspections(
        requestFn: () => GetReglamentsAPICall.call(
          access: currentAuthenticationToken,
          date: '&date=${_model.date == null ? dateTimeFormat(
              "y-MM-dd",
              getCurrentTimestamp,
              locale: FFLocalizations.of(context).languageCode,
            ) : dateTimeFormat(
              "y-MM-dd",
              _model.date,
              locale: FFLocalizations.of(context).languageCode,
            )},${_model.date == null ? dateTimeFormat(
              "y-MM-dd",
              getCurrentTimestamp,
              locale: FFLocalizations.of(context).languageCode,
            ) : dateTimeFormat(
              "y-MM-dd",
              _model.date,
              locale: FFLocalizations.of(context).languageCode,
            )}',
          page: '50',
        ),
      )
          .then((result) {
        _model.apiRequestCompleted = true;
        return result;
      }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final inspectionsGetReglamentsAPIResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: PopScope(
            canPop: false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                automaticallyImplyLeading: false,
                title: Text(
                  FFLocalizations.of(context).getVariableText(
                    ruText: 'Регламентные работы',
                    kkText: 'Регламенттік жұмыстар',
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'SFProText',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 18,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 1,
              ),
              body: SafeArea(
                top: true,
                child: Visibility(
                  visible: valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) !=
                      '\"labeler\"',
                  child: Stack(
                    alignment: AlignmentDirectional(0, 0),
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            safeSetState(() {
                              _model.clearInspectionsCache();
                              _model.apiRequestCompleted = false;
                            });
                            await _model.waitForApiRequestCompleted();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _model.date = getCurrentTimestamp;
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.clearInspectionsCache();
                                            _model.apiRequestCompleted = false;
                                          });
                                          await _model.waitForApiRequestCompleted(
                                              minWait: 3);
                                        },
                                        text: FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Cегодня',
                                          kkText: 'Бүгін',
                                        ),
                                        options: FFButtonOptions(
                                          height: 40,
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: functions.stringToDateTime(
                                                      dateTimeFormat(
                                                    "y-MM-dd",
                                                    _model.date,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  )) ==
                                                  functions.stringToDateTime(
                                                      dateTimeFormat(
                                                    "y-MM-dd",
                                                    getCurrentTimestamp,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ))
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          textStyle: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'SFProText',
                                                color: functions.stringToDateTime(
                                                            dateTimeFormat(
                                                          "y-MM-dd",
                                                          _model.date,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        )) ==
                                                        functions
                                                            .stringToDateTime(
                                                                dateTimeFormat(
                                                          "y-MM-dd",
                                                          getCurrentTimestamp,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ))
                                                    ? Colors.white
                                                    : FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                              ),
                                          elevation: 0,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          _model.date =
                                              functions.stringToDateTime(
                                                  functions.getTomorrow());
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.clearInspectionsCache();
                                            _model.apiRequestCompleted = false;
                                          });
                                          await _model.waitForApiRequestCompleted(
                                              minWait: 3);
                                        },
                                        text: FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Завтра',
                                          kkText: 'Ертең',
                                        ),
                                        options: FFButtonOptions(
                                          height: 40,
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          color: _model.date ==
                                                  functions.stringToDateTime(
                                                      functions.getTomorrow())
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          textStyle: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'SFProText',
                                                color: _model.date ==
                                                        functions.stringToDateTime(
                                                            functions
                                                                .getTomorrow())
                                                    ? Colors.white
                                                    : FlutterFlowTheme.of(context).primaryText,
                                                fontSize: 14,
                                                letterSpacing: 0.0,
                                              ),
                                          elevation: 0,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          final _datePickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: getCurrentTimestamp,
                                            firstDate: DateTime(1900),
                                            lastDate: getCurrentTimestamp,
                                            builder: (context, child) {
                                              return wrapInMaterialDatePickerTheme(
                                                context,
                                                child!,
                                                headerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                headerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                headerTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.outfit(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 32,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineLarge
                                                                  .fontStyle,
                                                        ),
                                                pickerBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                pickerForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                selectedDateTimeBackgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                selectedDateTimeForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                                actionButtonForegroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                iconSize: 24,
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
                                              _model.datePicked =
                                                  getCurrentTimestamp;
                                            });
                                          }
                                          _model.date = _model.datePicked;
                                          safeSetState(() {});
                                          safeSetState(() {
                                            _model.clearInspectionsCache();
                                            _model.apiRequestCompleted = false;
                                          });
                                          await _model.waitForApiRequestCompleted(
                                              minWait: 3);
                                        },
                                        text: valueOrDefault<String>(
                                          dateTimeFormat(
                                            "dd.MM.y",
                                            _model.date,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Дата',
                                            kkText: 'Күні',
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.calendar_month,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          height: 40,
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          iconColor: (_model.date !=
                                                      functions.stringToDateTime(
                                                          functions
                                                              .getTomorrow())) &&
                                                  (functions.stringToDateTime(
                                                          dateTimeFormat(
                                                        "y-MM-dd",
                                                        _model.date,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )) !=
                                                      functions.stringToDateTime(
                                                          dateTimeFormat(
                                                        "y-MM-dd",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )))
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primary,
                                          color: (_model.date !=
                                                      functions.stringToDateTime(
                                                          functions
                                                              .getTomorrow())) &&
                                                  (functions.stringToDateTime(
                                                          dateTimeFormat(
                                                        "y-MM-dd",
                                                        _model.date,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )) !=
                                                      functions.stringToDateTime(
                                                          dateTimeFormat(
                                                        "y-MM-dd",
                                                        getCurrentTimestamp,
                                                        locale:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .languageCode,
                                                      )))
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    color: (_model.date !=
                                                                functions
                                                                    .stringToDateTime(
                                                                        functions
                                                                            .getTomorrow())) &&
                                                            (functions.stringToDateTime(
                                                                    dateTimeFormat(
                                                                  "y-MM-dd",
                                                                  _model.date,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                )) !=
                                                                functions
                                                                    .stringToDateTime(
                                                                        dateTimeFormat(
                                                                  "y-MM-dd",
                                                                  getCurrentTimestamp,
                                                                  locale: FFLocalizations.of(
                                                                          context)
                                                                      .languageCode,
                                                                )))
                                                        ? Colors.white
                                                        : FlutterFlowTheme.of(context)
                                                            .primaryText,
                                                    fontSize: 14,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 0,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 10)),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      () {
                                        if (functions
                                                .stringToDateTime(dateTimeFormat(
                                              "y-MM-dd",
                                              _model.date,
                                              locale: FFLocalizations.of(context)
                                                  .languageCode,
                                            )) ==
                                            functions
                                                .stringToDateTime(dateTimeFormat(
                                              "y-MM-dd",
                                              getCurrentTimestamp,
                                              locale: FFLocalizations.of(context)
                                                  .languageCode,
                                            ))) {
                                          return FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Сегодня',
                                            kkText: 'Бүгін',
                                          );
                                        } else if (_model.date ==
                                            functions.stringToDateTime(
                                                functions.getTomorrow())) {
                                          return FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Завтра',
                                            kkText: 'Ертең',
                                          );
                                        } else {
                                          return dateTimeFormat(
                                            "d MMMM",
                                            _model.date,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          );
                                        }
                                      }(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 18,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                    ),
                                    Text(
                                      'Количество работ : ${((valueOrDefault<String>(
                                            functions
                                                .jsonToStringCopy(getJsonField(
                                              FFAppState().account,
                                              r'''$.role''',
                                            )),
                                            '-',
                                          ) == '\"engineer\"') || (valueOrDefault<String>(
                                            functions
                                                .jsonToStringCopy(getJsonField(
                                              FFAppState().account,
                                              r'''$.role''',
                                            )),
                                            '-',
                                          ) == '\"admin\"') ? functions.filterFinishedReglament(inspectionsGetReglamentsAPIResponse.jsonBody) : getJsonField(
                                          inspectionsGetReglamentsAPIResponse
                                              .jsonBody,
                                          r'''$.data''',
                                          true,
                                        ))?.length?.toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                                Builder(
                                  builder: (context) {
                                    final inspections = ((valueOrDefault<String>(
                                                          functions
                                                              .jsonToStringCopy(
                                                                  getJsonField(
                                                            FFAppState().account,
                                                            r'''$.role''',
                                                          )),
                                                          '-',
                                                        ) ==
                                                        '\"engineer\"') ||
                                                    (valueOrDefault<String>(
                                                          functions
                                                              .jsonToStringCopy(
                                                                  getJsonField(
                                                            FFAppState().account,
                                                            r'''$.role''',
                                                          )),
                                                          '-',
                                                        ) ==
                                                        '\"admin\"')
                                                ? functions.filterFinishedReglament(
                                                    inspectionsGetReglamentsAPIResponse
                                                        .jsonBody)
                                                : getJsonField(
                                                    inspectionsGetReglamentsAPIResponse
                                                        .jsonBody,
                                                    r'''$.data''',
                                                    true,
                                                  ))
                                            ?.toList() ??
                                        [];
                  
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(inspections.length,
                                                (inspectionsIndex) {
                                          final inspectionsItem =
                                              inspections[inspectionsIndex];
                                          return Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () async {
                                                if (getJsonField(
                                                      inspectionsItem,
                                                      r'''$.finished_on''',
                                                    ) ==
                                                    null) {
                                                  var confirmDialogResponse =
                                                      await showDialog<bool>(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    FFLocalizations.of(context).getVariableText(
                                                                      ruText: 'Подтвердите действие',
                                                                      kkText: 'Әрекетті растаңыз',
                                                                    )),
                                                                content: Text(
                                                                    FFLocalizations.of(context).getVariableText(
                                                                      ruText: 'Вы уверены что хотите начать регламент?',
                                                                      kkText: 'Регламентті бастағыңыз келетініне сенімдісіз бе?',
                                                                    )),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: Text(
                                                                        FFLocalizations.of(context).getVariableText(
                                                                          ruText: 'Отмена',
                                                                          kkText: 'Бас тарту',
                                                                        )),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: Text(
                                                                        FFLocalizations.of(context).getVariableText(
                                                                          ruText: 'Начать',
                                                                          kkText: 'Бастау',
                                                                        )),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ) ??
                                                          false;
                                                  if (confirmDialogResponse) {
                                                    _model.isloading = true;
                                                    safeSetState(() {});
                                                    _model.qww123 =
                                                        await GetInspectionsByIdCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: getJsonField(
                                                        inspectionsItem,
                                                        r'''$.id''',
                                                      ).toString(),
                                                    );
                  
                                                    FFAppState().checkCache =
                                                        (_model.qww123
                                                                ?.jsonBody ??
                                                            '');
                                                    safeSetState(() {});
                                                    _model.apiResultfn1 =
                                                        await StartInspectionCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: getJsonField(
                                                        inspectionsItem,
                                                        r'''$.id''',
                                                      ),
                                                    );
                  
                                                    _model.isloading = false;
                                                    safeSetState(() {});
                                                    if (functions
                                                            .checkInspectionStatus(
                                                                getJsonField(
                                                                  inspectionsItem,
                                                                  r'''$.available_from''',
                                                                ).toString(),
                                                                getJsonField(
                                                                  inspectionsItem,
                                                                  r'''$.available_to''',
                                                                ).toString()) !=
                                                        'Запланировано') {
                                                      context.pushNamed(
                                                        DetailedInspectionWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'name': serializeParam(
                                                            inspectionsItem,
                                                            ParamType.JSON,
                                                          ),
                                                          'index': serializeParam(
                                                            inspectionsIndex,
                                                            ParamType.int,
                                                          ),
                                                          'json': serializeParam(
                                                            FFAppState()
                                                                .checkCache,
                                                            ParamType.JSON,
                                                          ),
                                                          'nextIndex':
                                                              serializeParam(
                                                            0,
                                                            ParamType.int,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            FFLocalizations.of(context)
                                                                .getVariableText(
                                                              ruText:
                                                                  'Недоступно',
                                                              kkText:
                                                                  'Қолжетімсіз',
                                                            ),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'SFProText',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds: 2000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                        ),
                                                      );
                                                    }
                                                  }
                                                } else {
                                                  _model.isloading = true;
                                                  safeSetState(() {});
                                                  _model.qww12 =
                                                      await GetInspectionsByIdCall
                                                          .call(
                                                    access:
                                                        currentAuthenticationToken,
                                                    id: getJsonField(
                                                      inspectionsItem,
                                                      r'''$.id''',
                                                    ).toString(),
                                                  );
                  
                                                  FFAppState().checkCache =
                                                      (_model.qww12?.jsonBody ??
                                                          '');
                                                  safeSetState(() {});
                                                  _model.isloading = false;
                                                  safeSetState(() {});
                  
                                                  context.pushNamed(
                                                    DetailedInspectionDoneWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'name': serializeParam(
                                                        inspectionsItem,
                                                        ParamType.JSON,
                                                      ),
                                                      'index': serializeParam(
                                                        inspectionsIndex,
                                                        ParamType.int,
                                                      ),
                                                      'json': serializeParam(
                                                        FFAppState().checkCache,
                                                        ParamType.JSON,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                }
                  
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                width: MediaQuery.sizeOf(context)
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.01,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.17,
                                                      decoration: BoxDecoration(
                                                        color: () {
                                                          if ((functions.checkInspectionStatus(
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_from''',
                                                                      ).toString(),
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_to''',
                                                                      ).toString()) ==
                                                                  'Просрочено') &&
                                                              (getJsonField(
                                                                    inspectionsItem,
                                                                    r'''$.finished_on''',
                                                                  ) ==
                                                                  null)) {
                                                            return Color(
                                                                0xFFF27E84);
                                                          } else if ((functions.checkInspectionStatus(
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_from''',
                                                                      ).toString(),
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_to''',
                                                                      ).toString()) ==
                                                                  'Текущее') &&
                                                              (getJsonField(
                                                                    inspectionsItem,
                                                                    r'''$.finished_on''',
                                                                  ) ==
                                                                  null)) {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .warning;
                                                          } else if ((functions.checkInspectionStatus(
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_from''',
                                                                      ).toString(),
                                                                      getJsonField(
                                                                        inspectionsItem,
                                                                        r'''$.available_to''',
                                                                      ).toString()) ==
                                                                  'Запланировано') &&
                                                              (getJsonField(
                                                                    inspectionsItem,
                                                                    r'''$.finished_on''',
                                                                  ) ==
                                                                  null)) {
                                                            return Color(
                                                                0xFF95B0F6);
                                                          } else {
                                                            return Color(
                                                                0xFFA0F9CC);
                                                          }
                                                        }(),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(10),
                                                          bottomRight:
                                                              Radius.circular(0),
                                                          topLeft:
                                                              Radius.circular(10),
                                                          topRight:
                                                              Radius.circular(0),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      10),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                elevation: 2,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.15,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.07,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: () {
                                                                      if ((functions.checkInspectionStatus(
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_from''',
                                                                                  ).toString(),
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_to''',
                                                                                  ).toString()) ==
                                                                              'Просрочено') &&
                                                                          (getJsonField(
                                                                                inspectionsItem,
                                                                                r'''$.finished_on''',
                                                                              ) ==
                                                                              null)) {
                                                                        return Color(
                                                                            0xFFF27E84);
                                                                      } else if ((functions.checkInspectionStatus(
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_from''',
                                                                                  ).toString(),
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_to''',
                                                                                  ).toString()) ==
                                                                              'Текущее') &&
                                                                          (getJsonField(
                                                                                inspectionsItem,
                                                                                r'''$.finished_on''',
                                                                              ) ==
                                                                              null)) {
                                                                        return FlutterFlowTheme.of(
                                                                                context)
                                                                            .warning;
                                                                      } else if ((functions.checkInspectionStatus(
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_from''',
                                                                                  ).toString(),
                                                                                  getJsonField(
                                                                                    inspectionsItem,
                                                                                    r'''$.available_to''',
                                                                                  ).toString()) ==
                                                                              'Запланировано') &&
                                                                          (getJsonField(
                                                                                inspectionsItem,
                                                                                r'''$.finished_on''',
                                                                              ) ==
                                                                              null)) {
                                                                        return Color(
                                                                            0xFF95B0F6);
                                                                      } else {
                                                                        return Color(
                                                                            0xFFA0F9CC);
                                                                      }
                                                                    }(),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .access_time_sharp,
                                                                        color: Colors
                                                                            .black,
                                                                        size: 22,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            AlignmentDirectional(
                                                                                0,
                                                                                0),
                                                                        child:
                                                                            Text(
                                                                          dateTimeFormat(
                                                                            "HH:mm",
                                                                            functions
                                                                                .stringToDateTime(getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.available_from''',
                                                                            ).toString()),
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FontWeight.w300,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w300,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            if (getJsonField(
                                                                  inspectionsItem,
                                                                  r'''$.finished_on''',
                                                                ) !=
                                                                null)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            62,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                child: Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.04,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.04,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border
                                                                        .all(
                                                                      color: Color(
                                                                          0xFF3DE690),
                                                                      width: 2,
                                                                    ),
                                                                  ),
                                                                  child: Icon(
                                                                    Icons
                                                                        .check_sharp,
                                                                    color: Color(
                                                                        0xFF3DE690),
                                                                    size: 10,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0, 10,
                                                                      0, 10),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery
                                                                            .sizeOf(
                                                                                context)
                                                                        .width *
                                                                    0.7,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  getJsonField(
                                                                    inspectionsItem,
                                                                    r'''$.regulation_info.title''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            16,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                ),
                                                              ),
                                                              Builder(
                              builder: (context) {
                                if (functions
                        .listlength(getJsonField(
                          inspectionsItem,
                          r'''$.schedule_info.regulation_info.equipments_info''',
                          true,
                        )!)
                        .toString() ==
                    '0') {
                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                                } else if (functions.listlength(getJsonField(
                      inspectionsItem,
                      r'''$.schedule_info.regulation_info.equipments_info[:].title''',
                      true,
                    )!) ==
                    1) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: BoxDecoration(),
                    child: Text(
                      getJsonField(
                        inspectionsItem,
                        r'''$.schedule_info.regulation_info.equipments_info[0].title''',
                      ).toString(),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'SFProText',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  );
                                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                                }
                              },
                            ),
                                                              Container(
                                                                width: MediaQuery
                                                                            .sizeOf(
                                                                                context)
                                                                        .width *
                                                                    0.35,
                                                                height: MediaQuery
                                                                            .sizeOf(
                                                                                context)
                                                                        .height *
                                                                    0.025,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: () {
                                                                    if ((functions.checkInspectionStatus(
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_from''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_to''',
                                                                                ).toString()) ==
                                                                            'Просрочено') &&
                                                                        (getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.finished_on''',
                                                                            ) ==
                                                                            null)) {
                                                                      return Color(
                                                                          0xFFF27E84);
                                                                    } else if ((functions.checkInspectionStatus(
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_from''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_to''',
                                                                                ).toString()) ==
                                                                            'Текущее') &&
                                                                        (getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.finished_on''',
                                                                            ) ==
                                                                            null)) {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning;
                                                                    } else if ((functions.checkInspectionStatus(
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_from''',
                                                                                ).toString(),
                                                                                getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.available_to''',
                                                                                ).toString()) ==
                                                                            'Запланировано') &&
                                                                        (getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.finished_on''',
                                                                            ) ==
                                                                            null)) {
                                                                      return Color(
                                                                          0xFF95B0F6);
                                                                    } else {
                                                                      return Color(
                                                                          0xFFA0F9CC);
                                                                    }
                                                                  }(),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child: Text(
                                                                    getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.finished_on''',
                                                                            ) !=
                                                                            null
                                                                        ? FFLocalizations.of(context).getVariableText(
                                                                            ruText: 'Выполнено',
                                                                            kkText: 'Орындалды',
                                                                          )
                                                                        : functions.checkInspectionStatus(
                                                                            getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.available_from''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              inspectionsItem,
                                                                              r'''$.available_to''',
                                                                            ).toString()),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color: FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Builder(
                              builder: (context) {
                                if (functions
                        .listlength(getJsonField(
                          inspectionsItem,
                          r'''$.schedule_info.regulation_info.equipments_info''',
                          true,
                        )!)
                        .toString() !=
                    '0') {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20,
                      ),
                      Text(
                        valueOrDefault<String>(
                          getJsonField(
                            functions.findJsonByID(
                                getJsonField(
                                  inspectionsItem,
                                  r'''$.schedule_info.regulation_info.equipments_info[0].area''',
                                ),
                                functions
                                    .jsonToList(getJsonField(
                                      FFAppState().Area,
                                      r'''$.data''',
                                    ))
                                    .toList()),
                            r'''$.title''',
                          )?.toString(),
                          '-',
                        ),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'SFProText',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 13,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ].divide(SizedBox(width: 5)),
                  );
                                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  );
                                }
                              },
                            ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child: Container(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.03,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                10),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .account_circle_outlined,
                                                                        color: FlutterFlowTheme.of(
                                                                                context)
                                                                            .primaryText,
                                                                        size: 20,
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            AlignmentDirectional(
                                                                                0,
                                                                                0),
                                                                        child:
                                                                            RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.author_info.first_name''',
                                                                                ).toString(),
                                                                                style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      fontSize: 12,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(),
                                                                              ),
                                                                              TextSpan(
                                                                                text: getJsonField(
                                                                                  inspectionsItem,
                                                                                  r'''$.author_info.last_name''',
                                                                                ).toString(),
                                                                                style: TextStyle(),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context)
                                                                                .headlineSmall
                                                                                .override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 12,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]
                                                                        .divide(SizedBox(
                                                                            width:
                                                                                5))
                                                                        .addToStart(SizedBox(
                                                                            width:
                                                                                5))
                                                                        .addToEnd(SizedBox(
                                                                            width:
                                                                                5)),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery
                                                                            .sizeOf(
                                                                                context)
                                                                        .width *
                                                                    0.7,
                                                                decoration:
                                                                    BoxDecoration(),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 3)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }).divide(SizedBox(height: 10)),
                                      ),
                                    );
                                  },
                                ),
                              ].divide(SizedBox(height: 10)),
                            ),
                          ),
                        ),
                      ),
                      if (_model.isloading)
                    Align( // Используем Align или Center, чтобы индикатор был посередине
                      alignment: Alignment.center,
                      child: Container(
                        // Делаем квадратный контейнер
                        width: 150.0, 
                        height: 150.0,
                        decoration: BoxDecoration(
                          // Цвет фона берем из темы (чтобы работало и в темной теме)
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(24.0),
                          boxShadow: [
                            // Красивая мягкая тень
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 20.0,
                              spreadRadius: 2.0,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Вращающийся круг
                            SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary, // Основной цвет приложения
                                ),
                                backgroundColor: FlutterFlowTheme.of(context).alternate, // Цвет трека
                                strokeWidth: 4.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            // Текст загрузки
                            Text(
                              FFLocalizations.of(context).getVariableText(
                                ruText: 'Загрузка...',
                                kkText: 'Жүктелуде...',
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'SFProText', // Твой шрифт
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.w600,
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
        );
      },
    );
  }
}
