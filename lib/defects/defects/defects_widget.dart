import 'dart:async';

import 'package:Etry/api/firebase_api.dart';
import 'package:Etry/components/scan_equipment_page.dart';
import 'package:app_badger/app_badger.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/defects/choose_user/choose_user_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' hide Priority;
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

class _DefectsWidgetState extends State<DefectsWidget> with WidgetsBindingObserver {
  late DefectsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  WebSocketChannel? _wsChannel;
  StreamSubscription<dynamic>? _wsSubscription;

  void _connectWebSocket() {
    final token = currentAuthenticationToken;
    if (token == null || token.isEmpty) return;
    _wsSubscription?.cancel();
    _wsSubscription = null;
    try {
      _wsChannel?.sink.close();
    } catch (_) {}
    _wsChannel = null;
    try {
      final uri = Uri.parse('wss://app.etry.kz/ws/notification/')
          .replace(queryParameters: <String, String>{'token': token});
      _wsChannel = WebSocketChannel.connect(uri);
      _wsSubscription = _wsChannel!.stream.listen((_) {
        if (mounted) _refreshDefectsList();
      });
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    // Подписываемся на события жизненного цикла (свернул/развернул)
    WidgetsBinding.instance.addObserver(this); 
    
    FirebaseApi().initNotifications(context);
    _model = createModel(context, () => DefectsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _initialAuthAndLoad();
      _connectWebSocket();
      onUserLogin();
    });
    
  
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _wsSubscription?.cancel();
    _wsSubscription = null;
    try {
      _wsChannel?.sink.close();
    } catch (_) {}
    _wsChannel = null;
    _model.dispose();
    super.dispose();
  }

