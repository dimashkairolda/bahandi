import 'package:Etry/api/firebase_api.dart';
import 'package:Etry/components/scan_equipment_page.dart';
import 'package:app_badger/app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
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
  WebSocketChannel? _channel;
  
  // Плагин уведомлений
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    // Подписываемся на события жизненного цикла (свернул/развернул)
    WidgetsBinding.instance.addObserver(this); 
    
    FirebaseApi().initNotifications(context);
    _initLocalNotifications(); // Инициализация локальных уведомлений
    _model = createModel(context, () => DefectsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _initialAuthAndLoad();
      // Запускаем WebSocket ПОСЛЕ загрузки токена
      _connectWebSocket();
      onUserLogin();
      




      
  


    });
    
  
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    // Важно: закрываем соединение при уходе со страницы
    _channel?.sink.close();
    // Убираем наблюдателя
    WidgetsBinding.instance.removeObserver(this);
    
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
      // Можно также переподключить сокет, если он умер
      if (_channel?.closeCode != null) {
         _connectWebSocket();
      }
    }
  }

  // --- Логика Инициализации ---
  Future<void> _initialAuthAndLoad() async {
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
      _refreshDefectsList();
      ViewedNotificationCall.call(
      access: currentAuthenticationToken,
    );
  AppBadger.removeBadge();
      await _model.waitForApiRequestCompleted();
  }

  // --- Логика WebSocket ---
  void _connectWebSocket() {
    if (currentAuthenticationToken == null) return;

    try {
      // Закрываем старый, если был
      _channel?.sink.close();

      print('Connecting WebSocket...');
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://app.etry.kz/ws/notification/?token=$currentAuthenticationToken'),
      );

      _channel!.stream.listen(
        (message) {
          print('WS Message: $message');
          final decodedMessage = jsonDecode(message);
          
          // Проверяем структуру (адаптируйте под ваш JSON)
          final msgData = decodedMessage['message'] ?? {}; 
          final title = msgData['title'] ?? 'Обновление';
          final description = msgData['description'] ?? 'Статус заявки изменен';

          // 1. Показываем уведомление (если нужно)
          _showLocalNotification(title, description);

          // 2. Показываем SnackBar
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title: $description'),
                duration: const Duration(seconds: 2),
                backgroundColor: FlutterFlowTheme.of(context).primary,
                action: SnackBarAction(
                  label: 'Обновить',
                  textColor: Colors.white,
                  onPressed: _refreshDefectsList,
                ),
              ),
            );
          }

          // 3. ОБНОВЛЯЕМ СПИСОК (Самое важное)
          _refreshDefectsList();
        },
        onError: (error) {
          print('WebSocket Error: $error');
          // Простая логика реконнекта через 5 секунд
          Future.delayed(Duration(seconds: 5), () {
             if (mounted) _connectWebSocket(); 
          });
        },
        onDone: () {
          print('WebSocket Closed');
        },
      );
    } catch (e) {
      print('WebSocket Connection Failed: $e');
    }
  }

  // --- Функция обновления списка (UI) ---
  void _refreshDefectsList() {
    if (!mounted) return;
    safeSetState(() {
      FFAppState().clearDefectCache();
      _model.apiRequestCompleted = false; // Это заставит FutureBuilder пересоздаться
    });
  }
  
  // --- Local Notifications Init ---
  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Стандартная иконка Flutter

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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

  Future<void> _showLocalNotification(String title, String description) async {
    const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
        'defect_updates', 
        'Defect Updates',
        importance: Importance.max,
        priority: Priority.high,
      );
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond, 
      title, 
      description, 
      details
    );
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

  Future<ApiCallResponse> _getDefectsWithInterceptor() async {
     // ... ваш код ...
     Future<ApiCallResponse> makeRequest() async {
      return GetDefectsAPICall.call(
        access: currentAuthenticationToken, 
        search: _model.textController.text != ''
            ? '&search=${_model.textController.text}'
            : '',
        page: _model.page.toString(),
        date: _model.date != null
            ? '&date[]=${dateTimeFormat("y-MM-dd", _model.date, locale: FFLocalizations.of(context).languageCode)}'
            : '',
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

  String _formatSlaDuration(Duration d) {
    if (d.inHours > 0) {
      final mins = d.inMinutes.remainder(60);
      return '${d.inHours}ч ${mins} мин';
    }
    return '${d.inMinutes} мин';
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

    final defectsUniqueQueryKey = [
      _model.page.toString(),
      _model.date?.millisecondsSinceEpoch.toString() ?? '',
      _model.statusValue ?? '',
      _model.typeValue ?? '',
      _model.filialValue ?? '',
      _model.contractorValue ?? '',
      _model.textController?.text ?? '',
    ].join('|');

    return FutureBuilder<ApiCallResponse>(
      // ИЗМЕНЕНИЕ ЗДЕСЬ: используем нашу обертку вместо прямого вызова
      future: FFAppState().defect(
        uniqueQueryKey: defectsUniqueQueryKey,
        requestFn: () => _getDefectsWithInterceptor(),
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
        final defectsGetDefectsAPIResponse = snapshot.data!;
        final defectsPageItems = getJsonField(
          defectsGetDefectsAPIResponse.jsonBody,
          r'''$.data''',
        ).toList();
        final defectsTotalPages = valueOrDefault<int>(
          castToType<int>(
            getJsonField(
              defectsGetDefectsAPIResponse.jsonBody,
              r'''$.pagination.num_pages''',
            ),
          ),
          1,
        );
        _model.applyDefectsPage(
          uniqueKey: defectsUniqueQueryKey,
          pageNumber: _model.page,
          items: defectsPageItems,
          totalPagesValue: defectsTotalPages,
        );

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
                                                safeSetState(() {
                                                  FFAppState().clearDefectCache();
                                                  _model.page = 1;
                                                  _model.apiRequestCompleted =
                                                      false;
                                                });
                                                await _model
                                                    .waitForApiRequestCompleted();
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
                                              safeSetState(() {
                                                FFAppState().clearDefectCache();
                                                _model.page = 1;
                                                _model.apiRequestCompleted =
                                                    false;
                                              });
                                              await _model
                                                  .waitForApiRequestCompleted();
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
                                                      safeSetState(() {
                                                        FFAppState()
                                                            .clearDefectCache();
                                                        _model.page = 1;
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
                                              safeSetState(() {
                                                FFAppState().clearDefectCache();
                                                _model.page = 1;
                                                _model.apiRequestCompleted =
                                                    false;
                                              });
                                              await _model
                                                  .waitForApiRequestCompleted();
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
                                              'contractor_appointed',
                                              'contractor_accept',
                                              'at_performer',
                                              'in_progress',
                                              'postponed',
                                              'completed',
                                              'closed'
                                            ]),
                                            optionLabels: [
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Открыта',
                                                kkText: 'Ашық',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Подрядчик назначен',
                                                kkText: 'Мердігер тағайындалды',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Принят подрядчиком',
                                                kkText: 'Мердігер қабылдады',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'У исполнителя',
                                                kkText: 'Орындаушыда',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'В работе',
                                                kkText: 'Жұмыста',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Отложена',
                                                kkText: 'Кейінге қалдырылды',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Выполнен',
                                                kkText: 'Орындалды',
                                              ),
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                                ruText: 'Закрыта',
                                                kkText: 'Жабылды',
                                              )
                                            ],
                                            onChanged: (val) async {
                                              safeSetState(
                                                  () => _model.statusValue = val);
                                              safeSetState(() {
                                                FFAppState().clearDefectCache();
                                                _model.page = 1;
                                                _model.apiRequestCompleted =
                                                    false;
                                              });
                                              await _model
                                                  .waitForApiRequestCompleted();
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
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearDefectCache();
                                                    _model.page = 1;
                                                    _model.apiRequestCompleted =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted();
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
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearDefectCache();
                                                    _model.page = 1;
                                                    _model.apiRequestCompleted =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted();
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
                                                  safeSetState(() {
                                                    FFAppState()
                                                        .clearDefectCache();
                                                    _model.page = 1;
                                                    _model.apiRequestCompleted =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted();
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
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons
                                                                                .location_on_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                15.0,
                                                                          ),
                                                                        ),
                                                                        RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: valueOrDefault<String>(
                                                                                  getJsonField(
                                                                                    defectsItem,
                                                                                    r'''$.equipment_info.area_info.title''',
                                                                                  )?.toString(),
                                                                                  '-',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      fontSize: 14.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(),
                                                                              ),
                                                                              TextSpan(
                                                                                text: valueOrDefault<String>(
                                                                                  getJsonField(
                                                                                    defectsItem,
                                                                                    r'''$.equipment_info.area_info.object_info.title''',
                                                                                  )?.toString(),
                                                                                  '-',
                                                                                ),
                                                                                style: TextStyle(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 14.0,
                                                                                ),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context)
                                                                                .bodyMedium
                                                                                .override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 12.0,
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
                          safeSetState(() {
                            _model.page = _model.page + 1;
                            _model.apiRequestCompleted = false;
                          });
                          await _model.waitForApiRequestCompleted(
                            minWait: 2500,
                          );
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
      },
    );
  }
}
