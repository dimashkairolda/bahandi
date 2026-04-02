import 'package:Etry/video_player/video_player_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/editcomment_widget.dart';
import '/defects/add_comment_copy/add_comment_copy_widget.dart';
import '/defects/choose_user/choose_user_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/inspections/checkboxes_show/checkboxes_show_widget.dart';
import '/inspections/date_show/date_show_widget.dart';
import '/inspections/diapason_show/diapason_show_widget.dart';
import '/inspections/instruction/instruction_widget.dart';
import '/inspections/iz_spiska_show/iz_spiska_show_widget.dart';
import '/inspections/radio_defect_show/radio_defect_show_widget.dart';
import '/inspections/short_text_show/short_text_show_widget.dart';
import '/inspections/zamery_show/zamery_show_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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

  String _extractObjectTitle(dynamic objectInfo) {
    if (objectInfo is Map<String, dynamic>) {
      final title = objectInfo['title']?.toString();
      if (title != null && title.isNotEmpty && title != 'null') {
        return title;
      }
    }
    if (objectInfo is List && objectInfo.isNotEmpty) {
      final first = objectInfo.first;
      if (first is Map<String, dynamic>) {
        final title = first['title']?.toString();
        if (title != null && title.isNotEmpty && title != 'null') {
          return title;
        }
      }
    }
    return '-';
  }

  String _defectAreaTitle(dynamic body) {
    final fromEquipment = getJsonField(
      body,
      r'''$.equipment_info.area_info.title''',
    )?.toString();
    if (fromEquipment != null &&
        fromEquipment.isNotEmpty &&
        fromEquipment != 'null') {
      return fromEquipment;
    }
    final fromRequest = getJsonField(
      body,
      r'''$.area_info.title''',
    )?.toString();
    if (fromRequest != null && fromRequest.isNotEmpty && fromRequest != 'null') {
      return fromRequest;
    }
    return '-';
  }

  String _defectObjectTitle(dynamic body) {
    final equipmentObj = getJsonField(
      body,
      r'''$.equipment_info.area_info.object_info''',
    );
    final equipmentTitle = _extractObjectTitle(equipmentObj);
    if (equipmentTitle != '-') {
      return equipmentTitle;
    }
    final requestObj = getJsonField(
      body,
      r'''$.area_info.object_info''',
    );
    return _extractObjectTitle(requestObj);
  }

  String _defectEquipmentTitle(dynamic body) {
    final equipmentTitle = getJsonField(
      body,
      r'''$.equipment_info.title''',
    )?.toString();
    if (equipmentTitle != null &&
        equipmentTitle.isNotEmpty &&
        equipmentTitle != 'null') {
      return equipmentTitle;
    }
    return '-';
  }

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

    _model.nameTextController1 ??= TextEditingController();
    _model.nameFocusNode1 ??= FocusNode();

    _model.sumTextController1 ??= TextEditingController();
    _model.sumFocusNode1 ??= FocusNode();

    _model.nameTextController2 ??= TextEditingController();
    _model.nameFocusNode2 ??= FocusNode();

    _model.attributeTextController ??= TextEditingController();
    _model.attributeFocusNode ??= FocusNode();

    _model.sumTextController2 ??= TextEditingController();
    _model.sumFocusNode2 ??= FocusNode();
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
        id: widget.id,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
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
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF3466E7),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.goNamed(
                    DefectsWidget.routeName,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.rightToLeft,
                      ),
                    },
                  );
                },
              ),
              title: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Информация о заявке',
                  kkText: 'Өтінім туралы ақпарат',
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
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
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        11.5, 0.0, 11.5, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: RichText(
                                                  textScaler:
                                                      MediaQuery.of(context)
                                                          .textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '№',
                                                        style: TextStyle(),
                                                      ),
                                                      TextSpan(
                                                        text: getJsonField(
                                                          detailedDefectsOfflineGetDefectsByIDResponse
                                                              .jsonBody,
                                                          r'''$.id''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        11.5, 0.0, 11.5, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
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
                                                        fontSize: 17.0,
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
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
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
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'SFProText',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.0,
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
                                ]
                                    .divide(SizedBox(height: 5.0))
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
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
                                alignment: Alignment(0.0, 0),
                                child: FlutterFlowButtonTabBar(
                                  useToggleButtonStyle: false,
                                  isScrollable: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  unselectedLabelStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                          ),
                                  labelColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderWidth: 0.0,
                                  borderRadius: 12.0,
                                  elevation: 0.0,
                                  labelPadding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 0.0),
                                  tabs: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Icon(
                                            Icons.list_alt,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Информация',
                                            kkText: 'Ақпарат',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Icon(
                                            Icons.check_circle_outline_outlined,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Работы',
                                            kkText: 'Жұмыстар',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.boxOpen,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'ТМЦ',
                                            kkText: 'ТМҚ',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.paperclip,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Вложения',
                                            kkText: 'Медиа',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Icon(
                                            Icons.comment_sharp,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Комментарии',
                                            kkText: 'Пікірлер',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Icon(
                                            Icons.history_sharp,
                                            size: 20.0,
                                          ),
                                        ),
                                        Tab(
                                          text: FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'История',
                                            kkText: 'Тарих',
                                          ),
                                        ),
                                      ],
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
                                        _model.photos123 = functions
                                            .jsonToList(getJsonField(
                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                  .jsonBody,
                                              r'''$.files''',
                                            ))
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
                                              // Generated code for this Container Widget...
// Generated code for this Container Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(11.5, 8, 11.5, 0),
  child: Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.list_alt_sharp,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 20,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Text(
                    FFLocalizations.of(context).getVariableText(
                      ruText: 'Информация о заявке',
                      kkText: 'Өтінім туралы ақпарат',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          fontSize: 16,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                            ruText: 'Описание проблемы',
                            kkText: 'Мәселе сипаттамасы',
                          ),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: RichText(
                            textScaler: MediaQuery.of(context).textScaler,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: valueOrDefault<String>(
                                    getJsonField(
                                      detailedDefectsOfflineGetDefectsByIDResponse
                                          .jsonBody,
                                      r'''$.title''',
                                    )?.toString(),
                                    '-',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            decoration: BoxDecoration(),
            child: // Generated code for this Row Widget...
Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
      },
      text: 'Низкий',
      options: FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 0.27,
        height: MediaQuery.sizeOf(context).height * 0.04,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: getJsonField(
                  detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                  r'''$.priority_request''',
                ).toString() ==
                'low'
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).secondary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'SFProText',
              color: getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.priority_request''',
                      ).toString() ==
                      'low'
                  ? FlutterFlowTheme.of(context).secondary
                  : FlutterFlowTheme.of(context).primaryText,
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
      onPressed: () {
        print('Button pressed ...');
      },
      text: 'Средний',
      options: FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 0.27,
        height: MediaQuery.sizeOf(context).height * 0.04,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: getJsonField(
                  detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                  r'''$.priority_request''',
                ).toString() ==
                'medium'
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).secondary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'SFProText',
              color: getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.priority_request''',
                      ).toString() ==
                      'medium'
                  ? FlutterFlowTheme.of(context).secondary
                  : FlutterFlowTheme.of(context).primaryText,
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
    FFButtonWidget(
      onPressed: () {
        print('Button pressed ...');
      },
      text: 'Высокий',
      options: FFButtonOptions(
        width: MediaQuery.sizeOf(context).width * 0.27,
        height: MediaQuery.sizeOf(context).height * 0.04,
        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: getJsonField(
                  detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                  r'''$.priority_request''',
                ).toString() ==
                'high'
            ? FlutterFlowTheme.of(context).primary
            : FlutterFlowTheme.of(context).secondary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'SFProText',
              color: getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.priority_request''',
                      ).toString() ==
                      'high'
                  ? FlutterFlowTheme.of(context).secondary
                  : FlutterFlowTheme.of(context).primaryText,
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
          Divider(
            thickness: 2,
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Text(
                        'Оборудование',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .bodySmall
                            .override(
                              fontFamily: 'SFProText',
                              color:
                                  FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final equipmentId = castToType<int>(getJsonField(
                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                    r'''$.equipment_info.id''',
                  ));
                  if (equipmentId == null) {
                    return;
                  }
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
                        equipmentId,
                        ParamType.int,
                      ),
                    }.withoutNulls,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _defectEquipmentTitle(
                                  detailedDefectsOfflineGetDefectsByIDResponse
                                      .jsonBody,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      fontSize: 15,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Штрих-код: ',
                                style: TextStyle(),
                              ),
                              TextSpan(
                                text: valueOrDefault<String>(
                                  getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.equipment_info.inventory_number''',
                                  )?.toString(),
                                  '-',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              )
                            ],
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 16,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.75,
                              decoration: BoxDecoration(),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: _defectAreaTitle(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: TextStyle(),
                                    ),
                                    TextSpan(
                                      text: _defectObjectTitle(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 13,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 5)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Text(
                              FFLocalizations.of(context).getVariableText(
                                ruText: 'Создал',
                                kkText: 'Автор',
                              ),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Text(
                        '${getJsonField(
                          detailedDefectsOfflineGetDefectsByIDResponse
                              .jsonBody,
                          r'''$.author_info.first_name''',
                        ).toString()} ${getJsonField(
                          detailedDefectsOfflineGetDefectsByIDResponse
                              .jsonBody,
                          r'''$.author_info.last_name''',
                        ).toString()}',
                        style:
                            FlutterFlowTheme.of(context).bodyLarge.override(
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
              Container(
                width: MediaQuery.sizeOf(context).width * 0.4,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Text(
                              'Дата создания',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Text(
                        dateTimeFormat(
                          "d.M.y H:m",
                          functions.stringToDateTime(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.created_on''',
                          ).toString()),
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        style: FlutterFlowTheme.of(context)
                            .bodyLarge
                            .override(
                              fontFamily: 'SFProText',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14,
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
          if ((getJsonField(
                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                    r'''$.contractors_info''',
                  ) !=
                  null) ||
              (functions
                      .jsonToList(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.performers_info''',
                      ))
                      .length >
                  0))
            Divider(
              thickness: 2,
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
          if (getJsonField(
                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                r'''$.contractors_info''',
              ) !=
              null)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                          child: Text(
                            'Подрядчик',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text(
                          valueOrDefault<String>(
                            getJsonField(
                              detailedDefectsOfflineGetDefectsByIDResponse
                                  .jsonBody,
                              r'''$.contractors_info.title''',
                            )?.toString(),
                            '-',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
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
          if (functions
                  .jsonToList(getJsonField(
                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                    r'''$.performers_info''',
                  ))
                  .length >
              0)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                          child: Text(
                            'Назначено',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Text(
                          '${getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.performers_info[0].first_name''',
                          ).toString()} ${getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.performers_info[0].last_name''',
                          ).toString()}',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
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
          if (((functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'Открыта') ||
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'У исполнителя') ||
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'Отклонена') ||
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'В работе')) &&
              (valueOrDefault<String>(
                    functions.jsonToStringCopy(getJsonField(
                      FFAppState().account,
                      r'''$.role''',
                    )),
                    '-',
                  ) ==
                  '\"engineer\"'))
            FFButtonWidget(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: ChooseUserWidget(
                          json: detailedDefectsOfflineGetDefectsByIDResponse
                              .jsonBody,
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              text: 'Назначить исполнителя',
              icon: Icon(
                Icons.person_add,
                size: 15,
              ),
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.04,
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconColor: FlutterFlowTheme.of(context).primary,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.readexPro(
                        fontWeight: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                elevation: 0,
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ].divide(SizedBox(height: 15)),
      ),
    ),
  ),
),

                                              if ((getJsonField(
                                                        detailedDefectsOfflineGetDefectsByIDResponse
                                                            .jsonBody,
                                                        r'''$.form_result''',
                                                      ) !=
                                                      null) &&
                                                  (functions
                                                          .jsonToList(
                                                              getJsonField(
                                                            detailedDefectsOfflineGetDefectsByIDResponse
                                                                .jsonBody,
                                                            r'''$.form_result''',
                                                          ))
                                                          .length !=
                                                      0))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          11.5, 8.0, 11.5, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  15.0,
                                                                  16.0,
                                                                  15.0),
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
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .checklist_outlined,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 20.0,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    'Чеклист проверки',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          fontSize:
                                                                              16.0,
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
                                                          Builder(
                                                            builder: (context) {
                                                              final questions =
                                                                  (getJsonField(
                                                                        detailedDefectsOfflineGetDefectsByIDResponse
                                                                            .jsonBody,
                                                                        r'''$.form_result''',
                                                                        true,
                                                                      )?.toList().map<FormResultStruct?>(FormResultStruct.maybeFromMap).toList()
                                                                              as Iterable<FormResultStruct?>)
                                                                          .withoutNulls
                                                                          .toList() ??
                                                                      [];

                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: List.generate(
                                                                        questions
                                                                            .length,
                                                                        (questionsIndex) {
                                                                  final questionsItem =
                                                                      questions[
                                                                          questionsIndex];
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          if (questionsItem.type ==
                                                                              functions.stringToJson('\"radio_defect\"').toString()) {
                                                                            return RadioDefectShowWidget(
                                                                              key: Key('Keyup6_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"checkbox\"').toString()) {
                                                                            return CheckboxesShowWidget(
                                                                              key: Key('Key0ir_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"radio\"').toString()) {
                                                                            return IzSpiskaShowWidget(
                                                                              key: Key('Keyi5s_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"instruction\"').toString()) {
                                                                            return InstructionWidget(
                                                                              key: Key('Key7vk_${questionsIndex}_of_${questions.length}'),
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"date\"').toString()) {
                                                                            return DateShowWidget(
                                                                              key: Key('Keyqaq_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"measurement\"').toString()) {
                                                                            return ZameryShowWidget(
                                                                              key: Key('Keym55_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"range\"').toString()) {
                                                                            return DiapasonShowWidget(
                                                                              key: Key('Keyua8_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else if (questionsItem.type == functions.stringToJson('\"short_text\"').toString()) {
                                                                            return ShortTextShowWidget(
                                                                              key: Key('Keyqqh_${questionsIndex}_of_${questions.length}'),
                                                                              index: questionsIndex,
                                                                              data: questionsItem.toMap(),
                                                                            );
                                                                          } else {
                                                                            return Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.657,
                                                                              decoration: BoxDecoration(),
                                                                              child: Text(
                                                                                'Ошибка! Пожалуйста обратитесь к администратору!',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.readexPro(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  );
                                                                })
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            5.0))
                                                                    .addToStart(
                                                                        SizedBox(
                                                                            height:
                                                                                10.0))
                                                                    .addToEnd(SizedBox(
                                                                        height:
                                                                            10.0)),
                                                              );
                                                            },
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 15.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ].addToEnd(SizedBox(height:60.0)),
                                          ),
                                        ]
                                            .divide(SizedBox(height: 20.0))
                                            .addToEnd(SizedBox(height: 150.0)),
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          if (FFAppState().works.length > 0)
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  10.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Text(
                                                        'Список работ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                    Builder(
                                                      builder: (context) {
                                                        final works =
                                                            FFAppState()
                                                                .works
                                                                .toList();

                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  works.length,
                                                                  (worksIndex) {
                                                            final worksItem =
                                                                works[
                                                                    worksIndex];
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.7,
                                                                    height:
                                                                        50.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  worksItem.title,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        color: FlutterFlowTheme.of(context).primaryText,
                                                                                        fontSize: 15.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              39.0,
                                                                          height:
                                                                              39.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
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
                                                                  if (((functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'Закрыта') &&
                                                                          (functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'На проверке') &&
                                                                          (functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'Отклонена') &&
                                                                          (valueOrDefault<String>(
                                                                                functions.jsonToStringCopy(getJsonField(
                                                                                  FFAppState().account,
                                                                                  r'''$.role''',
                                                                                )),
                                                                                '-',
                                                                              ) ==
                                                                              '\"engineer\"')) ||
                                                                      ((functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'Закрыта') &&
                                                                          (functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'На проверке') &&
                                                                          (functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) !=
                                                                              'Отклонена') &&
                                                                          (valueOrDefault<String>(
                                                                                functions.jsonToStringCopy(getJsonField(
                                                                                  FFAppState().account,
                                                                                  r'''$.role''',
                                                                                )),
                                                                                '-',
                                                                              ) ==
                                                                              '\"admin\"')) ||
                                                                      ((functions.statusRequest(getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.status''',
                                                                              ).toString()) ==
                                                                              'В работе') &&
                                                                          (valueOrDefault<String>(
                                                                                functions.jsonToStringCopy(getJsonField(
                                                                                  FFAppState().account,
                                                                                  r'''$.role''',
                                                                                )),
                                                                                '-',
                                                                              ) ==
                                                                              '\"performer\"')) ||
                                                                      (((functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) ==
                                                                                  'В работе') ||
                                                                              (functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) ==
                                                                                  'Выполнен')) &&
                                                                          (valueOrDefault<String>(
                                                                                functions.jsonToStringCopy(getJsonField(
                                                                                  FFAppState().account,
                                                                                  r'''$.role''',
                                                                                )),
                                                                                '-',
                                                                              ) ==
                                                                              '\"technician\"')))
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
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
                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: Text('Удаление'),
                                                                                    content: Text('Вы точно хотите удалить работы?'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                        child: Text('Отмена'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                        child: Text('Удалить'),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ) ??
                                                                              false;
                                                                          if (confirmDialogResponse) {
                                                                            FFAppState().removeAtIndexFromWorks(worksIndex);
                                                                            safeSetState(() {});
                                                                            _model.apiResur =
                                                                                await UpdateDefectsByIdCall.call(
                                                                              access: currentAuthenticationToken,
                                                                              id: getJsonField(
                                                                                detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                r'''$.id''',
                                                                              ),
                                                                              bodyJson: EditDefectStruct(
                                                                                works: FFAppState().works,
                                                                                files: (getJsonField(
                                                                                  detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                  r'''$.files''',
                                                                                  true,
                                                                                )?.toList().map<FilesStruct?>(FilesStruct.maybeFromMap).toList() as Iterable<FilesStruct?>)
                                                                                    .withoutNulls,
                                                                              ).toMap(),
                                                                            );
                                                                          }

                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .delete_forever,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          size:
                                                                              24.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                        );
                                                      },
                                                    ),
                                                  ].addToEnd(
                                                      SizedBox(height: 5.0)),
                                                ),
                                              ),
                                            ),
                                          // Generated code for this Container Widget...
