import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/edit_defect2_widget.dart';
import '/components/editcomment_widget.dart';
import '/defects/add_comment_copy/add_comment_copy_widget.dart';
import '/defects/add_t_m_c/add_t_m_c_widget.dart';
import '/defects/add_works/add_works_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'detailed_defects_offline_model.dart';
export 'detailed_defects_offline_model.dart';

class DetailedDefectsOfflineWidget extends StatefulWidget {
  const DetailedDefectsOfflineWidget({
    super.key,
    this.id,
  });

  final int? id;

  static String routeName = 'DetailedDefectsOffline';
  static String routePath = '/detailedDefectsOffline';

  @override
  State<DetailedDefectsOfflineWidget> createState() =>
      _DetailedDefectsOfflineWidgetState();
}

class _DetailedDefectsOfflineWidgetState
    extends State<DetailedDefectsOfflineWidget> with TickerProviderStateMixin {
  late DetailedDefectsOfflineModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedDefectsOfflineModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().isEdited = false;
      FFAppState().photos = [];
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 6,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
      future: GetDefectsByIDCall.call(
        access: currentAuthenticationToken,
        id: widget!.id,
      ),
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
        final detailedDefectsOfflineGetDefectsByIDResponse = snapshot.data!;

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
                  color: Color(0xFF3466E7),
                  size: 30,
                ),
                onPressed: () async {
                  context.pushNamed(DefectsWidget.routeName);
                },
              ),
              title: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pushNamed(
                    DetailedInspectionsCopyCopy2Widget.routeName,
                    queryParameters: {
                      'asas': serializeParam(
                        getJsonField(
                          detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                          r'''$.spare_parts''',
                          true,
                        ),
                        ParamType.JSON,
                        isList: true,
                      ),
                    }.withoutNulls,
                  );
                },
                child: Text(
                  'Информация о заявке',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'SFProText',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 18,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              actions: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  height: 100,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: EditDefect2Widget(
                                  id: widget!.id!,
                                  json:
                                      detailedDefectsOfflineGetDefectsByIDResponse
                                          .jsonBody,
                                ),
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Icon(
                            Icons.more_vert,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.73,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        11.5, 0, 11.5, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(-1, 0),
                                                child: Text(
                                                  getJsonField(
                                                    detailedDefectsOfflineGetDefectsByIDResponse
                                                        .jsonBody,
                                                    r'''$.title''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 17,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: valueOrDefault<Color>(
                                                  functions.colorDefectCopy(
                                                      getJsonField(
                                                    detailedDefectsOfflineGetDefectsByIDResponse
                                                        .jsonBody,
                                                    r'''$.status''',
                                                  ).toString()),
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                                ),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.26,
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 5, 5),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          functions
                                                              .statusRequest(
                                                                  getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.status''',
                                                          ).toString()),
                                                          '-',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    functions
                                                                        .colorDefectCopy(
                                                                            getJsonField(
                                                                      detailedDefectsOfflineGetDefectsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  fontSize: 12,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        11.5, 0, 0, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      decoration: BoxDecoration(),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            EquipmentsDetailedWidget.routeName,
                                            queryParameters: {
                                              'json': serializeParam(
                                                getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.equipment_info''',
                                                ),
                                                ParamType.JSON,
                                              ),
                                              'id': serializeParam(
                                                getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.equipment_info.id''',
                                                ),
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: RichText(
                                          textScaler:
                                              MediaQuery.of(context).textScaler,
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.equipment_info.title''',
                                                ).toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 15,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              )
                                            ],
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'SFProText',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontSize: 15,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        11.5, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF87898F),
                                          size: 15,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1, -1),
                                          child: Text(
                                            dateTimeFormat(
                                              "d.M.y H:m",
                                              functions.stringToDateTime(
                                                  getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.created_on''',
                                              ).toString()),
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'SFProText',
                                                  color: Color(0xFF87898F),
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 15))
                                    .addToStart(SizedBox(height: 10))
                                    .addToEnd(SizedBox(height: 10)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment(0, 0),
                                child: FlutterFlowButtonTabBar(
                                  useToggleButtonStyle: false,
                                  isScrollable: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 14,
                                        letterSpacing: 0.0,
                                      ),
                                  unselectedLabelStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                          ),
                                  labelColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  borderWidth: 0,
                                  borderRadius: 10,
                                  elevation: 0,
                                  buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 0),
                                  tabs: [
                                    Tab(
                                      text: 'Информация',
                                    ),
                                    Tab(
                                      text: 'Список работ',
                                    ),
                                    Tab(
                                      text: 'Список ТМЦ',
                                    ),
                                    Tab(
                                      text: 'Вложения',
                                    ),
                                    Tab(
                                      text: 'Комментарии',
                                    ),
                                    Tab(
                                      text: 'История',
                                    ),
                                  ],
                                  controller: _model.tabBarController,
                                  onTap: (i) async {
                                    [
                                      () async {},
                                      () async {
                                        FFAppState().works = (getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.works''',
                                          true,
                                        )!
                                                    .toList()
                                                    .map<WorksStruct?>(
                                                        WorksStruct.maybeFromMap)
                                                    .toList()
                                                as Iterable<WorksStruct?>)
                                            .withoutNulls
                                            .toList()
                                            .cast<WorksStruct>();
                                        safeSetState(() {});
                                      },
                                      () async {
                                        FFAppState().spareparts = (getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.spare_parts''',
                                          true,
                                        )!
                                                    .toList()
                                                    .map<TmcStruct?>(
                                                        TmcStruct.maybeFromMap)
                                                    .toList()
                                                as Iterable<TmcStruct?>)
                                            .withoutNulls
                                            .toList()
                                            .cast<TmcStruct>();
                                        safeSetState(() {});
                                      },
                                      () async {
                                        _model.photos123 = getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.files''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                        safeSetState(() {});
                                      },
                                      () async {},
                                      () async {}
                                    ][i]();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _model.tabBarController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(11.5, 8, 11.5, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 10, 0, 10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 5),
                                                          child: Text(
                                                            'Информация о заявке',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        'Автор',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        '${getJsonField(
                                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                                              .jsonBody,
                                                                          r'''$.author_info.first_name''',
                                                                        ).toString()} ${getJsonField(
                                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                                              .jsonBody,
                                                                          r'''$.author_info.last_name''',
                                                                        ).toString()}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Филиал',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.area_info.title''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.area_info.object_info.title''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style:
                                                                                TextStyle(),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (!functions
                                                            .emptyList(
                                                                getJsonField(
                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                              .jsonBody,
                                                          r'''$.equipment_info.area_info.branch_schemes''',
                                                          true,
                                                        ))!)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Схемы филиала',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.8,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final shemes =
                                                                                getJsonField(
                                                                              detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                              r'''$.equipment_info.area_info.branch_schemes''',
                                                                            ).toList();

                                                                            return Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: List.generate(shemes.length, (shemesIndex) {
                                                                                final shemesItem = shemes[shemesIndex];
                                                                                return Align(
                                                                                  alignment: AlignmentDirectional(-1, -1),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      context.pushNamed(
                                                                                        PdfviewerWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'title': serializeParam(
                                                                                            getJsonField(
                                                                                              shemesItem,
                                                                                              r'''$.title''',
                                                                                            ).toString(),
                                                                                            ParamType.String,
                                                                                          ),
                                                                                          'viewer': serializeParam(
                                                                                            getJsonField(
                                                                                              shemesItem,
                                                                                              r'''$.url''',
                                                                                            ).toString(),
                                                                                            ParamType.String,
                                                                                          ),
                                                                                          'extension': serializeParam(
                                                                                            getJsonField(
                                                                                              shemesItem,
                                                                                              r'''$.extension''',
                                                                                            ).toString(),
                                                                                            ParamType.String,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    child: Text(
                                                                                      getJsonField(
                                                                                        shemesItem,
                                                                                        r'''$.title''',
                                                                                      ).toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            fontFamily: 'SFProText',
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            fontSize: 16,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FontStyle.italic,
                                                                                            decoration: TextDecoration.underline,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }).divide(SizedBox(height: 5)),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Тип',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.type_info.title''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Бренд',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.manufacturer_info.title''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Модель',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.model_info.title''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Инвентарный номер',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.inventory_number''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Заводской номер',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.equipment_info.factory_number''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
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
                                                                    0.65,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            3),
                                                                        child:
                                                                            Text(
                                                                          'Приоритетная заявка',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                functions.yesorno(getJsonField(
                                                                              detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                              r'''$.priority''',
                                                                            )),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(11.5, 8, 11.5, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 10, 0, 10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 5),
                                                          child: Text(
                                                            'Информация об устранении',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        if (!functions
                                                            .emptyList(
                                                                getJsonField(
                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                              .jsonBody,
                                                          r'''$.contractors_info''',
                                                          true,
                                                        ))!)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Исполнитель',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            '${valueOrDefault<String>(
                                                                              getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.performers_info[0].first_name''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            )} ${valueOrDefault<String>(
                                                                              getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.performers_info[0].last_name''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            )}',
                                                                            '-',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 16,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        'Время прибытия',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          dateTimeFormat(
                                                                            "d.M.y H.mm",
                                                                            functions.stringToDateTime(getJsonField(
                                                                              detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                              r'''$.datetime_performer_start''',
                                                                            ).toString()),
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        'Время принятия',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          dateTimeFormat(
                                                                            "d.M.y H.mm",
                                                                            functions.stringToDateTime(getJsonField(
                                                                              detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                              r'''$.datetime_contractor_accept''',
                                                                            ).toString()),
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        'Время выполнения',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          dateTimeFormat(
                                                                            "d.M.y H.mm",
                                                                            functions.stringToDateTime(getJsonField(
                                                                              detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                              r'''$.datetime_completed''',
                                                                            ).toString()),
                                                                            locale:
                                                                                FFLocalizations.of(context).languageCode,
                                                                          ),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 16,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                            .divide(SizedBox(height: 20))
                                            .addToEnd(SizedBox(height: 150)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.55,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 15, 0, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (FFAppState()
                                                          .isEdited) {
                                                        return Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.95,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        5),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Список работ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: Color(0xFF87898F),
                                                                                fontSize: 16,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        ),
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            FFAppState().isEdited =
                                                                                false;
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final works =
                                                                        FFAppState()
                                                                            .works
                                                                            .toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          works
                                                                              .length,
                                                                          (worksIndex) {
                                                                        final worksItem =
                                                                            works[worksIndex];
                                                                        return Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.8,
                                                                              height: MediaQuery.sizeOf(context).height * 0.05,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              worksItem.title,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 15,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 39,
                                                                                      height: 39,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFF86878F),
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: Text(
                                                                                          worksItem.amount.toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.readexPro(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                FFAppState().removeAtIndexFromWorks(worksIndex);
                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Container(
                                                                                height: MediaQuery.sizeOf(context).height * 0.37,
                                                                                width: MediaQuery.sizeOf(context).width * 0.95,
                                                                                child: AddWorksWidget(),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.add,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24,
                                                                            ),
                                                                            Text(
                                                                              'Добавить работу',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5)),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.95,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        5),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Список работ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: Color(0xFF87898F),
                                                                                fontSize: 16,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"engineer\"') {
                                                                              return Visibility(
                                                                                visible: (functions.statusRequest(getJsonField(
                                                                                          detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                          r'''$.status''',
                                                                                        ).toString()) !=
                                                                                        'Закрыта') &&
                                                                                    (functions.statusRequest(getJsonField(
                                                                                          detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                          r'''$.status''',
                                                                                        ).toString()) !=
                                                                                        'Выполнен'),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"admin\"') {
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  FFAppState().isEdited = true;
                                                                                  safeSetState(() {});
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.edit,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  size: 24,
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"performer\"') {
                                                                              return Visibility(
                                                                                visible: functions.statusRequest(getJsonField(
                                                                                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                      r'''$.status''',
                                                                                    ).toString()) ==
                                                                                    'В работе',
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"director\"') {
                                                                              return Visibility(
                                                                                visible: functions.statusRequest(getJsonField(
                                                                                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                      r'''$.status''',
                                                                                    ).toString()) ==
                                                                                    'Открыта',
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
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
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final works =
                                                                        FFAppState()
                                                                            .works
                                                                            .toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          works
                                                                              .length,
                                                                          (worksIndex) {
                                                                        final worksItem =
                                                                            works[worksIndex];
                                                                        return Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16,
                                                                                5,
                                                                                16,
                                                                                5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        worksItem.title,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 15,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 39,
                                                                                  height: 39,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF86878F),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Text(
                                                                                      worksItem.amount.toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.readexPro(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5)),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  if (FFAppState().isEdited)
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        var _shouldSetState =
                                                            false;
                                                        _model.apiResultg8zCopy =
                                                            await UpdateDefectsByIdCall
                                                                .call(
                                                          access:
                                                              currentAuthenticationToken,
                                                          id: getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.id''',
                                                          ),
                                                          bodyJson:
                                                              EditDefectStruct(
                                                            works: FFAppState()
                                                                .works,
                                                            files:
                                                                (getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.files''',
                                                              true,
                                                            )?.toList().map<FilesStruct?>(FilesStruct.maybeFromMap).toList()
                                                                        as Iterable<
                                                                            FilesStruct?>)
                                                                    .withoutNulls,
                                                          ).toMap(),
                                                        );

                                                        _shouldSetState = true;
                                                        if ((_model
                                                                .apiResultg8zCopy
                                                                ?.succeeded ??
                                                            true)) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Дефект успешно отредактирован!',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                (_model.apiResultg8zCopy
                                                                            ?.jsonBody ??
                                                                        '')
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }

                                                        FFAppState().isEdited =
                                                            false;
                                                        safeSetState(() {});
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                      },
                                                      text: 'Сохранить',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.95,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.05,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.55,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 15, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      if (FFAppState()
                                                          .isEdited) {
                                                        return Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.95,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        5),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Список ТМЦ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: Color(0xFF87898F),
                                                                                fontSize: 16,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        ),
                                                                        InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            FFAppState().isEdited =
                                                                                false;
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.close_sharp,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final spareparts =
                                                                        FFAppState()
                                                                            .spareparts
                                                                            .toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          spareparts
                                                                              .length,
                                                                          (sparepartsIndex) {
                                                                        final sparepartsItem =
                                                                            spareparts[sparepartsIndex];
                                                                        return Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.8,
                                                                              height: 50,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              sparepartsItem.title,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    fontSize: 15,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                            ),
                                                                                            Text(
                                                                                              sparepartsItem.model,
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 39,
                                                                                      height: 39,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFF86878F),
                                                                                        shape: BoxShape.circle,
                                                                                      ),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0, 0),
                                                                                        child: Text(
                                                                                          sparepartsItem.amount.toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.readexPro(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                FFAppState().removeAtIndexFromSpareparts(sparepartsIndex);
                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 24,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) =>
                                                                          InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (dialogContext) {
                                                                          return Dialog(
                                                                            elevation:
                                                                                0,
                                                                            insetPadding:
                                                                                EdgeInsets.zero,
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            alignment:
                                                                                AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Container(
                                                                                height: MediaQuery.sizeOf(context).height * 0.47,
                                                                                width: MediaQuery.sizeOf(context).width * 0.95,
                                                                                child: AddTMCWidget(),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width,
                                                                      height:
                                                                          50,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.add,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24,
                                                                            ),
                                                                            Text(
                                                                              'Добавить ТМЦ',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5)),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.95,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        5),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width,
                                                                  height: 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            5,
                                                                            16,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          'Список ТМЦ',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: Color(0xFF87898F),
                                                                                fontSize: 16,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"engineer\"') {
                                                                              return Visibility(
                                                                                visible: (functions.statusRequest(getJsonField(
                                                                                          detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                          r'''$.status''',
                                                                                        ).toString()) !=
                                                                                        'Закрыта') &&
                                                                                    (functions.statusRequest(getJsonField(
                                                                                          detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                          r'''$.status''',
                                                                                        ).toString()) !=
                                                                                        'Выполнен'),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"admin\"') {
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  FFAppState().isEdited = true;
                                                                                  safeSetState(() {});
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.edit,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  size: 24,
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"performer\"') {
                                                                              return Visibility(
                                                                                visible: functions.statusRequest(getJsonField(
                                                                                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                      r'''$.status''',
                                                                                    ).toString()) ==
                                                                                    'В работе',
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            } else if (valueOrDefault<String>(
                                                                                  functions.jsonToStringCopy(getJsonField(
                                                                                    FFAppState().account,
                                                                                    r'''$.role''',
                                                                                  )),
                                                                                  '-',
                                                                                ) ==
                                                                                '\"director\"') {
                                                                              return Visibility(
                                                                                visible: functions.statusRequest(getJsonField(
                                                                                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                      r'''$.status''',
                                                                                    ).toString()) ==
                                                                                    'Открыта',
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    FFAppState().isEdited = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 24,
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
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final spareparts =
                                                                        FFAppState()
                                                                            .spareparts
                                                                            .toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          spareparts
                                                                              .length,
                                                                          (sparepartsIndex) {
                                                                        final sparepartsItem =
                                                                            spareparts[sparepartsIndex];
                                                                        return Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(0),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16,
                                                                                5,
                                                                                16,
                                                                                5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        sparepartsItem.title,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 15,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                      ),
                                                                                      Text(
                                                                                        sparepartsItem.model,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: 39,
                                                                                  height: 39,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF86878F),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(0, 0),
                                                                                    child: Text(
                                                                                      sparepartsItem.amount.toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.readexPro(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 5)),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  if (FFAppState().isEdited)
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        var _shouldSetState =
                                                            false;
                                                        _model.apiResultg8zCopyCopy =
                                                            await UpdateDefectsByIdCall
                                                                .call(
                                                          access:
                                                              currentAuthenticationToken,
                                                          id: getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.id''',
                                                          ),
                                                          bodyJson:
                                                              EditDefectStruct(
                                                            spareParts:
                                                                FFAppState()
                                                                    .spareparts,
                                                            files:
                                                                (getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.files''',
                                                              true,
                                                            )?.toList().map<FilesStruct?>(FilesStruct.maybeFromMap).toList()
                                                                        as Iterable<
                                                                            FilesStruct?>)
                                                                    .withoutNulls,
                                                          ).toMap(),
                                                        );

                                                        _shouldSetState = true;
                                                        if ((_model
                                                                .apiResultg8zCopyCopy
                                                                ?.succeeded ??
                                                            true)) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'Дефект успешно отредактирован!',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                (_model.apiResultg8zCopyCopy
                                                                            ?.jsonBody ??
                                                                        '')
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }

                                                        FFAppState().isEdited =
                                                            false;
                                                        safeSetState(() {});
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                      },
                                                      text: 'Сохранить',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.95,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.05,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                ].divide(SizedBox(height: 10)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (!FFAppState().isEdited) {
                                              return Visibility(
                                                visible: !FFAppState().isEdited,
                                                child: Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.5,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.5, 15,
                                                                11.5, 0),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final todo =
                                                            getJsonField(
                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                              .jsonBody,
                                                          r'''$.files''',
                                                        ).toList();

                                                        return GridView.builder(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 10,
                                                            childAspectRatio: 1,
                                                          ),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              todo.length,
                                                          itemBuilder: (context,
                                                              todoIndex) {
                                                            final todoItem =
                                                                todo[todoIndex];
                                                            return InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
                                                                        .fade,
                                                                    child:
                                                                        FlutterFlowExpandedImageView(
                                                                      image: Image
                                                                          .network(
                                                                        'https://magnum.etry.kz${getJsonField(
                                                                          todoItem,
                                                                          r'''$.url''',
                                                                        ).toString()}',
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      allowRotation:
                                                                          false,
                                                                      tag:
                                                                          'https://magnum.etry.kz${getJsonField(
                                                                        todoItem,
                                                                        r'''$.url''',
                                                                      ).toString()}',
                                                                      useHeroAnimation:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Hero(
                                                                tag:
                                                                    'https://magnum.etry.kz${getJsonField(
                                                                  todoItem,
                                                                  r'''$.url''',
                                                                ).toString()}',
                                                                transitionOnUserGestures:
                                                                    true,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .network(
                                                                    'https://magnum.etry.kz${getJsonField(
                                                                      todoItem,
                                                                      r'''$.url''',
                                                                    ).toString()}',
                                                                    width: 300,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 0,
                                                                    11.5, 0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            FFAppState()
                                                                    .isEdited =
                                                                false;
                                                            FFAppState()
                                                                .photos = [];
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (FFAppState().isEdited)
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        11.5,
                                                                        0,
                                                                        11.5,
                                                                        0),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                final files = _model
                                                                    .photos123
                                                                    .toList();

                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List
                                                                      .generate(
                                                                          files
                                                                              .length,
                                                                          (filesIndex) {
                                                                    final filesItem =
                                                                        files[
                                                                            filesIndex];
                                                                    return Stack(
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.2,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.1,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              child: Image.network(
                                                                                'https://magnum.etry.kz${getJsonField(
                                                                                  filesItem,
                                                                                  r'''$.url''',
                                                                                ).toString()}',
                                                                                width: MediaQuery.sizeOf(context).width * 0.2,
                                                                                height: MediaQuery.sizeOf(context).height * 0.1,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              65,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.05,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.025,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                _model.removeAtIndexFromPhotos123(filesIndex);
                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                size: 24,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          11.5,
                                                                          0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final fotki =
                                                                      FFAppState()
                                                                          .photos
                                                                          .toList();

                                                                  return Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: List.generate(
                                                                        fotki
                                                                            .length,
                                                                        (fotkiIndex) {
                                                                      final fotkiItem =
                                                                          fotki[
                                                                              fotkiIndex];
                                                                      return Stack(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                10,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                65,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                FFAppState().removeAtIndexFromPhotos(fotkiIndex);
                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                height: MediaQuery.sizeOf(context).height * 0.025,
                                                                                decoration: BoxDecoration(),
                                                                                child: Icon(
                                                                                  Icons.close,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 24,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }).divide(SizedBox(
                                                                        width:
                                                                            5)),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.5, 0,
                                                                11.5, 0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        safeSetState(() {
                                                          _model.isDataUploading_uploadDataTbt501123 =
                                                              false;
                                                          _model.uploadedLocalFile_uploadDataTbt501123 =
                                                              FFUploadedFile(
                                                                  bytes: Uint8List
                                                                      .fromList(
                                                                          []));
                                                        });

                                                        final selectedMedia =
                                                            await selectMedia(
                                                          maxWidth: 1000.00,
                                                          maxHeight: 1300.00,
                                                          imageQuality: 71,
                                                          multiImage: false,
                                                        );
                                                        if (selectedMedia !=
                                                                null &&
                                                            selectedMedia.every((m) =>
                                                                validateFileFormat(
                                                                    m.storagePath,
                                                                    context))) {
                                                          safeSetState(() =>
                                                              _model.isDataUploading_uploadDataTbt501123 =
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
                                                                          bytes:
                                                                              m.bytes,
                                                                          height: m
                                                                              .dimensions
                                                                              ?.height,
                                                                          width: m
                                                                              .dimensions
                                                                              ?.width,
                                                                          blurHash:
                                                                              m.blurHash,
                                                                        ))
                                                                    .toList();
                                                          } finally {
                                                            _model.isDataUploading_uploadDataTbt501123 =
                                                                false;
                                                          }
                                                          if (selectedUploadedFiles
                                                                  .length ==
                                                              selectedMedia
                                                                  .length) {
                                                            safeSetState(() {
                                                              _model.uploadedLocalFile_uploadDataTbt501123 =
                                                                  selectedUploadedFiles
                                                                      .first;
                                                            });
                                                          } else {
                                                            safeSetState(() {});
                                                            return;
                                                          }
                                                        }

                                                        _model.qq = await actions
                                                            .uploadFileAndConvertToBase64toList(
                                                          _model
                                                              .uploadedLocalFile_uploadDataTbt501123,
                                                        );
                                                        if (!functions
                                                            .imageNull(
                                                                _model.qq!)) {
                                                          FFAppState()
                                                              .addToPhotos(
                                                                  _model.qq!);
                                                          safeSetState(() {});
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      text: 'Медиафайл',
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        size: 15,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.95,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(24, 0,
                                                                    24, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 0),
                                                        iconColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                        elevation: 3,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(
                                                        SizedBox(height: 15))
                                                    .addToStart(
                                                        SizedBox(height: 15))
                                                    .addToEnd(
                                                        SizedBox(height: 15)),
                                              );
                                            }
                                          },
                                        ),
                                        Builder(
                                          builder: (context) {
                                            if (!FFAppState().isEdited) {
                                              return Builder(
                                                builder: (context) {
                                                  if (valueOrDefault<String>(
                                                        functions
                                                            .jsonToStringCopy(
                                                                getJsonField(
                                                          FFAppState().account,
                                                          r'''$.role''',
                                                        )),
                                                        '-',
                                                      ) ==
                                                      '\"engineer\"') {
                                                    return Visibility(
                                                      visible: (functions
                                                                  .statusRequest(
                                                                      getJsonField(
                                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()) !=
                                                              'Закрыта') &&
                                                          (functions.statusRequest(
                                                                  getJsonField(
                                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()) !=
                                                              'Выполнен'),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11.5,
                                                                    0, 11.5, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isEdited =
                                                                true;
                                                            safeSetState(() {});
                                                            _model.photos123 =
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.files''',
                                                              true,
                                                            )!
                                                                    .toList()
                                                                    .cast<
                                                                        dynamic>();
                                                            safeSetState(() {});
                                                          },
                                                          text: 'Редактировать',
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.95,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (valueOrDefault<
                                                          String>(
                                                        functions
                                                            .jsonToStringCopy(
                                                                getJsonField(
                                                          FFAppState().account,
                                                          r'''$.role''',
                                                        )),
                                                        '-',
                                                      ) ==
                                                      '\"admin\"') {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          FFAppState()
                                                              .isEdited = true;
                                                          safeSetState(() {});
                                                          _model.photos123 =
                                                              getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.files''',
                                                            true,
                                                          )!
                                                                  .toList()
                                                                  .cast<
                                                                      dynamic>();
                                                          safeSetState(() {});
                                                        },
                                                        text: 'Редактировать',
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.95,
                                                          height: 40,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (valueOrDefault<
                                                          String>(
                                                        functions
                                                            .jsonToStringCopy(
                                                                getJsonField(
                                                          FFAppState().account,
                                                          r'''$.role''',
                                                        )),
                                                        '-',
                                                      ) ==
                                                      '\"performer\"') {
                                                    return Visibility(
                                                      visible: functions
                                                              .statusRequest(
                                                                  getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.status''',
                                                          ).toString()) ==
                                                          'В работе',
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11.5,
                                                                    0, 11.5, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isEdited =
                                                                true;
                                                            safeSetState(() {});
                                                            _model.photos123 =
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.files''',
                                                              true,
                                                            )!
                                                                    .toList()
                                                                    .cast<
                                                                        dynamic>();
                                                            safeSetState(() {});
                                                          },
                                                          text: 'Редактировать',
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.95,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (valueOrDefault<
                                                          String>(
                                                        functions
                                                            .jsonToStringCopy(
                                                                getJsonField(
                                                          FFAppState().account,
                                                          r'''$.role''',
                                                        )),
                                                        '-',
                                                      ) ==
                                                      '\"director\"') {
                                                    return Visibility(
                                                      visible: functions
                                                              .statusRequest(
                                                                  getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.status''',
                                                          ).toString()) ==
                                                          'Открыта',
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(11.5,
                                                                    0, 11.5, 0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            FFAppState()
                                                                    .isEdited =
                                                                true;
                                                            safeSetState(() {});
                                                            _model.photos123 =
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.files''',
                                                              true,
                                                            )!
                                                                    .toList()
                                                                    .cast<
                                                                        dynamic>();
                                                            safeSetState(() {});
                                                          },
                                                          text: 'Редактировать',
                                                          icon: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.95,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                            elevation: 0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(11.5, 0, 11.5, 0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    var _shouldSetState = false;
                                                    _model.apiRes =
                                                        await UpdateDefectsByIdCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: getJsonField(
                                                        detailedDefectsOfflineGetDefectsByIDResponse
                                                            .jsonBody,
                                                        r'''$.id''',
                                                      ),
                                                      bodyJson:
                                                          EditDefectStruct(
                                                        files: functions
                                                            .combineArraysfiles(
                                                                FFAppState()
                                                                    .photos
                                                                    .map((e) =>
                                                                        FilesStruct.maybeFromMap(
                                                                            getJsonField(
                                                                          e,
                                                                          r'''$''',
                                                                        )))
                                                                    .withoutNulls
                                                                    .toList(),
                                                                _model.photos123
                                                                    .map((e) =>
                                                                        FilesStruct.maybeFromMap(
                                                                            getJsonField(
                                                                          e,
                                                                          r'''$''',
                                                                        )))
                                                                    .withoutNulls
                                                                    .toList()),
                                                      ).toMap(),
                                                    );

                                                    _shouldSetState = true;
                                                    if ((_model.apiRes
                                                            ?.succeeded ??
                                                        true)) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Дефект успешно отредактирован!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            (_model.apiRes
                                                                        ?.jsonBody ??
                                                                    '')
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                        ),
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    FFAppState().isEdited =
                                                        false;
                                                    FFAppState().photos = [];
                                                    safeSetState(() {});
                                                    _model.photos123 =
                                                        getJsonField(
                                                      detailedDefectsOfflineGetDefectsByIDResponse
                                                          .jsonBody,
                                                      r'''$.files''',
                                                      true,
                                                    )!
                                                            .toList()
                                                            .cast<dynamic>();
                                                    safeSetState(() {});
                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  text: 'Сохранить',
                                                  options: FFButtonOptions(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.95,
                                                    height: 40,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 16, 0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    elevation: 0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.55,
                                          decoration: BoxDecoration(),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 0),
                                                  child: FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetDefectsCommentByIDCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: widget!.id,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      final columnGetDefectsCommentByIDResponse =
                                                          snapshot.data!;

                                                      return Builder(
                                                        builder: (context) {
                                                          final comment =
                                                              getJsonField(
                                                            columnGetDefectsCommentByIDResponse
                                                                .jsonBody,
                                                            r'''$''',
                                                          ).toList();

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                    comment
                                                                        .length,
                                                                    (commentIndex) {
                                                              final commentItem =
                                                                  comment[
                                                                      commentIndex];
                                                              return Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              15,
                                                                              0,
                                                                              15,
                                                                              0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                decoration: BoxDecoration(),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Text(
                                                                                        '${getJsonField(
                                                                                          commentItem,
                                                                                          r'''$.author_info.first_name''',
                                                                                        ).toString()} ${getJsonField(
                                                                                          commentItem,
                                                                                          r'''$.author_info.last_name''',
                                                                                        ).toString()}',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 14,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.normal,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    if (getJsonField(
                                                                                      commentItem,
                                                                                      r'''$.recommendation''',
                                                                                    ))
                                                                                      Text(
                                                                                        'Рекомендация',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: Color(0xFFD3A625),
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.normal,
                                                                                            ),
                                                                                      ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  functions.removePTags(getJsonField(
                                                                                    commentItem,
                                                                                    r'''$.content''',
                                                                                  ).toString()),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        fontSize: 16,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                decoration: BoxDecoration(),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                      ),
                                                                                      child: Text(
                                                                                        getJsonField(
                                                                                          commentItem,
                                                                                          r'''$.author_info.company_info.title''',
                                                                                        ).toString(),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              fontSize: 12,
                                                                                              letterSpacing: 0.0,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        await showModalBottomSheet(
                                                                                          isScrollControlled: true,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          enableDrag: false,
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                FocusScope.of(context).unfocus();
                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                              },
                                                                                              child: Padding(
                                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                                child: Container(
                                                                                                  height: MediaQuery.sizeOf(context).height * 0.3,
                                                                                                  child: EditcommentWidget(
                                                                                                    id: widget!.id!,
                                                                                                    index: getJsonField(
                                                                                                      commentItem,
                                                                                                      r'''$.id''',
                                                                                                    ),
                                                                                                    title: functions.removePTags(getJsonField(
                                                                                                      commentItem,
                                                                                                      r'''$.content''',
                                                                                                    ).toString()),
                                                                                                    recommend: getJsonField(
                                                                                                      commentItem,
                                                                                                      r'''$.recommendation''',
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ).then((value) => safeSetState(() {}));
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.keyboard_control,
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        size: 24,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 3)),
                                                                          ),
                                                                        ].addToStart(SizedBox(height: 10)).addToEnd(SizedBox(height: 10)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                                .divide(
                                                                    SizedBox(
                                                                        height:
                                                                            10))
                                                                .addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            10)),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) =>
                                                      FFButtonWidget(
                                                    onPressed: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: AlignmentDirectional(
                                                                    0, 0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(
                                                                        dialogContext)
                                                                    .unfocus();
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                              },
                                                              child: Container(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.3,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.95,
                                                                child:
                                                                    AddCommentCopyWidget(
                                                                  id: widget!
                                                                      .id!,
                                                                  title: '',
                                                                  recommendation:
                                                                      false,
                                                                  isedit: false,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    text:
                                                        'Оставить комментарий',
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.95,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.05,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 16, 0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: Colors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      elevation: 0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.65,
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 15, 0, 0),
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: GetDefectsHistoryByIDCall
                                                  .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: widget!.id,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final columnGetDefectsHistoryByIDResponse =
                                                    snapshot.data!;

                                                return Builder(
                                                  builder: (context) {
                                                    final history =
                                                        getJsonField(
                                                      columnGetDefectsHistoryByIDResponse
                                                          .jsonBody,
                                                      r'''$''',
                                                    ).toList();

                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                                history.length,
                                                                (historyIndex) {
                                                          final historyItem =
                                                              history[
                                                                  historyIndex];
                                                          return Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                              child: Container(
                                                                width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
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
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              15,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5,
                                                                                0,
                                                                                5,
                                                                                0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      historyItem,
                                                                                      r'''$.title''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'SFProText',
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 16,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Text(
                                                                                          '${getJsonField(
                                                                                            historyItem,
                                                                                            r'''$.author_info.first_name''',
                                                                                          ).toString()} ${getJsonField(
                                                                                            historyItem,
                                                                                            r'''$.author_info.last_name''',
                                                                                          ).toString()}',
                                                                                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                fontSize: 14,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        ),
                                                                                        child: Text(
                                                                                          getJsonField(
                                                                                            historyItem,
                                                                                            r'''$.author_info.company_info.title''',
                                                                                          ).toString(),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                fontSize: 12,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.calendar_today,
                                                                                        color: Color(0xFF87898F),
                                                                                        size: 15,
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1, -1),
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "d.M.y H:mm",
                                                                                            functions.stringToDateTime(getJsonField(
                                                                                              historyItem,
                                                                                              r'''$.created_on''',
                                                                                            ).toString()),
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: Color(0xFF87898F),
                                                                                                fontSize: 14,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 3)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 5)),
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .addToStart(SizedBox(
                                                                          height:
                                                                              10))
                                                                      .addToEnd(SizedBox(
                                                                          height:
                                                                              10)),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                            .divide(SizedBox(
                                                                height: 10))
                                                            .addToEnd(SizedBox(
                                                                height: 10)),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    decoration: BoxDecoration(),
                    child: Builder(
                      builder: (context) {
                        if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'Подрядчик назначен') &&
                            (valueOrDefault<String>(
                                  functions.jsonToStringCopy(getJsonField(
                                    FFAppState().account,
                                    r'''$.role''',
                                  )),
                                  '-',
                                ) ==
                                '\"admin\"')) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.apiResultss9 =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'contractor_accept',
                                        ).toMap(),
                                      );

                                      if (!(_model.apiResultss9?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.apiResultss9?.jsonBody ??
                                                      '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Принять',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
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
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if (((functions.statusRequest(getJsonField(
                                      detailedDefectsOfflineGetDefectsByIDResponse
                                          .jsonBody,
                                      r'''$.status''',
                                    ).toString()) ==
                                    'У исполнителя') ||
                                (functions.statusRequest(getJsonField(
                                      detailedDefectsOfflineGetDefectsByIDResponse
                                          .jsonBody,
                                      r'''$.status''',
                                    ).toString()) ==
                                    'Открыта')) &&
                            ((valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) ==
                                    '\"performer\"') ||
                                (valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) ==
                                    '\"engineer\"'))) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.apiResultss9Copy123 =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'in_progress',
                                        ).toMap(),
                                      );

                                      if (!(_model
                                              .apiResultss9Copy123?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.apiResultss9Copy123
                                                          ?.jsonBody ??
                                                      '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Начать',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'В работе') &&
                            ((valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) ==
                                    '\"performer\"') ||
                                (valueOrDefault<String>(
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
                                    '\"engineer\"'))) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Выбор подрядчика'),
                                                    content: Text(
                                                        'Вы уверены что хотите выполнить заявку?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Отменить'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Выбрать'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        _model.apiResusdsdf =
                                            await UpdateDefectsByIdCall.call(
                                          access: currentAuthenticationToken,
                                          id: getJsonField(
                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                .jsonBody,
                                            r'''$.id''',
                                          ),
                                          bodyJson: RequestStruct(
                                            status: 'completed',
                                          ).toMap(),
                                        );

                                        if (!(_model.apiResusdsdf?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                (_model.apiResusdsdf
                                                            ?.jsonBody ??
                                                        '')
                                                    .toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }
                                      } else {
                                        context.safePop();
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Выполнена',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: Color(0xFF51B48A),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'На проверке') &&
                            (valueOrDefault<String>(
                                  functions.jsonToStringCopy(getJsonField(
                                    FFAppState().account,
                                    r'''$.role''',
                                  )),
                                  '-',
                                ) ==
                                '\"engineer\"')) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.aaaa =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'completed',
                                        ).toMap(),
                                      );

                                      if (!(_model.aaaa?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.aaaa?.jsonBody ?? '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Подтвердить',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
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
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (functions.emptyList(getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.performers''',
                                        true,
                                      ))!) {
                                        _model.apiResuldfsdfsss =
                                            await UpdateDefectsByIdCall.call(
                                          access: currentAuthenticationToken,
                                          id: getJsonField(
                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                .jsonBody,
                                            r'''$.id''',
                                          ),
                                          bodyJson: RequestStruct(
                                            status: 'open',
                                          ).toMap(),
                                        );

                                        if (!(_model
                                                .apiResuldfsdfsss?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                (_model.apiResuldfsdfsss
                                                            ?.jsonBody ??
                                                        '')
                                                    .toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }
                                      } else {
                                        _model.apiResuldfsdfsss1 =
                                            await UpdateDefectsByIdCall.call(
                                          access: currentAuthenticationToken,
                                          id: getJsonField(
                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                .jsonBody,
                                            r'''$.id''',
                                          ),
                                          bodyJson: RequestStruct(
                                            status: 'at_performer',
                                          ).toMap(),
                                        );

                                        if (!(_model
                                                .apiResuldfsdfsss1?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                (_model.apiResuldfsdfsss1
                                                            ?.jsonBody ??
                                                        '')
                                                    .toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Отклонить работу',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: FlutterFlowTheme.of(context).error,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
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
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'Выполнен') &&
                            ((valueOrDefault<String>(
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
                                    '\"director\"'))) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.aaaaa =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'closed',
                                        ).toMap(),
                                      );

                                      if (!(_model.aaaaa?.succeeded ?? true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.aaaaa?.jsonBody ?? '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Закрыть',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color: Color(0xFF30AE67),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
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
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'Открыта') &&
                            (valueOrDefault<String>(
                                  functions.jsonToStringCopy(getJsonField(
                                    FFAppState().account,
                                    r'''$.role''',
                                  )),
                                  '-',
                                ) ==
                                '\"admin\"')) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.apiResultss9CopyCopy =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'under_review',
                                        ).toMap(),
                                      );

                                      if (!(_model.apiResultss9CopyCopy
                                              ?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.apiResultss9CopyCopy
                                                          ?.jsonBody ??
                                                      '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Отправить на проверку',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else if ((functions.statusRequest(getJsonField(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                  r'''$.status''',
                                ).toString()) ==
                                'Принят подрядчиком') &&
                            ((valueOrDefault<String>(
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
                                    '\"engineer\"'))) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.apiResultss9Copy1Copy =
                                          await UpdateDefectsByIdCall.call(
                                        access: currentAuthenticationToken,
                                        id: getJsonField(
                                          detailedDefectsOfflineGetDefectsByIDResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ),
                                        bodyJson: RequestStruct(
                                          status: 'in_progress',
                                        ).toMap(),
                                      );

                                      if (!(_model.apiResultss9Copy1Copy
                                              ?.succeeded ??
                                          true)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              (_model.apiResultss9Copy1Copy
                                                          ?.jsonBody ??
                                                      '')
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 2000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Начать',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.95,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 10)),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
