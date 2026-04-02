import '/components/shkala_show_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/inspections/checkboxes_show/checkboxes_show_widget.dart';
import '/inspections/date_show/date_show_widget.dart';
import '/inspections/diapason_show/diapason_show_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska_show/iz_spiska_show_widget.dart';
import '/inspections/radio_defect_show/radio_defect_show_widget.dart';
import '/inspections/short_text_show/short_text_show_widget.dart';
import '/inspections/zamery_show/zamery_show_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

import 'detailed_inspection_done_model.dart';
export 'detailed_inspection_done_model.dart';

class DetailedInspectionDoneWidget extends StatefulWidget {
  const DetailedInspectionDoneWidget({
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

  static String routeName = 'detailedInspectionDone';
  static String routePath = '/detailedInspectionDone';

  @override
  State<DetailedInspectionDoneWidget> createState() =>
      _DetailedInspectionDoneWidgetState();
}

class _DetailedInspectionDoneWidgetState
    extends State<DetailedInspectionDoneWidget> {
  late DetailedInspectionDoneModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionDoneModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
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
        ),
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
                                  text: 'Дата старта : ',
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
                                      "dd.MM.y HH:mm",
                                      functions.stringToDateTime(
                                          valueOrDefault<String>(
                                        getJsonField(
                                          widget.name,
                                          r'''$.started_on''',
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
                                  text: 'Дата завершения : ',
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
                                      "dd.MM.y HH:mm",
                                      functions.stringToDateTime(
                                          valueOrDefault<String>(
                                        getJsonField(
                                          widget!.name,
                                          r'''$.finished_on''',
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
                          widget.json,
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
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
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
                                                            '',
                                                            formresultIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              InstructionWidget(
                                                            key: Key(
                                                              'Keyjlf_${''}',
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
                                                        return RadioDefectShowWidget(
                                                          key: Key(
                                                              'Key1z5_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'checkbox') {
                                                        return CheckboxesShowWidget(
                                                          key: Key(
                                                              'Key2j3_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'range') {
                                                        return DiapasonShowWidget(
                                                          key: Key(
                                                              'Keysgt_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'radio') {
                                                        return IzSpiskaShowWidget(
                                                          key: Key(
                                                              'Key7zq_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'short_text') {
                                                        return ShortTextShowWidget(
                                                          key: Key(
                                                              'Keyh7d_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'date') {
                                                        return DateShowWidget(
                                                          key: Key(
                                                              'Keym3j_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else if (getJsonField(
                                                            formresultItem,
                                                            r'''$.type''',
                                                          ) ==
                                                          'scale') {
                                                        return ShkalaShowWidget(
                                                          key: Key(
                                                              'Key3sm_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
                                                        );
                                                      } else {
                                                        return ZameryShowWidget(
                                                          key: Key(
                                                              'Key86z_${formresultIndex}_of_${formresult.length}'),
                                                          index:
                                                              formresultIndex,
                                                          data: formresultItem,
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
                                                .addToEnd(SizedBox(height: 5)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
