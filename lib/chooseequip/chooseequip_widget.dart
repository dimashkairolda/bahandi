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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'chooseequip_model.dart';
export 'chooseequip_model.dart';

class ChooseequipWidget extends StatefulWidget {
  const ChooseequipWidget({super.key});

  static String routeName = 'chooseequip';
  static String routePath = '/chooseequip';

  @override
  State<ChooseequipWidget> createState() => _ChooseequipWidgetState();
}

class _ChooseequipWidgetState extends State<ChooseequipWidget> {
  late ChooseequipModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseequipModel());

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
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(GetEquipmentsPaginationCall.call(
              access: currentAuthenticationToken,
              page: _model.page,
              search: _model.textController.text != null &&
                      _model.textController.text != ''
                  ? '&search=${_model.textController.text}'
                  : '',
              department:
                  _model.dropDownValue1 != null && _model.dropDownValue1 != ''
                      ? '&deparment=${_model.dropDownValue1}'
                      : '',
              area: _model.dropDownValue2 != null && _model.dropDownValue2 != ''
                  ? '&area=${_model.dropDownValue2}'
                  : '',
            )))
          .future,
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
        final chooseequipGetEquipmentsPaginationResponse = snapshot.data!;

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
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
              title: Text(
                'Парк оборудования',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                () async {
                                  safeSetState(
                                      () => _model.apiRequestCompleter = null);
                                  await _model.waitForApiRequestCompleted();
                                },
                              ),
                              textInputAction: TextInputAction.search,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: false,
                                labelStyle: FlutterFlowTheme.of(context)
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
                                prefixIcon: Icon(
                                  Icons.search_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                                suffixIcon:
                                    _model.textController!.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () async {
                                              _model.textController?.clear();
                                              safeSetState(() => _model
                                                  .apiRequestCompleter = null);
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if ((_model.dropDownValue1 != null &&
                                    _model.dropDownValue1 != '') ||
                                (_model.dropDownValue2 != null &&
                                    _model.dropDownValue2 != ''))
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  safeSetState(() {
                                    _model.dropDownValueController1?.reset();
                                    _model.dropDownValueController2?.reset();
                                  });
                                  safeSetState(
                                      () => _model.apiRequestCompleter = null);
                                  await _model.waitForApiRequestCompleted();
                                },
                                child: Icon(
                                  Icons.close,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24,
                                ),
                              ),
                            if ((valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) !=
                                    '\"admin\"') &&
                                (valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) !=
                                    '\"performer\"'))
                              FutureBuilder<ApiCallResponse>(
                                future: DepartmentsCall.call(
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
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final dropDownDepartmentsResponse =
                                      snapshot.data!;

                                  return FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController1 ??=
                                            FormFieldController<String>(null),
                                    options: List<String>.from((getJsonField(
                                      dropDownDepartmentsResponse.jsonBody,
                                      r'''$.data[:].id''',
                                      true,
                                    ) as List?)!
                                        .map<String>((e) => e.toString())
                                        .toList()
                                        .cast<String>()),
                                    optionLabels: (getJsonField(
                                      dropDownDepartmentsResponse.jsonBody,
                                      r'''$.data[:].title''',
                                      true,
                                    ) as List?)!
                                        .map<String>((e) => e.toString())
                                        .toList()
                                        .cast<String>(),
                                    onChanged: (val) async {
                                      safeSetState(
                                          () => _model.dropDownValue1 = val);
                                      safeSetState(() =>
                                          _model.apiRequestCompleter = null);
                                      await _model.waitForApiRequestCompleted();
                                    },
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: 37,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Подразделение',
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
                            if ((valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) !=
                                    '\"admin\"') &&
                                (valueOrDefault<String>(
                                      functions.jsonToStringCopy(getJsonField(
                                        FFAppState().account,
                                        r'''$.role''',
                                      )),
                                      '-',
                                    ) !=
                                    '\"performer\"'))
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
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final dropDownGetAreaResponse =
                                      snapshot.data!;

                                  return FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController2 ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue2 ??= getJsonField(
                                        dropDownGetAreaResponse.jsonBody,
                                        r'''$.data[0].id''',
                                      ).toString(),
                                    ),
                                    options: List<String>.from((getJsonField(
                                      dropDownGetAreaResponse.jsonBody,
                                      r'''$.data[:].id''',
                                      true,
                                    ) as List?)!
                                        .map<String>((e) => e.toString())
                                        .toList()
                                        .cast<String>()),
                                    optionLabels: (getJsonField(
                                      dropDownGetAreaResponse.jsonBody,
                                      r'''$.data[:].title''',
                                      true,
                                    ) as List?)!
                                        .map<String>((e) => e.toString())
                                        .toList()
                                        .cast<String>(),
                                    onChanged: (val) async {
                                      safeSetState(
                                          () => _model.dropDownValue2 = val);
                                      safeSetState(() =>
                                          _model.apiRequestCompleter = null);
                                      await _model.waitForApiRequestCompleted();
                                    },
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.4,
                                    height: 37,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Участок',
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
                          ].divide(SizedBox(width: 10)),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final equipTRee = getJsonField(
                          chooseequipGetEquipmentsPaginationResponse.jsonBody,
                          r'''$.data''',
                        ).toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(equipTRee.length, (equipTReeIndex) {
                            final equipTReeItem = equipTRee[equipTReeIndex];
                            return Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    CreateDefectWidget.routeName,
                                    queryParameters: {
                                      'equip': serializeParam(
                                        getJsonField(
                                          equipTReeItem,
                                          r'''$.title''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'equipId': serializeParam(
                                        getJsonField(
                                          equipTReeItem,
                                          r'''$.id''',
                                        ),
                                        ParamType.int,
                                      ),
                                      'ispravil': serializeParam(
                                        false,
                                        ParamType.bool,
                                      ),
                                      'priority': serializeParam(
                                        false,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.95,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 14, 8, 14),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              height: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Color(0xFFDCDCDC),
                                                ),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.15,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.15,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: CachedNetworkImage(
                                                  fadeInDuration:
                                                      Duration(milliseconds: 0),
                                                  fadeOutDuration:
                                                      Duration(milliseconds: 0),
                                                  imageUrl:
                                                      'https://magnum.etry.kz${getJsonField(
                                                    equipTReeItem,
                                                    r'''$.img''',
                                                  ).toString()}',
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, error,
                                                          stackTrace) =>
                                                      Image.asset(
                                                    'assets/images/error_image.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.7,
                                                  decoration: BoxDecoration(),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context)
                                                            .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: getJsonField(
                                                            equipTReeItem,
                                                            r'''$.title''',
                                                          ).toString(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'SFProText',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        )
                                                      ],
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'SFProText',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            fontSize: 14,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.7,
                                                  decoration: BoxDecoration(),
                                                  child: RichText(
                                                    textScaler:
                                                        MediaQuery.of(context)
                                                            .textScaler,
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Инвентарный номер:  ',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                fontSize: 13,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                        TextSpan(
                                                          text: valueOrDefault<
                                                              String>(
                                                            getJsonField(
                                                              equipTReeItem,
                                                              r'''$.inventory_number''',
                                                            )?.toString(),
                                                            '-',
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'SFProText',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 13,
                                                          ),
                                                        )
                                                      ],
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 10)),
                                            ),
                                          ].divide(SizedBox(width: 10)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).divide(SizedBox(height: 8)),
                        );
                      },
                    ),
                    Builder(
                      builder: (context) {
                        if (getJsonField(
                              chooseequipGetEquipmentsPaginationResponse
                                  .jsonBody,
                              r'''$.pagination.num_pages''',
                            ) ==
                            functions.stringToJson('1')) {
                          return Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          );
                        } else {
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 8,
                                  buttonSize: 40,
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    if (_model.page >= 2) {
                                      _model.page = _model.page + -1;
                                      safeSetState(() {});
                                    }
                                    safeSetState(() =>
                                        _model.apiRequestCompleter = null);
                                    await _model.waitForApiRequestCompleted();
                                  },
                                ),
                                Text(
                                  '${_model.page.toString()} из ${getJsonField(
                                    chooseequipGetEquipmentsPaginationResponse
                                        .jsonBody,
                                    r'''$.pagination.num_pages''',
                                  ).toString()}',
                                  style: FlutterFlowTheme.of(context)
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
                                ),
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 8,
                                  buttonSize: 40,
                                  icon: Icon(
                                    Icons.navigate_next,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    if (_model.page <
                                        getJsonField(
                                          chooseequipGetEquipmentsPaginationResponse
                                              .jsonBody,
                                          r'''$.pagination.num_pages''',
                                        )) {
                                      _model.page = _model.page + 1;
                                      safeSetState(() {});
                                    }
                                    safeSetState(() =>
                                        _model.apiRequestCompleter = null);
                                    await _model.waitForApiRequestCompleted();
                                  },
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
        );
      },
    );
  }
}