  // --- FCM Fix: Обновление при возврате в приложение ---
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Приложение вернулось из фона (например, после клика по пушу)
      print('App Resumed - Refreshing Data');
      _refreshDefectsList();
      ViewedNotificationCall.call(
      access: currentAuthenticationToken,
    );
  AppBadger.removeBadge();
      _connectWebSocket();
    }
  }

  // --- Логика Инициализации ---
  Future<void> _initialAuthAndLoad() async {
      if (mounted && _model.defectsItems.isEmpty) {
        safeSetState(() {
          _model.isInitialLoading = true;
          _model.loadErrorMessage = null;
        });
      }
      try {
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
      FFAppState().clearDefectCache();
      await _loadDefects(reset: true);
      ViewedNotificationCall.call(
      access: currentAuthenticationToken,
    );
  AppBadger.removeBadge();
      _connectWebSocket();
      } finally {
        if (mounted) {
          safeSetState(() {
            _model.isInitialLoading = false;
          });
        }
      }
  }

  // --- Функция обновления списка (UI) ---
  void _refreshDefectsList() {
    if (!mounted) return;
    FFAppState().clearDefectCache();
    _loadDefects(reset: true);
  }

 Future onUserLogin() async {
  final account = FFAppState().account;
  if (account == null) return;

  // 1. Извлекаем ID (превращаем в String без лишних .0)
  final dynamic rawId = getJsonField(account, r'''$.id''');
  final String userId = rawId is num ? rawId.toInt().toString() : rawId.toString();

  // 2. Устанавливаем ID пользователя
  await AppMetrica.setUserProfileID(userId);

  // 3. Собираем данные для профиля
  String firstName = getJsonField(account, r'''$.first_name''')?.toString() ?? '';
  String lastName = getJsonField(account, r'''$.last_name''')?.toString() ?? '';
  String fullName = '$firstName $lastName'.trim();

  String userRole = valueOrDefault<String>(
    getJsonField(account, r'''$.role''')?.toString(),
    '-',
  );

  // 4. СОЗДАЕМ ПРОФИЛЬ (согласно вашему исходному коду)
  // В вашей версии AppMetricaUserProfile принимает список атрибутов List<UserProfileAttribute>
  var userProfile = AppMetricaUserProfile([
    // Устанавливаем имя
    AppMetricaNameAttribute.withValue(fullName),
    
    // Устанавливаем кастомную строку для роли
    AppMetricaStringAttribute.withValue('role', userRole),
  ]);

  // 5. Отправляем в AppMetrica
  await AppMetrica.reportUserProfile(userProfile);
  
  print('AppMetrica: Profile updated for $userId ($fullName)');
}

  // ... [ОСТАЛЬНЫЕ ВАШИ МЕТОДЫ: _reLoginAndRefreshToken, _getDefectsWithInterceptor] ...
  // Вставьте сюда ваши методы _reLoginAndRefreshToken и _getDefectsWithInterceptor без изменений
  
  Future<bool> _reLoginAndRefreshToken() async {
    // ... ваш код ...
    try {
      final authResponse = await AuthCall.call(
        username: FFAppState().rememberEmail,
        password: FFAppState().rememberPassword,
      );
      if (authResponse.succeeded) {
        await authManager.signIn(
          authenticationToken: AuthCall.accesstoken(
            authResponse.jsonBody,
          ),
        );
        return true; 
      }
      return false; 
    } catch (e) {
      return false;
    }
  }

  String _defectListDateQuery() {
    if (_model.date == null) return '';
    final s = dateTimeFormat(
      'y-MM-dd',
      _model.date,
      locale: FFLocalizations.of(context).languageCode,
    );
    return '&date[]=$s&date[]=$s';
  }

  Future<ApiCallResponse> _getDefectsWithInterceptor({required int page}) async {
     // ... ваш код ...
     Future<ApiCallResponse> makeRequest() async {
      return GetDefectsAPICall.call(
        access: currentAuthenticationToken, 
        search: _model.textController.text != ''
            ? '&search=${_model.textController.text}'
            : '',
        page: page.toString(),
        date: _defectListDateQuery(),
        department: _model.filialValue != null && _model.filialValue != ''
            ? '&area=${_model.filialValue}'
            : '',
        contractor: _model.contractorValue != null && _model.contractorValue != ''
            ? '&contractor=${_model.contractorValue}'
            : '',
        status: _model.statusValue != null && _model.statusValue != ''
            ? '&status=${_model.statusValue}'
            : '',
        type: _model.typeValue != null && _model.typeValue != ''
            ? '&type=${_model.typeValue}'
            : '',
        criticality: (_model.criticalityFilter != null &&
                _model.criticalityFilter!.isNotEmpty)
            ? '&criticality=${_model.criticalityFilter}'
            : '',
        myRequest:
            _model.myRequestsOnly ? '&my_request=true' : '',
      );
    }

    var response = await makeRequest();
    if (response.statusCode == 401) {
      bool refreshSuccess = await _reLoginAndRefreshToken();
      if (refreshSuccess) {
        response = await makeRequest();
      }
    }
    return response;
  }

  Future<void> _loadDefects({bool reset = false}) async {
    if ((reset && _model.isInitialLoading) ||
        (!reset && _model.isLoadingMore)) {
      return;
    }

    final nextPage = reset ? 1 : (_model.page + 1);
    if (!reset && nextPage > _model.totalPages) {
      return;
    }

    safeSetState(() {
      _model.loadErrorMessage = null;
      if (reset) {
        _model.isInitialLoading = true;
      } else {
        _model.isLoadingMore = true;
      }
    });

    try {
      final response = await _getDefectsWithInterceptor(page: nextPage);
      if (!mounted) return;

      final pageItems =
          getJsonField(response.jsonBody, r'''$.data''').toList();
      final totalPages = valueOrDefault<int>(
        castToType<int>(
          getJsonField(
            response.jsonBody,
            r'''$.pagination.num_pages''',
          ),
        ),
        1,
      );

      final existingIds = reset
          ? <String>{}
          : _model.defectsItems
              .map((item) => getJsonField(item, r'''$.id''')?.toString())
              .whereType<String>()
              .toSet();
      final mergedItems = reset
          ? List<dynamic>.from(pageItems)
          : [
              ..._model.defectsItems,
              ...pageItems.where((item) {
                final id = getJsonField(item, r'''$.id''')?.toString();
                return id == null || !existingIds.contains(id);
              }),
            ];

      safeSetState(() {
        _model.page = nextPage;
        _model.totalPages = totalPages;
        _model.defectsItems = mergedItems;
      });
    } catch (_) {
      if (mounted) {
        safeSetState(() {
          _model.loadErrorMessage =
              FFLocalizations.of(context).getVariableText(
            ruText: 'Ошибка загрузки заявок',
            kkText: 'Өтінімдерді жүктеу қатесі',
          );
        });
      }
    } finally {
      if (mounted) {
        safeSetState(() {
          _model.isInitialLoading = false;
          _model.isLoadingMore = false;
        });
      }
    }
  }

  String _formatSlaDuration(Duration d) {
    if (d.inHours > 0) {
      final mins = d.inMinutes.remainder(60);
      return '${d.inHours}ч ${mins} мин';
    }
    return '${d.inMinutes} мин';
  }

  static String? _nonEmptyField(dynamic v) {
    if (v == null) return null;
    final t = v.toString().trim();
    if (t.isEmpty || t == 'null') return null;
    return t;
  }

  /// Локация: [object_info…] · [area_info.title], из вложенного equipment или корня заявки.
  String _defectAreaLocationText(dynamic item) {
    dynamic areaNode =
        getJsonField(item, r'''$.equipment_info.area_info''');
    final eqNull = areaNode == null ||
        areaNode.toString() == 'null' ||
        (areaNode is Map && areaNode.isEmpty);
    if (eqNull) {
      areaNode = getJsonField(item, r'''$.area_info''');
    }
    if (areaNode == null || areaNode.toString() == 'null') {
      return '';
    }
    if (areaNode is! Map) {
      return '';
    }
    final m = Map<String, dynamic>.from(areaNode);

    final areaTitle = _nonEmptyField(m['title']);
    String? objectTitle;
    final oi = m['object_info'];
    if (oi is List) {
      for (final e in oi) {
        if (e is Map) {
          objectTitle = _nonEmptyField(e['title']);
          if (objectTitle != null) break;
        }
      }
    } else if (oi is Map) {
      objectTitle = _nonEmptyField(oi['title']);
    }

    final parts = <String>[];
    if (objectTitle != null) parts.add(objectTitle);
    if (areaTitle != null) parts.add(areaTitle);
    return parts.join(' · ');
  }

  Widget _buildSlaBadge(dynamic defectsItem) {
    final statusCode =
        getJsonField(defectsItem, r'''$.status''')?.toString() ?? '';
    if (statusCode != 'open') {
      return const SizedBox.shrink();
    }

    final rawTo = getJsonField(defectsItem, r'''$.sla_policy_task_to_datetime''')
        ?.toString();
    if (rawTo == null || rawTo.isEmpty || rawTo == 'null') {
      return const SizedBox.shrink();
    }

    final deadline = DateTime.tryParse(rawTo);
    if (deadline == null) return const SizedBox.shrink();

    final rawClose =
        getJsonField(defectsItem, r'''$.sla_policy_task_close''')?.toString();
    final now = DateTime.now();

    final bool isViolated;
    final Duration diff;

    if (rawClose != null && rawClose.isNotEmpty && rawClose != 'null') {
      return const SizedBox.shrink();
    } else if (now.isAfter(deadline)) {
      isViolated = true;
      diff = now.difference(deadline);
    } else {
      isViolated = false;
      diff = deadline.difference(now);
    }

    final label = isViolated
        ? FFLocalizations.of(context).getVariableText(
            ruText: 'SLA нарушен ${_formatSlaDuration(diff)}',
            kkText: 'SLA бұзылды ${_formatSlaDuration(diff)}',
          )
        : FFLocalizations.of(context).getVariableText(
            ruText: 'SLA активен ${_formatSlaDuration(diff)}',
            kkText: 'SLA белсенді ${_formatSlaDuration(diff)}',
          );

    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: isViolated ? const Color(0xFFEF5350) : const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        label,
        style: FlutterFlowTheme.of(context).bodySmall.override(
              fontFamily: 'SFProText',
              color: Colors.white,
              fontSize: 11.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    if (_model.isInitialLoading && _model.defectsItems.isEmpty) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    if (_model.loadErrorMessage != null && _model.defectsItems.isEmpty) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: Text(_model.loadErrorMessage!),
        ),
      );
    }

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
              iconTheme: IconThemeData(
                  color: FlutterFlowTheme.of(context).secondaryBackground),
              automaticallyImplyLeading: false,
              title: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Заявка на обслуживание',
                  kkText: 'Қызмет көрсету өтінімі',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 4.0,
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    FFAppState().clearDefectCache();
                    await _loadDefects(reset: true);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(ScanEquipmentPageWidget.routeName);
                                },
                                text: FFLocalizations.of(context).getVariableText(
                                  ruText: 'Создать заявку',
                                  kkText: 'Өтінім жасау',
                                ),
                                icon: Icon(
                                  Icons.add,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'SFProText',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.filter_alt,
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 24.0,
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Фильтры',
                                                kkText: 'Сүзгілер',
                                              ),
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 5.0)),
                                        ),
                                        if (_model.isEdited)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                _model.date = null;
                                                safeSetState(() {});
                                                safeSetState(() {
                                                  _model.textController?.clear();
                                                });
                                                safeSetState(() {
                                                  _model.filialValueController
                                                      ?.reset();
                                                  _model.contractorValueController
                                                      ?.reset();
                                                  _model.typeValueController
                                                      ?.reset();
                                                  _model.statusValueController
                                                      ?.reset();
                                                });
                                                FFAppState().clearDefectCache();
                                                await _loadDefects(reset: true);
                                                _model.isEdited = false;
                                                safeSetState(() {});
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Сбросить',
                                                kkText: 'Тазалау',
                                              ),
                                              icon: Icon(
                                                Icons.close,
                                                size: 20.0,
                                              ),
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconAlignment:
                                                    IconAlignment.start,
                                                iconPadding: EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                iconColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'SFProText',
                                                          color:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _model.textController,
                                          focusNode: _model.textFieldFocusNode,
                                          onChanged: (_) => EasyDebounce.debounce(
                                            '_model.textController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              _model.isEdited = true;
                                              safeSetState(() {});
                                              FFAppState().clearDefectCache();
                                              await _loadDefects(reset: true);
                                            },
                                          ),
                                          textInputAction: TextInputAction.done,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: false,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: FFLocalizations.of(context)
                                                .getVariableText(
                                              ruText: 'Поиск',
                                              kkText: 'Іздеу',
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            prefixIcon: Icon(
                                              Icons.search_outlined,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                            ),
                                            suffixIcon: _model.textController!
                                                    .text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model.textController
                                                          ?.clear();
                                                      _model.isEdited = true;
                                                      safeSetState(() {});
                                                      FFAppState()
                                                          .clearDefectCache();
                                                      await _loadDefects(
                                                          reset: true);
                                                      safeSetState(() {});
                                                    },
                                                    child: Icon(
                                                      Icons.clear,
                                                      color: Color(0xFF757575),
                                                      size: 22.0,
                                                    ),
                                                  )
                                                : null,
                                          ),
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
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          maxLines: null,
                                          validator: _model
                                              .textControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .only(start: 4.0, end: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    ruText: 'Мои заявки',
                                                    kkText: 'Менің өтінімдерім',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 11.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                                Switch(
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value: _model.myRequestsOnly,
                                                  onChanged: (v) async {
                                                    safeSetState(() {
                                                      _model.myRequestsOnly = v;
                                                    });
                                                    FFAppState()
                                                        .clearDefectCache();
                                                    await _loadDefects(
                                                        reset: true);
                                                    _model.isEdited = true;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
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
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    headerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    headerTextStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineLarge
                                                            .override(
                                                              font: GoogleFonts
                                                                  .outfit(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme
                                                                        .of(context)
                                                                    .headlineLarge
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 32.0,
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
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                    pickerForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    selectedDateTimeBackgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    selectedDateTimeForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                    actionButtonForegroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    iconSize: 24.0,
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
                                              } else if (_model.datePicked !=
                                                  null) {
                                                safeSetState(() {
                                                  _model.datePicked =
                                                      getCurrentTimestamp;
                                                });
                                              }
                                              _model.date = _model.datePicked;
                                              _model.isEdited = true;
                                              safeSetState(() {});
                                              FFAppState().clearDefectCache();
                                              await _loadDefects(reset: true);
                                            },
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.045,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 5.0, 0.0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        dateTimeFormat(
                                                          "dd.MM.y",
                                                          _model.date,
                                                          locale:
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .languageCode,
                                                        ),
                                                        'Дата',
                                                      ),
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'SFProText',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(SizedBox(width: 5.0))
                                                    .addToStart(
                                                        SizedBox(width: 10.0))
                                                    .addToEnd(
                                                        SizedBox(width: 5.0)),
                                              ),
                                            ),
                                          ),
                                          FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .statusValueController ??=
                                                FormFieldController<String>(null),
                                            options: List<String>.from([
                                              'open',
                                              'at_performer',
                                              'completed',
                                              'rejected',
                                              'closed',
                                            ]),
                                            optionLabels: [
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Открыта',
                                                kkText: 'Ашық',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Назначен исполнитель',
                                                kkText: 'Орындаушы тағайындалды',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Выполнен',
                                                kkText: 'Орындалды',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Отклонена',
                                                kkText: 'Қабылданбады',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Закрыта',
                                                kkText: 'Жабылды',
                                              ),
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(
                                                  () => _model.statusValue = val);
                                              FFAppState().clearDefectCache();
                                              await _loadDefects(reset: true);
                                              _model.isEdited = true;
                                              safeSetState(() {});
                                            },
                                            width:
                                                MediaQuery.sizeOf(context).width *
                                                    0.35,
                                                    
                                            height: 37.0,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText: FFLocalizations.of(context)
                                                .getVariableText(
                                              ruText: 'Статус',
                                              kkText: 'Күйі',
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 15.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            elevation: 2.0,
                                            borderColor: Colors.transparent,
                                            borderWidth: 0.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                          FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .criticalityFilterController ??=
                                                    FormFieldController<String>(
                                                        null),
                                                options: const [
                                                  '',
                                                  'high',
                                                  'medium',
                                                  'low',
                                                ],
                                                optionLabels: [
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    ruText: 'Все',
                                                    kkText: 'Барлығы',
                                                  ),
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    ruText: 'Высокая',
                                                    kkText: 'Жоғары',
                                                  ),
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    ruText: 'Средняя',
                                                    kkText: 'Орташа',
                                                  ),
                                                  FFLocalizations.of(context)
                                                      .getVariableText(
                                                    ruText: 'Низкая',
                                                    kkText: 'Төмен',
                                                  ),
                                                ],
                                                onChanged: (val) async {
                                                  safeSetState(() {
                                                    _model.criticalityFilter =
                                                        (val == null ||
                                                                val.isEmpty)
                                                            ? null
                                                            : val;
                                                  });
                                                  FFAppState()
                                                      .clearDefectCache();
                                                  await _loadDefects(
                                                      reset: true);
                                                  _model.isEdited = true;
                                                  safeSetState(() {});
                                                },
                                                width: MediaQuery.sizeOf(context)
                                                        .width *
                                                    0.38,
                                                height: 37.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText: FFLocalizations.of(
                                                        context)
                                                    .getVariableText(
                                                  ruText: 'Критичность',
                                                  kkText: 'Сынидық',
                                                ),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  size: 15.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                elevation: 2.0,
                                                borderColor: Colors.transparent,
                                                borderWidth: 0.0,
                                                borderRadius: 8.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 12.0, 0.0),
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
                                              final filialGetAreaResponse =
                                                  snapshot.data!;
                
                                              return FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .filialValueController ??=
                                                    FormFieldController<String>(
                                                        null),
                                                options: List<String>.from(
                                                    (getJsonField(
                                                  filialGetAreaResponse.jsonBody,
                                                  r'''$.data[:].id''',
                                                  true,
                                                ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>()),
                                                optionLabels: (getJsonField(
                                                  filialGetAreaResponse.jsonBody,
                                                  r'''$.data[:].title''',
                                                  true,
                                                ) as List?)!
                                                    .map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>(),
                                                onChanged: (val) async {
                                                  safeSetState(() =>
                                                      _model.filialValue = val);
                                                  FFAppState()
                                                      .clearDefectCache();
                                                  await _loadDefects(
                                                      reset: true);
                                                  _model.isEdited = true;
                                                  safeSetState(() {});
                                                },
                                                width: MediaQuery.sizeOf(context).width * 0.4,
                                                height: 37.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText:
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  ruText: 'Филиал',
                                                  kkText: 'Филиал',
                                                ),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryText,
                                                  size: 24.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                elevation: 2.0,
                                                borderColor: Colors.transparent,
                                                borderWidth: 0.0,
                                                borderRadius: 8.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
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
                                              final typeGetTypeResponse =
                                                  snapshot.data!;
                
                                              return FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .typeValueController ??=
                                                    FormFieldController<String>(
                                                        null),
                                                options: List<String>.from(
                                                    (getJsonField(
                                                  typeGetTypeResponse.jsonBody,
                                                  r'''$.data[:].id''',
                                                  true,
                                                ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>()),
                                                optionLabels: (getJsonField(
                                                  typeGetTypeResponse.jsonBody,
                                                  r'''$.data[:].title''',
                                                  true,
                                                ) as List?)!
                                                    .map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>(),
                                                onChanged: (val) async {
                                                  safeSetState(() =>
                                                      _model.typeValue = val);
                                                  FFAppState()
                                                      .clearDefectCache();
                                                  await _loadDefects(
                                                      reset: true);
                                                  _model.isEdited = true;
                                                  safeSetState(() {});
                                                },
                                                width: MediaQuery.sizeOf(context).width * 0.35,
                                                height: 37.0,
                                                searchHintTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                searchTextStyle: FlutterFlowTheme
                                                        .of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText: FFLocalizations.of(
                                                        context)
                                                    .getVariableText(
                                                  ruText: 'Тип техники',
                                                  kkText: 'Техника түрі',
                                                ),
                                                searchHintText:
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  ruText: 'Поиск',
                                                  kkText: 'Іздеу',
                                                ),
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryText,
                                                  size: 24.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                elevation: 2.0,
                                                borderColor: Colors.transparent,
                                                borderWidth: 0.0,
                                                borderRadius: 8.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                hidesUnderline: true,
                                                isOverButton: false,
                                                isSearchable: true,
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
                                              final contractorGetContractorsResponse =
                                                  snapshot.data!;
                
                                              return FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .contractorValueController ??=
                                                    FormFieldController<String>(
                                                        null),
                                                options: List<String>.from(
                                                    (getJsonField(
                                                  contractorGetContractorsResponse
                                                      .jsonBody,
                                                  r'''$.data[:].id''',
                                                  true,
                                                ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>()),
                                                optionLabels: (getJsonField(
                                                  contractorGetContractorsResponse
                                                      .jsonBody,
                                                  r'''$.data[:].title''',
                                                  true,
                                                ) as List?)!
                                                    .map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>(),
                                                onChanged: (val) async {
                                                  safeSetState(() => _model
                                                      .contractorValue = val);
                                                  FFAppState()
                                                      .clearDefectCache();
                                                  await _loadDefects(
                                                      reset: true);
                                                  _model.isEdited = true;
                                                  safeSetState(() {});
                                                },
                                                height: 37.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                hintText: 'Подрядчик',
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryText,
                                                  size: 24.0,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                elevation: 2.0,
                                                borderColor: Colors.transparent,
                                                borderWidth: 0.0,
                                                borderRadius: 8.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                hidesUnderline: true,
                                                isOverButton: false,
                                                isSearchable: false,
                                                isMultiSelect: false,
                                              );
                                            },
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ),
                                ]
                                    .addToStart(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                        ),
                        // Generated code for this Column Widget...
                Builder(
                  builder: (context) {
                    final defects = _model.defectsItems;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(defects.length, (defectsIndex) {
                        final defectsItem = defects[defectsIndex];
                        final defectLocationText =
                            _defectAreaLocationText(defectsItem);
                        return Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                            child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
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
                                                    width:
                                                        MediaQuery.sizeOf(context)
                                                                .width *
                                                            1.0,
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          5.0,
                                                                          5.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          child:
                                                                              Text(
                                                                            'ID: ${getJsonField(
                                                                              defectsItem,
                                                                              r'''$.id''',
                                                                            ).toString()}',
                                                                            style: FlutterFlowTheme.of(context)
                                                                                .bodyMedium
                                                                                .override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: valueOrDefault<
                                                                              Color>(
                                                                            functions
                                                                                .colorDefectCopy(getJsonField(
                                                                              defectsItem,
                                                                              r'''$.status''',
                                                                            ).toString()),
                                                                            FlutterFlowTheme.of(context)
                                                                                .alternate,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              decoration:
                                                                                  BoxDecoration(),
                                                                              child:
                                                                                  Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      functions.statusRequest(getJsonField(
                                                                                        defectsItem,
                                                                                        r'''$.status''',
                                                                                      ).toString()),
                                                                                      '-',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'SFProText',
                                                                                          color: Colors.white,
                                                                                          fontSize: 12.0,
                                                                                          letterSpacing: 0.0,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      _buildSlaBadge(defectsItem),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            10.0)),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.85,
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
                                                                                  16.0,
                                                                              letterSpacing:
                                                                                  0.0,
                                                                              fontWeight:
                                                                                  FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (defectLocationText
                                                                      .isNotEmpty)
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(
                                                                                  context)
                                                                              .width *
                                                                          0.85,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child: Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsetsDirectional.only(
                                                                                top: 2.0),
                                                                            child:
                                                                                Icon(
                                                                              Icons.location_on_outlined,
                                                                              color: FlutterFlowTheme.of(context)
                                                                                  .primaryText,
                                                                              size: 15.0,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              defectLocationText,
                                                                              maxLines: 3,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: FlutterFlowTheme.of(context)
                                                                                  .bodyMedium
                                                                                  .override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ].divide(const SizedBox(
                                                                            width:
                                                                                4.0)),
                                                                      ),
                                                                    ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            AlignmentDirectional(
                                                                                -1.0,
                                                                                0.0),
                                                                        child:
                                                                            Container(
                                                                          width: MediaQuery.sizeOf(context).width *
                                                                              0.85,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Icon(
                                                                                Icons.kitchen_rounded,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 15.0,
                                                                              ),
                                                                              Text(
                                                                                getJsonField(
                                                                                  defectsItem,
                                                                                  r'''$.equipment_info.title''',
                                                                                )?.toString() ?? '-',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      fontSize: 14.0,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 4.0)),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(
                                                                                context)
                                                                            .width *
                                                                        0.85,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .calendar_month,
                                                                          color: Color(
                                                                              0xFF87898F),
                                                                          size:
                                                                              15.0,
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Text(
                                                                            dateTimeFormat(
                                                                              "dd.MM.y H:mm",
                                                                              functions.stringToDateTime(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.created_on''',
                                                                              ).toString()),
                                                                              locale:
                                                                                  FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context)
                                                                                .bodyLarge
                                                                                .override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: Color(0xFF87898F),
                                                                                  fontSize: 14.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                          width:
                                                                              4.0)),
                                                                    ),
                                                                  ),
                                                                  if (functions
                                                                          .jsonToList(
                                                                              getJsonField(
                                                                            defectsItem,
                                                                            r'''$.performers_info''',
                                                                          ))
                                                                          .length !=
                                                                      0)
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.sizeOf(context).width *
                                                                              0.85,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Назначено : ',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '${getJsonField(
                                                                                    defectsItem,
                                                                                    r'''$.performers_info[0].first_name''',
                                                                                  ).toString()} ${getJsonField(
                                                                                    defectsItem,
                                                                                    r'''$.performers_info[0].last_name''',
                                                                                  ).toString()}',
                                                                                  style: TextStyle(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 14.0,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  if (((functions.statusRequest(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.status''',
                                                                              ).toString()) ==
                                                                              'Открыта') ||
                                                                          (functions.statusRequest(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.status''',
                                                                              ).toString()) ==
                                                                              'У исполнителя') ||
                                                                          (functions.statusRequest(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.status''',
                                                                              ).toString()) ==
                                                                              'Отклонена') ||
                                                                          (functions.statusRequest(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.status''',
                                                                              ).toString()) ==
                                                                              'В работе')) &&
                                                                      (valueOrDefault<String>(
                                                                            functions
                                                                                .jsonToStringCopy(getJsonField(
                                                                              FFAppState().account,
                                                                              r'''$.role''',
                                                                            )),
                                                                            '-',
                                                                          ) ==
                                                                          '\"engineer\"') &&
                                                                      (functions
                                                                              .jsonToList(getJsonField(
                                                                                defectsItem,
                                                                                r'''$.performers_info''',
                                                                              ))
                                                                              .length ==
                                                                          0))
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () async {
                                                                        await showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          useSafeArea:
                                                                              true,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                FocusScope.of(context).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child:
                                                                                  Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: ChooseUserWidget(
                                                                                  json: defectsItem,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            safeSetState(
                                                                                () {}));
                                                                      },
                                                                      text:
                                                                          'Назначить исполнителя',
                                                                      icon: Icon(
                                                                        Icons
                                                                            .person_add,
                                                                        size:
                                                                            15.0,
                                                                      ),
                                                                      options:
                                                                          FFButtonOptions(
                                                                        width: MediaQuery.sizeOf(context)
                                                                                .width *
                                                                            0.85,
                                                                        height: MediaQuery.sizeOf(context)
                                                                                .height *
                                                                            0.03,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        iconColor:
                                                                            FlutterFlowTheme.of(context)
                                                                                .primary,
                                                                        color: FlutterFlowTheme.of(
                                                                                context)
                                                                            .secondaryBackground,
                                                                        textStyle: FlutterFlowTheme.of(
                                                                                context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font:
                                                                                  GoogleFonts.readexPro(
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color:
                                                                                  FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing:
                                                                                  0.0,
                                                                              fontWeight:
                                                                                  FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                              fontStyle:
                                                                                  FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                        elevation:
                                                                            0.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8.0),
                                                                      ),
                                                                    ),
                                                                ].divide(SizedBox(
                                                                    height: 3.0)),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 5.0)),
                                                        ),
                                                      ]
                                                          .addToStart(SizedBox(
                                                              height: 10.0))
                                                          .addToEnd(SizedBox(
                                                              height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                          ),
                        );
                      }).divide(SizedBox(height: 10)).addToEnd(SizedBox(height: 10)),
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    if (_model.page >= _model.totalPages) {
                      return Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                        ),
                      );
                    }
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await _loadDefects(reset: false);
                        },
                        text: FFLocalizations.of(context).getVariableText(
                          ruText: 'Показать ещё',
                          kkText: 'Тағы көрсету',
                        ),
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 40.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  },
                )

                      ]
                          .divide(SizedBox(height: 10.0))
                          .addToStart(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
