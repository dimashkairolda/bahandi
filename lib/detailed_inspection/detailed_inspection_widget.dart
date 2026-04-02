import 'package:Etry/inspections/inspections_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/shkala1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/inspections/checkboxes1/checkboxes1_widget.dart';
import '/inspections/date1/date1_widget.dart';
import '/inspections/diapason1/diapason1_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska1/iz_spiska1_widget.dart';
import '/inspections/radio_defect1/radio_defect1_widget.dart';
import '/inspections/short_text1/short_text1_widget.dart';
import '/inspections/zamery1/zamery1_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'detailed_inspection_model.dart';
export 'detailed_inspection_model.dart';

class DetailedInspectionWidget extends StatefulWidget {
  const DetailedInspectionWidget({
    super.key,
    required this.name,
    required this.index,
    this.nextIndex,
    required this.json,
  });

  final dynamic name;
  final int? index;
  final int? nextIndex;
  final dynamic json;

  static String routeName = 'detailedInspection';
  static String routePath = '/detailedInspection';

  @override
  State<DetailedInspectionWidget> createState() =>
      _DetailedInspectionWidgetState();
}

class _DetailedInspectionWidgetState extends State<DetailedInspectionWidget> {
  late DetailedInspectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().inspectionsTemp = 0;
      FFAppState().loopFormResult = 0;
      safeSetState(() {});
      await actions.updateStartedOn(
        widget.name,
      );
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: // Generated code for this AppBar Widget...
// Generated code for this AppBar Widget...
AppBar(
  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
  automaticallyImplyLeading: false,
  leading: FlutterFlowIconButton(
    borderColor: Colors.transparent,
    borderRadius: 30,
    borderWidth: 1,
    buttonSize: 60,
    icon: Icon(
      Icons.arrow_back_rounded,
      color: Color(0xFF2A61ED),
      size: 30,
    ),
    onPressed: () async {
      context.safePop();
    },
  ),
  title: Text(
    FFLocalizations.of(context).getVariableText(
      ruText: 'Регламентная работа',
      kkText: 'Регламенттік жұмыс',
    ),
    style: FlutterFlowTheme.of(context).headlineMedium.override(
          fontFamily: 'SFProText',
          color: Color(0xFF2A61ED),
          fontSize: 16,
          letterSpacing: 0.0,
        ),
  ),
  actions: [],
  centerTitle: false,
  elevation: 2,
)
,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 18),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            decoration: BoxDecoration(),
                            child: Text(
                              getJsonField(
                                widget.name,
                                r'''$.regulation_info.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Дата : ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    dateTimeFormat(
                                      "dd.MM.y",
                                      functions.stringToDateTime(
                                          valueOrDefault<String>(
                                        getJsonField(
                                          widget.name,
                                          r'''$.available_from''',
                                        )?.toString(),
                                        '-',
                                      )),
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '-',
                                  ),
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Время : ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    dateTimeFormat(
                                      "HH:mm",
                                      functions.stringToDateTime(
                                          valueOrDefault<String>(
                                        getJsonField(
                                          widget.name,
                                          r'''$.available_from''',
                                        )?.toString(),
                                        '-',
                                      )),
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '-',
                                  ),
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: ' - ',
                                  style: TextStyle(),
                                ),
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    dateTimeFormat(
                                      "HH:mm",
                                      functions.stringToDateTime(
                                          valueOrDefault<String>(
                                        getJsonField(
                                          widget!.name,
                                          r'''$.available_to''',
                                        )?.toString(),
                                        '-',
                                      )),
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ),
                                    '-',
                                  ),
                                  style: TextStyle(),
                                )
                              ],
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      builder: (context) {
                        final responses = getJsonField(
                          widget.name,
                          r'''$.responses''',
                        ).toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(responses.length, (responsesIndex) {
                            final responsesItem = responses[responsesIndex];
                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        getJsonField(
                                          responsesItem,
                                          r'''$.regulation_work_info.equipment_info.title''',
                                        ).toString(),
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'SFProText',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Builder(
                                        builder: (context) {
                                          final formresult = getJsonField(
                                            responsesItem,
                                            r'''$.form_result''',
                                          ).toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                    formresult.length,
                                                    (formresultIndex) {
                                              final formresultItem =
                                                  formresult[formresultIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (functions
                                                              .jsonToStringCopy(
                                                                  getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          )) ==
                                                          '\"instruction\"') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .instructionModels
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              InstructionWidget(
                                                            key: Key(
                                                              'Keycy4_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            data:
                                                                formresultItem,
                                                          ),
                                                        );
                                                      } else if (functions
                                                              .jsonToStringCopy(
                                                                  getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          )) ==
                                                          '\"radio_defect\"') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .radioDefect1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              RadioDefect1Widget(
                                                            key: Key(
                                                              'Keynjx_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            data:
                                                                formresultItem,
                                                            searchID:
                                                                getJsonField(
                                                              widget.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            index:
                                                                widget.index,
                                                            name: widget.name,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'checkbox') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .checkboxes1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              Checkboxes1Widget(
                                                            key: Key(
                                                              'Keymyx_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'range') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .diapason1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              Diapason1Widget(
                                                            key: Key(
                                                              'Keylsx_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'radio') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .izSpiska1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              IzSpiska1Widget(
                                                            key: Key(
                                                              'Key47q_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'short_text') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .shortText1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              ShortText1Widget(
                                                            key: Key(
                                                              'Keyaco_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'date') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .date1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: Date1Widget(
                                                            key: Key(
                                                              'Key2ae_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'scale') {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .shkala1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: Shkala1Widget(
                                                            key: Key(
                                                              'Keydjs_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      } else {
                                                        return wrapWithModel(
                                                          model: _model
                                                              .zamery1Models
                                                              .getModel(
                                                            getJsonField(
                                                              formresultItem,
                                                              r'''$.data.title''',
                                                            ).toString(),
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: Zamery1Widget(
                                                            key: Key(
                                                              'Key2ks_${getJsonField(
                                                                formresultItem,
                                                                r'''$.data.title''',
                                                              ).toString()}',
                                                            ),
                                                            index:
                                                                widget!.index!,
                                                            searchID:
                                                                getJsonField(
                                                              widget!.name,
                                                              r'''$.id''',
                                                            ),
                                                            equipmentId:
                                                                getJsonField(
                                                              responsesItem,
                                                              r'''$.regulation_work_info.equipment''',
                                                            ),
                                                            nextIndex: widget!
                                                                .nextIndex!,
                                                            data:
                                                                formresultItem,
                                                            name: widget!.name!,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Divider(
                                                    thickness: 2,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                  ),
                                                ].divide(SizedBox(height: 10)),
                                              );
                                            })
                                                .divide(SizedBox(height: 5))
                                                .addToEnd(SizedBox(height: 10)),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                                  .divide(SizedBox(height: 5))
                                  .addToEnd(SizedBox(height: 10)),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(21, 0, 21, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              var _shouldSetState = false;
                              if (functions.validateRadioDefectFilling(
                                  FFAppState().checkCache)) {
                                _model.apiResultw4j =
                                    await InspectionFinishCall.call(
                                  access: currentAuthenticationToken,
                                  id: getJsonField(
                                    FFAppState().checkCache,
                                    r'''$.id''',
                                  ),
                                  responseJson: getJsonField(
                                    FFAppState().checkCache,
                                    r'''$.responses''',
                                    true,
                                  ),
                                  finishedOn: dateTimeFormat(
                                    "y-M-d HH:mm:ss",
                                    getCurrentTimestamp,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ),
                                  startedOn: getJsonField(
                                    FFAppState().checkCache,
                                    r'''$.started_on''',
                                  ).toString(),
                                );

                                _shouldSetState = true;
                                if (!(_model.apiResultw4j?.succeeded ?? true)) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Ошибка'),
                                        content: Text(getJsonField(
                                          (_model.apiResultw4j?.jsonBody ?? ''),
                                          r'''$.detail''',
                                        ).toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Закрыть'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }

                                context.goNamed(InspectionsWidget.routeName);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Осмотр успешно пройден!',
                                      style: TextStyle(
                                        fontFamily: 'SFProText',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontSize: 16,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                  ),
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Ошибка'),
                                      content: Text(functions
                                          .validateRadioDefectFilling23(
                                              FFAppState().checkCache)),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Закрыть'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                print(getJsonField(FFAppState().checkCache, r'''$.responses[29]'''));
                              }

                              if (_shouldSetState) safeSetState(() {});
                            },
                            text: 'Завершить',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width,
                              height: 40,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF2A61ED),
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
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
