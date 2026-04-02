import '/defects/add_comment/add_comment_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_defect2_model.dart';
export 'edit_defect2_model.dart';

class EditDefect2Widget extends StatefulWidget {
  const EditDefect2Widget({
    super.key,
    required this.id,
    required this.json,
  });

  final int? id;
  final dynamic json;

  @override
  State<EditDefect2Widget> createState() => _EditDefect2WidgetState();
}

class _EditDefect2WidgetState extends State<EditDefect2Widget> {
  late EditDefect2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditDefect2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                if (valueOrDefault<String>(
                      functions.jsonToStringCopy(getJsonField(
                        FFAppState().account,
                        r'''$.role''',
                      )),
                      '-',
                    ) ==
                    '\"engineer\"') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (functions.statusRequest(getJsonField(
                            widget.json,
                            r'''$.status''',
                          ).toString()) ==
                          'Открыта')
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                SelectPodryadchikWidget.routeName,
                                queryParameters: {
                                  'title': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.title''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                  'id': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.id''',
                                    ),
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.person_add_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Назначить подрядчика',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFE9ECEF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if ((functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Открыта') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'У исполнителя') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Отклонена') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'В работе'))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                SelectIspolnitelWidget.routeName,
                                queryParameters: {
                                  'title': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.title''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                  'id': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.id''',
                                    ),
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.person_add_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Назначить исполнителя',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFE9ECEF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if ((functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) !=
                              'Закрыта') &&
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) !=
                              'На проверке') &&
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) !=
                              'Отклонена'))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                EditDefecWidget.routeName,
                                queryParameters: {
                                  'id': serializeParam(
                                    widget.id,
                                    ParamType.int,
                                  ),
                                  'json': serializeParam(
                                    widget.json,
                                    ParamType.JSON,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Редактировать',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFE9ECEF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ].addToStart(SizedBox(height: 10.0)),
                  );
                } else if (valueOrDefault<String>(
                      functions.jsonToStringCopy(getJsonField(
                        FFAppState().account,
                        r'''$.role''',
                      )),
                      '-',
                    ) ==
                    '\"admin\"') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if ((functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Принят подрядчиком') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Отложена') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'У исполнителя') ||
                          (functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Открыта'))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                SelectIspolnitelWidget.routeName,
                                queryParameters: {
                                  'title': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.title''',
                                    ).toString(),
                                    ParamType.String,
                                  ),
                                  'id': serializeParam(
                                    getJsonField(
                                      widget.json,
                                      r'''$.id''',
                                    ),
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.person_add_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Назначить механика',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: FlutterFlowTheme.of(context).warning,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if ((functions.statusRequest(getJsonField(
                                widget.json,
                                r'''$.status''',
                              ).toString()) ==
                              'Принят подрядчиком') &&
                          !getJsonField(
                            widget.json,
                            r'''$.priority''',
                          ))
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.35,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.95,
                                        child: AddCommentWidget(
                                          id: widget.id!,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: Icon(
                                            Icons.access_time_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 24.0,
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            'Отложить заявку',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'SFProText',
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color:
                                          FlutterFlowTheme.of(context).warning,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              EditDefecWidget.routeName,
                              queryParameters: {
                                'id': serializeParam(
                                  widget.id,
                                  ParamType.int,
                                ),
                                'json': serializeParam(
                                  widget.json,
                                  ParamType.JSON,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Text(
                                        'Редактировать',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ].addToStart(SizedBox(height: 10.0)),
                  );
                } else if (valueOrDefault<String>(
                      functions.jsonToStringCopy(getJsonField(
                        FFAppState().account,
                        r'''$.role''',
                      )),
                      '-',
                    ) ==
                    '\"performer\"') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (functions.statusRequest(getJsonField(
                            widget.json,
                            r'''$.status''',
                          ).toString()) ==
                          'В работе')
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                EditDefecWidget.routeName,
                                queryParameters: {
                                  'id': serializeParam(
                                    widget.id,
                                    ParamType.int,
                                  ),
                                  'json': serializeParam(
                                    widget.json,
                                    ParamType.JSON,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Редактировать',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFE9ECEF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ].addToStart(SizedBox(height: 10.0)),
                  );
                } else if (valueOrDefault<String>(
                      functions.jsonToStringCopy(getJsonField(
                        FFAppState().account,
                        r'''$.role''',
                      )),
                      '-',
                    ) ==
                    '\"director\"') {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (functions.statusRequest(getJsonField(
                            widget.json,
                            r'''$.status''',
                          ).toString()) ==
                          'Открыта')
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                EditDefecWidget.routeName,
                                queryParameters: {
                                  'id': serializeParam(
                                    widget.id,
                                    ParamType.int,
                                  ),
                                  'json': serializeParam(
                                    widget.json,
                                    ParamType.JSON,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Text(
                                          'Редактировать',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFE9ECEF),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ].addToStart(SizedBox(height: 10.0)),
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
          ],
        ),
      ),
    );
  }
}
