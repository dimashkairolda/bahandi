import 'package:Bahandi/api/firebase_api.dart';


import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'defects_model.dart';
export 'defects_model.dart';

class DefectsWidget extends StatefulWidget {
  const DefectsWidget({super.key});

  static String routeName = 'Defects';
  static String routePath = '/defects';

  @override
  State<DefectsWidget> createState() => _DefectsWidgetState();
}

class _DefectsWidgetState extends State<DefectsWidget> {
  late DefectsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    FirebaseApi().initNotifications(context);
    super.initState();
    _model = createModel(context, () => DefectsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.authResponse1 = await AuthCall.call(
        username: FFAppState().rememberEmail,
        password: FFAppState().rememberPassword,
      );

      GoRouter.of(context).prepareAuthEvent();
      await authManager.signIn(
        authenticationToken: AuthCall.accesstoken(
          (_model.authResponse1?.jsonBody ?? ''),
        ),
      );
      safeSetState(() {
        FFAppState().clearDefectCache();
        _model.apiRequestCompleted = false;
      });
      await _model.waitForApiRequestCompleted();
      if (FFAppState().fcmtoken != FFAppState().secondFcmToken) {
        _model.test = await UpdateFCMTokenCall.call(
          access: currentAuthenticationToken,
          fcmtoken: FFAppState().secondFcmToken,
        );

        if (!(_model.test?.succeeded ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (_model.test?.jsonBody ?? '').toString(),
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        }
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      future: FFAppState()
          .defect(
        requestFn: () => GetDefectsAPICall.call(
          access: currentAuthenticationToken,
          search: _model.textController.text != null &&
                  _model.textController.text != ''
              ? '&search=${_model.textController.text}'
              : '',
          page: _model.page.toString(),
          date: _model.datePicked != null
              ? '&date[]=${dateTimeFormat(
                  "y-MM-dd",
                  _model.datePicked,
                  locale: FFLocalizations.of(context).languageCode,
                )}&date[]=${dateTimeFormat(
                  "y-MM-dd",
                  _model.datePicked,
                  locale: FFLocalizations.of(context).languageCode,
                )}'
              : '',
          department: _model.filialValue != null && _model.filialValue != ''
              ? '&area=${_model.filialValue}'
              : '',
          contractor:
              _model.contractorValue != null && _model.contractorValue != ''
                  ? '&contractor=${_model.contractorValue}'
                  : '',
          status: _model.statusValue != null && _model.statusValue != ''
              ? '&status=${_model.statusValue}'
              : '',
          type: _model.typeValue != null && _model.typeValue != ''
              ? '&type=${_model.typeValue}'
              : '',
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
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final defectsGetDefectsAPIResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: Visibility(
              visible: (valueOrDefault<String>(
                            functions.jsonToStringCopy(getJsonField(
                              FFAppState().account,
                              r'''$.role''',
                            )),
                            '-',
                          ) ==
                          '\"admin\"') ||
                      (valueOrDefault<String>(
                            functions.jsonToStringCopy(getJsonField(
                              FFAppState().account,
                              r'''$.role''',
                            )),
                            '-',
                          ) ==
                          '\"director\"') ||
                      (valueOrDefault<String>(
                            functions.jsonToStringCopy(getJsonField(
                              FFAppState().account,
                              r'''$.role''',
                            )),
                            '-',
                          ) ==
                          '\"engineer\"') ||
                      (valueOrDefault<String>(
                            functions.jsonToStringCopy(getJsonField(
                              FFAppState().account,
                              r'''$.role''',
                            )),
                            '-',
                          ) ==
                          '\"performer\"')
                  ? true
                  : false,
              child: FloatingActionButton(
                onPressed: () async {
                  context.pushNamed(ChooseequipWidget.routeName);
                },
                backgroundColor: FlutterFlowTheme.of(context).primary,
                elevation: 8,
                child: Icon(
                  Icons.add,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24,
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              iconTheme: IconThemeData(
                  color: FlutterFlowTheme.of(context).secondaryBackground),
              automaticallyImplyLeading: false,
              title: Text(
                'Заявка на обслуживание',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 4,
            ),
            body: SafeArea(
              top: true,
              child: RefreshIndicator(
                onRefresh: () async {
                  safeSetState(() {
                    FFAppState().clearDefectCache();
                    _model.apiRequestCompleted = false;
                  });
                  await _model.waitForApiRequestCompleted();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.78,
                              decoration: BoxDecoration(),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController',
                                  Duration(milliseconds: 2000),
                                  () async {
                                    _model.isEdited = true;
                                    safeSetState(() {});
                                    safeSetState(() {
                                      FFAppState().clearDefectCache();
                                      _model.apiRequestCompleted = false;
                                    });
                                    await _model.waitForApiRequestCompleted();
                                  },
                                ),
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: false,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Поиск',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                  ),
                                  suffixIcon: _model
                                          .textController!.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            _model.textController?.clear();
                                            _model.isEdited = true;
                                            safeSetState(() {});
                                            safeSetState(() {
                                              FFAppState().clearDefectCache();
                                              _model.apiRequestCompleted =
                                                  false;
                                            });
                                            await _model
                                                .waitForApiRequestCompleted();
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Color(0xFF757575),
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
                                maxLines: null,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderRadius: 8,
                              buttonSize: 50,
                              fillColor: FlutterFlowTheme.of(context).primary,
                              icon: Icon(
                                Icons.search_sharp,
                                color: FlutterFlowTheme.of(context).info,
                                size: 24,
                              ),
                              onPressed: () async {
                                safeSetState(() {
                                  FFAppState().clearDefectCache();
                                  _model.apiRequestCompleted = false;
                                });
                                await _model.waitForApiRequestCompleted();
                                _model.isEdited = true;
                                safeSetState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (_model.isEdited)
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  safeSetState(() {
                                    _model.statusValueController?.reset();
                                    _model.filialValueController?.reset();
                                    _model.contractorValueController?.reset();
                                    _model.typeValueController?.reset();
                                  });
                                  safeSetState(() {
                                    _model.textController?.clear();
                                  });
                                  _model.date = null;
                                  safeSetState(() {});
                                  safeSetState(() {
                                    FFAppState().clearDefectCache();
                                    _model.apiRequestCompleted = false;
                                  });
                                  await _model.waitForApiRequestCompleted();
                                  _model.isEdited = false;
                                  safeSetState(() {});
                                },
                                child: Icon(
                                  Icons.close,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
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
                                  lastDate: getCurrentTimestamp,
                                  builder: (context, child) {
                                    return wrapInMaterialDatePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle: FlutterFlowTheme.of(
                                              context)
                                          .headlineLarge
                                          .override(
                                            font: GoogleFonts.outfit(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
                                            ),
                                            fontSize: 32,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
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
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
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
                                    _model.datePicked = getCurrentTimestamp;
                                  });
                                }
                                _model.date = _model.datePicked;
                                _model.isEdited = true;
                                safeSetState(() {});
                                safeSetState(() {
                                  FFAppState().clearDefectCache();
                                  _model.apiRequestCompleted = false;
                                });
                                await _model.waitForApiRequestCompleted();
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.045,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24,
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                          "y-MM-d",
                                          _model.date,
                                          locale: FFLocalizations.of(context)
                                              .languageCode,
                                        ),
                                        'Дата',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 10))
                                      .addToStart(SizedBox(width: 10))
                                      .addToEnd(SizedBox(width: 10)),
                                ),
                              ),
                            ),
                            FlutterFlowDropDown<String>(
                              controller: _model.statusValueController ??=
                                  FormFieldController<String>(null),
                              options: List<String>.from([
                                'open',
                                'contractor_appointed',
                                'contractor_accept',
                                'at_performer',
                                'in_progress',
                                'postponed',
                                'completed',
                                'closed'
                              ]),
                              optionLabels: [
                                'Открыта',
                                'Подрядчик назначен',
                                'Принят подрядчиком',
                                'У исполнителя',
                                'В работе',
                                'Отложена',
                                'Выполнен',
                                'Закрыта'
                              ],
                              onChanged: (val) async {
                                safeSetState(() => _model.statusValue = val);
                                safeSetState(() {
                                  FFAppState().clearDefectCache();
                                  _model.apiRequestCompleted = false;
                                });
                                await _model.waitForApiRequestCompleted();
                                _model.isEdited = true;
                                safeSetState(() {});
                              },
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 37,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Статус',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2,
                              borderColor: Colors.transparent,
                              borderWidth: 0,
                              borderRadius: 8,
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: GetAreaCall.call(
                                access: currentAuthenticationToken,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final filialGetAreaResponse = snapshot.data!;

                                return FlutterFlowDropDown<String>(
                                  controller: _model.filialValueController ??=
                                      FormFieldController<String>(null),
                                  options: List<String>.from((getJsonField(
                                    filialGetAreaResponse.jsonBody,
                                    r'''$.data[:].id''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>()),
                                  optionLabels: (getJsonField(
                                    filialGetAreaResponse.jsonBody,
                                    r'''$.data[:].title''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.filialValue = val);
                                    safeSetState(() {
                                      FFAppState().clearDefectCache();
                                      _model.apiRequestCompleted = false;
                                    });
                                    await _model.waitForApiRequestCompleted();
                                    _model.isEdited = true;
                                    safeSetState(() {});
                                  },
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 37,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Филиал',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  borderRadius: 8,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: GetContractorsCall.call(
                                access: currentAuthenticationToken,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final contractorGetContractorsResponse =
                                    snapshot.data!;

                                return FlutterFlowDropDown<String>(
                                  controller:
                                      _model.contractorValueController ??=
                                          FormFieldController<String>(null),
                                  options: List<String>.from((getJsonField(
                                    contractorGetContractorsResponse.jsonBody,
                                    r'''$.data[:].id''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>()),
                                  optionLabels: (getJsonField(
                                    contractorGetContractorsResponse.jsonBody,
                                    r'''$.data[:].title''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.contractorValue = val);
                                    safeSetState(() {
                                      FFAppState().clearDefectCache();
                                      _model.apiRequestCompleted = false;
                                    });
                                    await _model.waitForApiRequestCompleted();
                                    _model.isEdited = true;
                                    safeSetState(() {});
                                  },
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 37,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Подрядчик',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  borderRadius: 8,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                );
                              },
                            ),
                            FutureBuilder<ApiCallResponse>(
                              future: GetTypeCall.call(
                                access: currentAuthenticationToken,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final typeGetTypeResponse = snapshot.data!;

                                return FlutterFlowDropDown<String>(
                                  controller: _model.typeValueController ??=
                                      FormFieldController<String>(null),
                                  options: List<String>.from((getJsonField(
                                    typeGetTypeResponse.jsonBody,
                                    r'''$.data[:].id''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>()),
                                  optionLabels: (getJsonField(
                                    typeGetTypeResponse.jsonBody,
                                    r'''$.data[:].title''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  onChanged: (val) async {
                                    safeSetState(() => _model.typeValue = val);
                                    safeSetState(() {
                                      FFAppState().clearDefectCache();
                                      _model.apiRequestCompleted = false;
                                    });
                                    await _model.waitForApiRequestCompleted();
                                    _model.isEdited = true;
                                    safeSetState(() {});
                                  },
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 37,
                                  searchHintTextStyle:
                                      FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                  searchTextStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Тип техники',
                                  searchHintText: 'Поиск',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  borderRadius: 8,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: true,
                                  isMultiSelect: false,
                                );
                              },
                            ),
                          ]
                              .divide(SizedBox(width: 10))
                              .addToStart(SizedBox(width: 16))
                              .addToEnd(SizedBox(width: 16)),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          if (!functions.emptyList(getJsonField(
                            defectsGetDefectsAPIResponse.jsonBody,
                            r'''$.data''',
                            true,
                          ))!) {
                            return Builder(
                              builder: (context) {
                                final defects = getJsonField(
                                  defectsGetDefectsAPIResponse.jsonBody,
                                  r'''$.data''',
                                ).toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(defects.length,
                                          (defectsIndex) {
                                    final defectsItem = defects[defectsIndex];
                                    return Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              DetailedDefectsOfflineWidget
                                                  .routeName,
                                              queryParameters: {
                                                'id': serializeParam(
                                                  getJsonField(
                                                    defectsItem,
                                                    r'''$.id''',
                                                  ),
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
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
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.12,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.12,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFFDCDCDC),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/images/Avatar_(5).png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 5, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    getJsonField(
                                                                      defectsItem,
                                                                      r'''$.title''',
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
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child:
                                                                      RichText(
                                                                    textScaler:
                                                                        MediaQuery.of(context)
                                                                            .textScaler,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              defectsItem,
                                                                              r'''$.equipment_info.area_info.title''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 12,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              defectsItem,
                                                                              r'''$.equipment_info.area_info.object_info.title''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
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
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Text(
                                                                    getJsonField(
                                                                      defectsItem,
                                                                      r'''$.equipment_info.title''',
                                                                    ).toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          fontSize:
                                                                              12,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  color: Color(
                                                                      0xFF87898F),
                                                                  size: 15,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          -1),
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                      "d.M.y",
                                                                      functions
                                                                          .stringToDateTime(
                                                                              getJsonField(
                                                                        defectsItem,
                                                                        r'''$.created_on''',
                                                                      ).toString()),
                                                                      locale: FFLocalizations.of(
                                                                              context)
                                                                          .languageCode,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color:
                                                                              Color(0xFF87898F),
                                                                          fontSize:
                                                                              14,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border:
                                                                  Border.all(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  functions
                                                                      .colorDefectCopy(
                                                                          getJsonField(
                                                                    defectsItem,
                                                                    r'''$.status''',
                                                                  ).toString()),
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              5,
                                                                              5,
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .statusRequest(getJsonField(
                                                                            defectsItem,
                                                                            r'''$.status''',
                                                                          ).toString()),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: valueOrDefault<Color>(
                                                                                functions.colorDefectCopy(getJsonField(
                                                                                  defectsItem,
                                                                                  r'''$.status''',
                                                                                ).toString()),
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                              ),
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 3)),
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(width: 5)),
                                                ),
                                              ]
                                                  .addToStart(
                                                      SizedBox(height: 10))
                                                  .addToEnd(
                                                      SizedBox(height: 10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                      .divide(SizedBox(height: 10))
                                      .addToEnd(SizedBox(height: 10)),
                                );
                              },
                            );
                          } else {
                            return Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'Заявки отсутсвуют',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 20,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ]
                        .divide(SizedBox(height: 10))
                        .addToStart(SizedBox(height: 10)),
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
