import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'choose_user_model.dart';
export 'choose_user_model.dart';

class ChooseUserWidget extends StatefulWidget {
  const ChooseUserWidget({
    super.key,
    required this.json,
  });

  final dynamic json;

  @override
  State<ChooseUserWidget> createState() => _ChooseUserWidgetState();
}

class _ChooseUserWidgetState extends State<ChooseUserWidget> {
  late ChooseUserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseUserModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Назначение исполнителя',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'SFProText',
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Выберите исполнителя для выполнения заявки DEF-2024-001',
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
                              )
                            ],
                            style:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Кому назначить',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle:
                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController ??=
                        FormFieldController<String>(
                      _model.dropDownValue ??= 'Техник',
                    ),
                    options: ['Техник', 'Подрядчик'],
                    onChanged: (val) =>
                        safeSetState(() => _model.dropDownValue = val),
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                        ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    elevation: 2.0,
                    borderColor: Colors.transparent,
                    borderWidth: 0.0,
                    borderRadius: 12.0,
                    margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    hidesUnderline: true,
                    isOverButton: false,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                  Builder(
                    builder: (context) {
                      if (_model.dropDownValue == 'Техник') {
                        return FutureBuilder<ApiCallResponse>(
                          future: UsersListCall.call(
                            access: currentAuthenticationToken,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final columnUsersListResponse = snapshot.data!;
      
                            return Builder(
                              builder: (context) {
                                final users = getJsonField(
                                  columnUsersListResponse.jsonBody,
                                  r'''$.data''',
                                ).toList();
      
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(users.length, (usersIndex) {
                                    final usersItem = users[usersIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.chosenId = getJsonField(
                                          usersItem,
                                          r'''$.id''',
                                        );
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width *
                                            1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        decoration: BoxDecoration(
                                          color: getJsonField(
                                                    usersItem,
                                                    r'''$.id''',
                                                  ) ==
                                                  _model.chosenId
                                              ? Color(0xFFD5E7F7)
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.person_outline,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.sizeOf(
                                                                    context)
                                                                .width *
                                                            0.66,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          getJsonField(
                                                            usersItem,
                                                            r'''$.full_name''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                  if (getJsonField(
                                                        usersItem,
                                                        r'''$.id''',
                                                      ) ==
                                                      _model.chosenId)
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_sharp,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                      size: 24.0,
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).divide(SizedBox(height: 5.0)),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return FutureBuilder<ApiCallResponse>(
                          future: GetContractorsCall.call(
                            access: currentAuthenticationToken,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final columnGetContractorsResponse = snapshot.data!;
      
                            return Builder(
                              builder: (context) {
                                final companies = getJsonField(
                                  columnGetContractorsResponse.jsonBody,
                                  r'''$.data''',
                                ).toList();
      
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(companies.length,
                                      (companiesIndex) {
                                    final companiesItem =
                                        companies[companiesIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        _model.chosenId = getJsonField(
                                          companiesItem,
                                          r'''$.id''',
                                        );
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width *
                                            1.0,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.12,
                                        decoration: BoxDecoration(
                                          color: getJsonField(
                                                    companiesItem,
                                                    r'''$.id''',
                                                  ) ==
                                                  _model.chosenId
                                              ? Color(0xFFD5E7F7)
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Icon(
                                                        Icons.person_outline,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width:
                                                                MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.66,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              getJsonField(
                                                                companiesItem,
                                                                r'''$.title''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.66,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              getJsonField(
                                                                companiesItem,
                                                                r'''$.head''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10.0)),
                                                  ),
                                                  if (getJsonField(
                                                        companiesItem,
                                                        r'''$.id''',
                                                      ) ==
                                                      _model.chosenId)
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_sharp,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                      size: 24.0,
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (_model.dropDownValue == 'Техник') {
                        _model.apiResultss9 = await UpdateDefectsByIdCall.call(
                          access: currentAuthenticationToken,
                          id: getJsonField(
                            widget.json,
                            r'''$.id''',
                          ),
                          bodyJson: RequestStruct(
                            performers: functions.inttolist(_model.chosenId!),
                            status: 'at_performer',
                          ).toMap(),
                        );
                      } else {
                        _model.apiResults = await UpdateDefectsByIdCall.call(
                          access: currentAuthenticationToken,
                          id: getJsonField(
                            widget.json,
                            r'''$.id''',
                          ),
                          bodyJson: RequestStruct(
                            contractors: functions.inttolist(_model.chosenId!),
                            status: 'contractor_appointed',
                          ).toMap(),
                        );
                      }
      
                      Navigator.pop(context);
      
                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getVariableText(
                      ruText: 'Назначить исполнителя',
                      kkText: 'Орындаушыны тағайындау',
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                            fontStyle:
                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                          ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)).addToEnd(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