Padding(
  padding: EdgeInsets.all(8),
  child: Container(
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 50,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.build_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'Добавить работу',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Название работы',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: Color(0xFF87898F),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.nameTextController1,
                        focusNode: _model.nameFocusNode1,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          hintText: 'Например: Замена предохранителя ',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        validator: _model.nameTextController1Validator
                            .asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Количество работы',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: Color(0xFF87898F),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.sumTextController1,
                        focusNode: _model.sumFocusNode1,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          hintText: '0',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        validator: _model.sumTextController1Validator
                            .asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ].divide(SizedBox(height: 5)),
            ),
          ),
          if (((functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'Закрыта') &&
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'На проверке') &&
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'Отклонена') &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"engineer\"')) ||
              ((functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'Закрыта') &&
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'На проверке') &&
                  (functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) !=
                      'Отклонена') &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"admin\"')) ||
              ((functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'В работе') &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"performer\"')) ||
              (((functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) ==
                          'В работе') ||
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) ==
                          'Выполнен')) &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"technician\"')))
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if ((_model.nameTextController1.text != null &&
                        _model.nameTextController1.text != '') &&
                    (_model.sumTextController1.text != null &&
                        _model.sumTextController1.text != '')) {
                  FFAppState().addToWorks(WorksStruct(
                    title: _model.nameTextController1.text,
                    amount: int.tryParse(_model.sumTextController1.text),
                  ));
                  FFAppState().update(() {});
                  _model.apiResultg8zCopy = await UpdateDefectsByIdCall.call(
                    access: currentAuthenticationToken,
                    id: getJsonField(
                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                      r'''$.id''',
                    ),
                    bodyJson: EditDefectStruct(
                      works: FFAppState().works,
                      files: (getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.files''',
                        true,
                      )
                              ?.toList()
                              .map<FilesStruct?>(FilesStruct.maybeFromMap)
                              .toList() as Iterable<FilesStruct?>)
                          .withoutNulls,
                    ).toMap(),
                  );
                  safeSetState(() {
                    _model.nameTextController1?.clear();
                    _model.sumTextController1?.clear();
                  });
                }
                safeSetState(() {});
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Text(
                        'Добавить работу',
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ].divide(SizedBox(height: 5)),
      ),
    ),
  ),
)

                                        ].addToEnd(SizedBox(height: 100.0)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (FFAppState().spareparts.length >
                                                0)
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
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
                                                                .fromSTEB(
                                                                    16.0,
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Text(
                                                          'Список материалов',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 17.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Builder(
                                                          builder: (context) {
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
                                                                    spareparts[
                                                                        sparepartsIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.7,
                                                                        height:
                                                                            50.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Text(
                                                                                      sparepartsItem.title,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'SFProText',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: 15.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Text(
                                                                                      sparepartsItem.model,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'SFProText',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 39.0,
                                                                              height: 39.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  sparepartsItem.amount.toString(),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      if (((functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'Закрыта') &&
                                                                              (functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'На проверке') &&
                                                                              (functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'Отклонена') &&
                                                                              (valueOrDefault<String>(
                                                                                    functions.jsonToStringCopy(getJsonField(
                                                                                      FFAppState().account,
                                                                                      r'''$.role''',
                                                                                    )),
                                                                                    '-',
                                                                                  ) ==
                                                                                  '\"engineer\"')) ||
                                                                          ((functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'Закрыта') &&
                                                                              (functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'На проверке') &&
                                                                              (functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) !=
                                                                                  'Отклонена') &&
                                                                              (valueOrDefault<String>(
                                                                                    functions.jsonToStringCopy(getJsonField(
                                                                                      FFAppState().account,
                                                                                      r'''$.role''',
                                                                                    )),
                                                                                    '-',
                                                                                  ) ==
                                                                                  '\"admin\"')) ||
                                                                          ((functions.statusRequest(getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.status''',
                                                                                  ).toString()) ==
                                                                                  'В работе') &&
                                                                              (valueOrDefault<String>(
                                                                                    functions.jsonToStringCopy(getJsonField(
                                                                                      FFAppState().account,
                                                                                      r'''$.role''',
                                                                                    )),
                                                                                    '-',
                                                                                  ) ==
                                                                                  '\"performer\"')) ||
                                                                          (((functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) ==
                                                                                      'В работе') ||
                                                                                  (functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) ==
                                                                                      'Выполнен')) &&
                                                                              (valueOrDefault<String>(
                                                                                    functions.jsonToStringCopy(getJsonField(
                                                                                      FFAppState().account,
                                                                                      r'''$.role''',
                                                                                    )),
                                                                                    '-',
                                                                                  ) ==
                                                                                  '\"technician\"')))
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
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
                                                                              var confirmDialogResponse = await showDialog<bool>(
                                                                                    context: context,
                                                                                    builder: (alertDialogContext) {
                                                                                      return AlertDialog(
                                                                                        title: Text('Удаление'),
                                                                                        content: Text('Вы точно хотите удалить ТМЦ?'),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                            child: Text('Отмена '),
                                                                                          ),
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                            child: Text('Удалить'),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  ) ??
                                                                                  false;
                                                                              if (confirmDialogResponse) {
                                                                                FFAppState().removeAtIndexFromSpareparts(sparepartsIndex);
                                                                                safeSetState(() {});
                                                                                _model.apiResur2 = await UpdateDefectsByIdCall.call(
                                                                                  access: currentAuthenticationToken,
                                                                                  id: getJsonField(
                                                                                    detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                    r'''$.id''',
                                                                                  ),
                                                                                  bodyJson: EditDefectStruct(
                                                                                    spareParts: FFAppState().spareparts,
                                                                                    files: (getJsonField(
                                                                                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                      r'''$.files''',
                                                                                      true,
                                                                                    )?.toList().map<FilesStruct?>(FilesStruct.maybeFromMap).toList() as Iterable<FilesStruct?>)
                                                                                        .withoutNulls,
                                                                                  ).toMap(),
                                                                                );
                                                                              }

                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.delete_forever,
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            // Generated code for this Container Widget...
Padding(
  padding: EdgeInsets.all(8),
  child: Container(
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 50,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FaIcon(
                    FontAwesomeIcons.boxOpen,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Text(
                      'Добавить материал',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 17,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Название ТМЦ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: Color(0xFF87898F),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.nameTextController2,
                        focusNode: _model.nameFocusNode2,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          hintText: 'Например: Предохранитель 10A',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        validator: _model.nameTextController2Validator
                            .asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Артикул',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: Color(0xFF87898F),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.attributeTextController,
                        focusNode: _model.attributeFocusNode,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          hintText: '00002045',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        validator: _model.attributeTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Количество ТМЦ',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            color: Color(0xFF87898F),
                            letterSpacing: 0.0,
                          ),
                    ),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(),
                      child: TextFormField(
                        controller: _model.sumTextController2,
                        focusNode: _model.sumFocusNode2,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          hintText: '0',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'SFProText',
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        validator: _model.sumTextController2Validator
                            .asValidator(context),
                      ),
                    ),
                  ].divide(SizedBox(height: 5)),
                ),
              ].divide(SizedBox(height: 5)),
            ),
          ),
          if ((((functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'Закрыта') &&
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'На проверке') &&
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'Отклонена')) &&
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
                          '\"admin\"'))) ||
              ((functions.statusRequest(getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.status''',
                      ).toString()) ==
                      'В работе') &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"performer\"') &&
                  ((functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'Закрыта') &&
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'На проверке') &&
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) !=
                          'Отклонена'))) ||
              (((functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) ==
                          'В работе') ||
                      (functions.statusRequest(getJsonField(
                            detailedDefectsOfflineGetDefectsByIDResponse
                                .jsonBody,
                            r'''$.status''',
                          ).toString()) ==
                          'Выполнен')) &&
                  (valueOrDefault<String>(
                        functions.jsonToStringCopy(getJsonField(
                          FFAppState().account,
                          r'''$.role''',
                        )),
                        '-',
                      ) ==
                      '\"technician\"')))
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if ((_model.nameTextController2.text != null &&
                        _model.nameTextController2.text != '') &&
                    (_model.sumTextController2.text != null &&
                        _model.sumTextController2.text != '')) {
                  FFAppState().addToSpareparts(TmcStruct(
                    title: _model.nameTextController2.text,
                    amount: int.tryParse(_model.sumTextController2.text),
                    model: _model.attributeTextController.text,
                  ));
                  FFAppState().update(() {});
                  _model.wewe = await UpdateDefectsByIdCall.call(
                    access: currentAuthenticationToken,
                    id: getJsonField(
                      detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                      r'''$.id''',
                    ),
                    bodyJson: EditDefectStruct(
                      spareParts: FFAppState().spareparts,
                      files: (getJsonField(
                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                        r'''$.files''',
                        true,
                      )
                              ?.toList()
                              .map<FilesStruct?>(FilesStruct.maybeFromMap)
                              .toList() as Iterable<FilesStruct?>)
                          .withoutNulls,
                    ).toMap(),
                  );
                  safeSetState(() {
                    _model.nameTextController2?.clear();
                    _model.attributeTextController?.clear();
                    _model.sumTextController2?.clear();
                  });
                }
                safeSetState(() {});
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Text(
                        'Добавить ТМЦ',
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ].divide(SizedBox(height: 5)),
      ),
    ),
  ),
)

                                          ].addToEnd(SizedBox(height: 100.0)),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 5.0,
                                                                16.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        FaIcon(
                                                          FontAwesomeIcons
                                                              .paperclip,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 20.0,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Добавить вложение',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      17.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
                                                                    0.0,
                                                                    11.5,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final files = _model
                                                                .photos123
                                                                .toList();

                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  files.length,
                                                                  (filesIndex) {
                                                                final filesItem =
                                                                    files[
                                                                        filesIndex];
                                                                return Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          115.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.05,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.025,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Visibility(
                                                                          visible: ((functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'Закрыта') &&
                                                                                  (functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'На проверке') &&
                                                                                  (functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'Отклонена') &&
                                                                                  (valueOrDefault<String>(
                                                                                        functions.jsonToStringCopy(getJsonField(
                                                                                          FFAppState().account,
                                                                                          r'''$.role''',
                                                                                        )),
                                                                                        '-',
                                                                                      ) ==
                                                                                      '\"engineer\"')) ||
                                                                              ((functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'Закрыта') &&
                                                                                  (functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'На проверке') &&
                                                                                  (functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) !=
                                                                                      'Отклонена') &&
                                                                                  (valueOrDefault<String>(
                                                                                        functions.jsonToStringCopy(getJsonField(
                                                                                          FFAppState().account,
                                                                                          r'''$.role''',
                                                                                        )),
                                                                                        '-',
                                                                                      ) ==
                                                                                      '\"admin\"')) ||
                                                                              ((functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                        r'''$.status''',
                                                                                      ).toString()) ==
                                                                                      'В работе') &&
                                                                                  (valueOrDefault<String>(
                                                                                        functions.jsonToStringCopy(getJsonField(
                                                                                          FFAppState().account,
                                                                                          r'''$.role''',
                                                                                        )),
                                                                                        '-',
                                                                                      ) ==
                                                                                      '\"performer\"')) ||
                                                                              ((functions.statusRequest(getJsonField(
                                                                                        detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
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
                                                                                      '\"director\"')) ||
                                                                              (((functions.statusRequest(getJsonField(
                                                                                            detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                            r'''$.status''',
                                                                                          ).toString()) ==
                                                                                          'В работе') ||
                                                                                      (functions.statusRequest(getJsonField(
                                                                                            detailedDefectsOfflineGetDefectsByIDResponse.jsonBody,
                                                                                            r'''$.status''',
                                                                                          ).toString()) ==
                                                                                          'Выполнен')) &&
                                                                                  (valueOrDefault<String>(
                                                                                        functions.jsonToStringCopy(getJsonField(
                                                                                          FFAppState().account,
                                                                                          r'''$.role''',
                                                                                        )),
                                                                                        '-',
                                                                                      ) ==
                                                                                      '\"technician\"')),
                                                                          child:
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
                                                                              _model.removeAtIndexFromPhotos123(filesIndex);
                                                                              safeSetState(() {});
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              Icons.close,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Builder(
                      builder: (context) {
                        if ((functions.getFileExtension(getJsonField(
                                  filesItem,
                                  r'''$.url''',
                                ).toString()) ==
                                'MOV') ||
                            (functions.getFileExtension(getJsonField(
                                  filesItem,
                                  r'''$.url''',
                                ).toString()) ==
                                'mp4')) {
                          return Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  VideoPlayerWidget.routeName,
                                  queryParameters: {
                                    'url': serializeParam(
                                      getJsonField(
                                        filesItem,
                                        r'''$.url''',
                                      ).toString(),
                                      ParamType.String,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                child: Stack(
                                  children: [
                                    FlutterFlowVideoPlayer(
                                      path:
                                          'https://app.etry.kz${getJsonField(
                                        filesItem,
                                        r'''$.url''',
                                      ).toString()}',
                                      videoType: VideoType.network,
                                      width:
                                          MediaQuery.sizeOf(context).width *
                                              0.3,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.15,
                                      autoPlay: false,
                                      looping: false,
                                      showControls: false,
                                      allowFullScreen: false,
                                      allowPlaybackSpeedMenu: false,
                                      lazyLoad: false,
                                      pauseOnNavigate: false,
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.network(
                                      'https://app.etry.kz${getJsonField(
                                        filesItem,
                                        r'''$.url''',
                                      ).toString()}',
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag:
                                        'https://app.etry.kz${getJsonField(
                                      filesItem,
                                      r'''$.url''',
                                    ).toString()}',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'https://app.etry.kz${getJsonField(
                                filesItem,
                                r'''$.url''',
                              ).toString()}',
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://app.etry.kz${getJsonField(
                                    filesItem,
                                    r'''$.url''',
                                  ).toString()}',
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.3,
                                  height: MediaQuery.sizeOf(context).height *
                                      0.15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                      },
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
                                                                0.0, 0.0),
                                                        child: Builder(
                                                          builder: (context) {
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
                                                                  fotki.length,
                                                                  (fotkiIndex) {
                                                                final fotkiItem =
                                                                    fotki[
                                                                        fotkiIndex];
                                                                return Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondary,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if ((functions.getFileExtension(getJsonField(
                                                                                      fotkiItem,
                                                                                      r'''$.url''',
                                                                                    ).toString()) ==
                                                                                    'MOV') ||
                                                                                (functions.getFileExtension(getJsonField(
                                                                                      fotkiItem,
                                                                                      r'''$.url''',
                                                                                    ).toString()) ==
                                                                                    'mp4')) {
                                                                              return FlutterFlowVideoPlayer(
                                                                                path: 'https://app.etry.kz${getJsonField(
                                                                                  fotkiItem,
                                                                                  r'''$.url''',
                                                                                ).toString()}',
                                                                                videoType: VideoType.network,
                                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                height: MediaQuery.sizeOf(context).height * 0.15,
                                                                                autoPlay: false,
                                                                                looping: false,
                                                                                showControls: true,
                                                                                allowFullScreen: true,
                                                                                allowPlaybackSpeedMenu: false,
                                                                                lazyLoad: true,
                                                                              );
                                                                            } else {
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  await Navigator.push(
                                                                                    context,
                                                                                    PageTransition(
                                                                                      type: PageTransitionType.fade,
                                                                                      child: FlutterFlowExpandedImageView(
                                                                                        image: Image.network(
                                                                                          'https://app.etry.kz${getJsonField(
                                                                                            fotkiItem,
                                                                                            r'''$.url''',
                                                                                          ).toString()}',
                                                                                          fit: BoxFit.contain,
                                                                                        ),
                                                                                        allowRotation: false,
                                                                                        tag: 'https://app.etry.kz${getJsonField(
                                                                                          fotkiItem,
                                                                                          r'''$.url''',
                                                                                        ).toString()}',
                                                                                        useHeroAnimation: true,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                child: Hero(
                                                                                  tag: 'https://app.etry.kz${getJsonField(
                                                                                    fotkiItem,
                                                                                    r'''$.url''',
                                                                                  ).toString()}',
                                                                                  transitionOnUserGestures: true,
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                    child: Image.network(
                                                                                      'https://app.etry.kz${getJsonField(
                                                                                        fotkiItem,
                                                                                        r'''$.url''',
                                                                                      ).toString()}',
                                                                                      width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.15,
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          115.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
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
                                                                          FFAppState()
                                                                              .removeAtIndexFromPhotos(fotkiIndex);
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.05,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.025,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              }).divide(
                                                                  SizedBox(
                                                                      width:
                                                                          5.0)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (((functions.statusRequest(
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
                                                            'На проверке') &&
                                                        (functions.statusRequest(
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.status''',
                                                            ).toString()) !=
                                                            'Отклонена') &&
                                                        (valueOrDefault<String>(
                                                              functions
                                                                  .jsonToStringCopy(
                                                                      getJsonField(
                                                                FFAppState()
                                                                    .account,
                                                                r'''$.role''',
                                                              )),
                                                              '-',
                                                            ) ==
                                                            '\"engineer\"')) ||
                                                    ((functions.statusRequest(
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
                                                            'На проверке') &&
                                                        (functions.statusRequest(
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.status''',
                                                            ).toString()) !=
                                                            'Отклонена') &&
                                                        (valueOrDefault<String>(
                                                              functions
                                                                  .jsonToStringCopy(
                                                                      getJsonField(
                                                                FFAppState()
                                                                    .account,
                                                                r'''$.role''',
                                                              )),
                                                              '-',
                                                            ) ==
                                                            '\"admin\"')) ||
                                                    ((functions.statusRequest(
                                                                getJsonField(
                                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                                  .jsonBody,
                                                              r'''$.status''',
                                                            ).toString()) ==
                                                            'В работе') &&
                                                        (valueOrDefault<String>(
                                                              functions
                                                                  .jsonToStringCopy(
                                                                      getJsonField(
                                                                FFAppState()
                                                                    .account,
                                                                r'''$.role''',
                                                              )),
                                                              '-',
                                                            ) ==
                                                            '\"performer\"')) ||
                                                    (((functions.statusRequest(
                                                                    getJsonField(
                                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                                      .jsonBody,
                                                                  r'''$.status''',
                                                                ).toString()) ==
                                                                'В работе') ||
                                                            (functions.statusRequest(
                                                                    getJsonField(
                                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                                      .jsonBody,
                                                                  r'''$.status''',
                                                                ).toString()) ==
                                                                'Выполнен')) &&
                                                        (valueOrDefault<String>(
                                                              functions
                                                                  .jsonToStringCopy(
                                                                      getJsonField(
                                                                FFAppState()
                                                                    .account,
                                                                r'''$.role''',
                                                              )),
                                                              '-',
                                                            ) ==
                                                            '\"technician\"')))
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
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
                                                            safeSetState(() {
                                                              _model.isDataUploading_uploadD1112 =
                                                                  false;
                                                              _model.uploadedLocalFile_uploadD1112 =
                                                                  FFUploadedFile(
                                                                      bytes: Uint8List
                                                                          .fromList(
                                                                              []),
                                                                      originalFilename:
                                                                          '');
                                                            });

                                                            final selectedMedia =
                                                                await selectMedia(
                                                              maxWidth: 1000.00,
                                                              maxHeight:
                                                                  1300.00,
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
                                                                  _model.isDataUploading_uploadD1112 =
                                                                      true);
                                                              var selectedUploadedFiles =
                                                                  <FFUploadedFile>[];

                                                              try {
                                                                selectedUploadedFiles =
                                                                    selectedMedia
                                                                        .map((m) =>
                                                                            FFUploadedFile(
                                                                              name: m.storagePath.split('/').last,
                                                                              bytes: m.bytes,
                                                                              height: m.dimensions?.height,
                                                                              width: m.dimensions?.width,
                                                                              blurHash: m.blurHash,
                                                                              originalFilename: m.originalFilename,
                                                                            ))
                                                                        .toList();
                                                              } finally {
                                                                _model.isDataUploading_uploadD1112 =
                                                                    false;
                                                              }
                                                              if (selectedUploadedFiles
                                                                      .length ==
                                                                  selectedMedia
                                                                      .length) {
                                                                safeSetState(
                                                                    () {
                                                                  _model.uploadedLocalFile_uploadD1112 =
                                                                      selectedUploadedFiles
                                                                          .first;
                                                                });
                                                              } else {
                                                                safeSetState(
                                                                    () {});
                                                                return;
                                                              }
                                                            }

                                                            _model.tet =
                                                                await PostFilesCall
                                                                    .call(
                                                              access:
                                                                  currentAuthenticationToken,
                                                              content: _model
                                                                  .uploadedLocalFile_uploadD1112,
                                                            );

                                                            FFAppState()
                                                                .addToPhotos(
                                                                    getJsonField(
                                                              (_model.tet
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$[0]''',
                                                            ));
                                                            FFAppState()
                                                                .update(() {});
                                                            _model.apiResultg8zCo =
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
                                                                fileIds: (functions
                                                                        .combineArrays(FFAppState().photos.toList(), _model.photos123.toList())
                                                                        .map((e) => getJsonField(
                                                                              e,
                                                                              r'''$.id''',
                                                                            ))
                                                                        .toList())
                                                                    .cast<int>(),
                                                              ).toMap(),
                                                            );

                                                            safeSetState(() {});
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      4.0,
                                                                  color: Color(
                                                                      0x33000000),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    2.0,
                                                                  ),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.photo_camera,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'Фото',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
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
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
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
                                                            await requestPermission(
                                                                microphonePermission);
                                                            _model.rer =
                                                                await actions
                                                                    .pickCameraVideo();
                                                            _model.asas =
                                                                await PostFilesCall
                                                                    .call(
                                                              access:
                                                                  currentAuthenticationToken,
                                                              content:
                                                                  _model.rer,
                                                            );

                                                            FFAppState()
                                                                .addToPhotos(
                                                                    getJsonField(
                                                              (_model.asas
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$[0]''',
                                                            ));
                                                            FFAppState()
                                                                .update(() {});
                                                            _model.apiResultg8zCopy12 =
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
                                                                fileIds: (functions
                                                                        .combineArrays(FFAppState().photos.toList(), _model.photos123.toList())
                                                                        .map((e) => getJsonField(
                                                                              e,
                                                                              r'''$.id''',
                                                                            ))
                                                                        .toList())
                                                                    .cast<int>(),
                                                              ).toMap(),
                                                            );

                                                            safeSetState(() {});
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      4.0,
                                                                  color: Color(
                                                                      0x33000000),
                                                                  offset:
                                                                      Offset(
                                                                    0.0,
                                                                    2.0,
                                                                  ),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          12.0,
                                                                          0.0,
                                                                          12.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          FaIcon(
                                                                            FontAwesomeIcons.video,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              'Видео',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
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
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ]
                                                  .divide(
                                                      SizedBox(height: 15.0))
                                                  .addToEnd(
                                                      SizedBox(height: 15.0)),
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
                                              0.55,
                                          decoration: BoxDecoration(),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 15.0, 0.0, 0.0),
                                                  child: FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetDefectsCommentByIDCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: widget.id,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
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
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          15.0,
                                                                          0.0),
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
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
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
                                                                                              fontSize: 14.0,
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
                                                                                              fontSize: 12.0,
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
                                                                                        fontSize: 16.0,
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
                                                                                              fontSize: 12.0,
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
                                                                                                    id: widget.id!,
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
                                                                                        size: 24.0,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 3.0)),
                                                                          ),
                                                                        ].addToStart(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 10.0)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                                .divide(SizedBox(
                                                                    height:
                                                                        10.0))
                                                                .addToEnd(SizedBox(
                                                                    height:
                                                                        10.0)),
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
                                                                    0.0, 0.0)
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
                                                                    0.35,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.95,
                                                                child:
                                                                    AddCommentCopyWidget(
                                                                  id: widget
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
                                                        FFLocalizations.of(
                                                                context)
                                                            .getVariableText(
                                                          ruText:
                                                              'Оставить комментарий',
                                                          kkText:
                                                              'Пікір қалдыру',
                                                        ),
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
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
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
                                                      elevation: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
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
                                                    0.0, 15.0, 0.0, 0.0),
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: GetDefectsHistoryByIDCall
                                                  .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: widget.id,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
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
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
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
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
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
                                                                                5.0,
                                                                                0.0,
                                                                                5.0,
                                                                                0.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    getJsonField(
                                                                                      historyItem,
                                                                                      r'''$.title''',
                                                                                    ).toString(),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'SFProText',
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 16.0,
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
                                                                                                fontSize: 14.0,
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
                                                                                                fontSize: 12.0,
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
                                                                                        size: 15.0,
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, -1.0),
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
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ].divide(SizedBox(height: 3.0)),
                                                                            ),
                                                                          ),
                                                                        ].divide(SizedBox(width: 5.0)),
                                                                      ),
                                                                    ),
                                                                  ]
                                                                      .addToStart(SizedBox(
                                                                          height:
                                                                              10.0))
                                                                      .addToEnd(SizedBox(
                                                                          height:
                                                                              10.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                            .divide(SizedBox(
                                                                height: 10.0))
                                                            .addToEnd(SizedBox(
                                                                height: 10.0)),
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
                        if (valueOrDefault<String>(
                              functions.jsonToStringCopy(getJsonField(
                                FFAppState().account,
                                r'''$.role''',
                              )),
                              '-',
                            ) ==
                            '\"admin\"') {
                          return Builder(
                            builder: (context) {
                              if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Подрядчик назначен') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResultss9 =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'contractor_accept',
                                              ).toMap(),
                                            );

                                            if (!(_model
                                                    .apiResultss9?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResultss9
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Принять',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'В работе') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
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
                                                              child: Text(
                                                                  'Отменить'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Выбрать'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              _model.apiResusdsdf =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'completed',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResusdsdf
                                                      ?.succeeded ??
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF51B48A),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Открыта') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResultss9CopyCopy =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Отправить на проверку',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Принят подрядчиком') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResultss9Copy1Copy =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Начать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(),
                                );
                              }
                            },
                          );
                        } else if (valueOrDefault<String>(
                              functions.jsonToStringCopy(getJsonField(
                                FFAppState().account,
                                r'''$.role''',
                              )),
                              '-',
                            ) ==
                            '\"performer\"') {
                          return Builder(
                            builder: (context) {
                              if ((functions.statusRequest(getJsonField(
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
                                      'Открыта')) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResultss9Copy123 =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'at_performer',
                                              ).toMap(),
                                            );

                                            if (!(_model.apiResultss9Copy123
                                                    ?.succeeded ??
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Начать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'В работе') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
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
                                                              child: Text(
                                                                  'Отменить'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Выбрать'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              _model.apiResusdsdfz =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'completed',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResusdsdfz
                                                      ?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      (_model.apiResusdsdfz
                                                                  ?.jsonBody ??
                                                              '')
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF51B48A),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(),
                                );
                              }
                            },
                          );
                        } else if (valueOrDefault<String>(
                              functions.jsonToStringCopy(getJsonField(
                                FFAppState().account,
                                r'''$.role''',
                              )),
                              '-',
                            ) ==
                            '\"engineer\"') {
                          return Builder(
                            builder: (context) {
                              if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'На проверке') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaa =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'completed',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaa?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaa?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Подтвердить',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (functions
                                                .emptyList(getJsonField(
                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                  .jsonBody,
                                              r'''$.performers''',
                                              true,
                                            ))!) {
                                              _model.apiResuldfsdfsss =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'open',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResuldfsdfsss
                                                      ?.succeeded ??
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            } else {
                                              _model.apiResuldfsdfsss1 =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'at_performer',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResuldfsdfsss1
                                                      ?.succeeded ??
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Отклонить работу',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Выполнен') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaaa =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'closed',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaaa?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaaa?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Закрыть',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF30AE67),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResul =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'rejected',
                                              ).toMap(),
                                            );

                                            if (!(_model.apiResul?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResul
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Отказать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Принят подрядчиком') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiRe =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'in_progress',
                                              ).toMap(),
                                            );

                                            if (!(_model.apiRe?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiRe?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Начать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Открыта') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResu =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'completed',
                                              ).toMap(),
                                            );

                                            if (!(_model.apiResu?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResu?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Выполнить',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaaa1 =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'closed',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaaa1?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaaa1?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Закрыть',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF30AE67),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if ((functions.statusRequest(getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.status''',
                                      ).toString()) ==
                                      'В работе') ||
                                  (functions.statusRequest(getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.status''',
                                      ).toString()) ==
                                      'У исполнителя')) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaaaaaa =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'closed',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaaaaaa?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaaaaaa
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Закрыть',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF30AE67),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(),
                                );
                              }
                            },
                          );
                        } else if (valueOrDefault<String>(
                              functions.jsonToStringCopy(getJsonField(
                                FFAppState().account,
                                r'''$.role''',
                              )),
                              '-',
                            ) ==
                            '\"director\"') {
                          return Builder(
                            builder: (context) {
                              if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Выполнен') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaaaasd =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'closed',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaaaasd?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaaaasd
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Закрыть',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF30AE67),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (functions
                                                .emptyList(getJsonField(
                                              detailedDefectsOfflineGetDefectsByIDResponse
                                                  .jsonBody,
                                              r'''$.performers''',
                                              true,
                                            ))!) {
                                              _model.apiResuldfsdfsssas =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'open',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResuldfsdfsssas
                                                      ?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      (_model.apiResuldfsdfsssas
                                                                  ?.jsonBody ??
                                                              '')
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            } else {
                                              _model.apiResuldfsdfs =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'at_performer',
                                                ).toMap(),
                                              );

                                              if (!(_model.apiResuldfsdfs
                                                      ?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      (_model.apiResuldfsdfs
                                                                  ?.jsonBody ??
                                                              '')
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Отклонить работу',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(),
                                );
                              }
                            },
                          );
                        } else if (valueOrDefault<String>(
                              functions.jsonToStringCopy(getJsonField(
                                FFAppState().account,
                                r'''$.role''',
                              )),
                              '-',
                            ) ==
                            '\"technician\"') {
                          return Builder(
                            builder: (context) {
                              if (functions.statusRequest(getJsonField(
                                    detailedDefectsOfflineGetDefectsByIDResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()) ==
                                  'Открыта') {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiResultss9Copy123q =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'at_performer',
                                                performers: functions.inttolist(
                                                    functions.stringToInt(
                                                        functions
                                                            .jsonToStringCopy(
                                                                getJsonField(
                                                  FFAppState().account,
                                                  r'''$.id''',
                                                )))!),
                                              ).toMap(),
                                            );

                                            if (!(_model.apiResultss9Copy123q
                                                    ?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiResultss9Copy123q
                                                                ?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Принять',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if ((functions.statusRequest(getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.status''',
                                      ).toString()) ==
                                      'У исполнителя') &&
                                  functions.containsInt(
                                      (getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.performers''',
                                        true,
                                      ) as List?)
                                          ?.cast<int>(),
                                      functions.stringToInt(functions
                                          .jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.id''',
                                      )))!)) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.aaaasd =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'in_progress',
                                              ).toMap(),
                                            );

                                            if (!(_model.aaaasd?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.aaaasd?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Начать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.apiR =
                                                await UpdateDefectsByIdCall
                                                    .call(
                                              access:
                                                  currentAuthenticationToken,
                                              id: getJsonField(
                                                detailedDefectsOfflineGetDefectsByIDResponse
                                                    .jsonBody,
                                                r'''$.id''',
                                              ),
                                              bodyJson: RequestStruct(
                                                status: 'rejected',
                                              ).toMap(),
                                            );

                                            if (!(_model.apiR?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    (_model.apiR?.jsonBody ??
                                                            '')
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Отказать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else if ((functions.statusRequest(getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.status''',
                                      ).toString()) ==
                                      'В работе') &&
                                  functions.containsInt(
                                      (getJsonField(
                                        detailedDefectsOfflineGetDefectsByIDResponse
                                            .jsonBody,
                                        r'''$.performers''',
                                        true,
                                      ) as List?)
                                          ?.cast<int>(),
                                      functions.stringToInt(functions
                                          .jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.id''',
                                      )))!)) {
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0.0, 11.5, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
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
                                                              child: Text(
                                                                  'Отменить'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Выбрать'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              _model.ap =
                                                  await UpdateDefectsByIdCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  detailedDefectsOfflineGetDefectsByIDResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ),
                                                bodyJson: RequestStruct(
                                                  status: 'completed',
                                                ).toMap(),
                                              );

                                              if (!(_model.ap?.succeeded ??
                                                  true)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      (_model.ap?.jsonBody ??
                                                              '')
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 2000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.95,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFF51B48A),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                    ),
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 10.0)),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(),
                                );
                              }
                            },
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
