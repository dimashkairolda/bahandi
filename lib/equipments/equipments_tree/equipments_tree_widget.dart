import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/site_equipment/equipment_add_onboarding/equipment_add_onboarding_widget.dart';
import '/site_equipment/equipment_add_onboarding/equipment_onboarding_prefs.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'equipments_tree_model.dart';
export 'equipments_tree_model.dart';

class EquipmentsTreeWidget extends StatefulWidget {
  const EquipmentsTreeWidget({super.key});

  static String routeName = 'EquipmentsTree';
  static String routePath = '/equipmentsTree';

  @override
  State<EquipmentsTreeWidget> createState() => _EquipmentsTreeWidgetState();
}

class _EquipmentsTreeWidgetState extends State<EquipmentsTreeWidget> {
  late EquipmentsTreeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const _equipmentListFields =
      'id,title,img,area_info,barcode,inventory_number,factory_number';

  String get _userRole => valueOrDefault<String>(
        getJsonField(
          FFAppState().account,
          r'''$.role''',
        )?.toString(),
        '',
      );

  bool get _canAddEquipment {
    return _userRole == 'director' ||
        _userRole == '"director"' ||
        _userRole == 'cashier' ||
        _userRole == '"cashier"';
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EquipmentsTreeModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadEquipments(reset: true);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<ApiCallResponse> _requestEquipmentsPage(int page) {
    return GetEquipmentsPaginationCall.call(
      access: currentAuthenticationToken,
      page: page,
      search: '&search=${_model.textController.text}',
      area: _model.areaFilter != null && _model.areaFilter != ''
          ? '&area=${_model.areaFilter}'
          : '',
      criticality:
          _model.criticalityFilter != null && _model.criticalityFilter != ''
              ? '&criticality=${_model.criticalityFilter}'
              : '',
      status: _model.statusFilter != null && _model.statusFilter != ''
          ? '&status=${_model.statusFilter}'
          : '',
      category:
          _model.categoryFilter != null ? '&category=${_model.categoryFilter}' : '',
      fields: '&fields=$_equipmentListFields',
      isActive: _model.showArchived ? '&is_active=false' : '&is_active=true',
    );
  }

  Future<void> _loadEquipments({bool reset = false}) async {
    if ((reset && _model.isInitialLoading) || (!reset && _model.isLoadingMore)) {
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
      final response = await _requestEquipmentsPage(nextPage);
      final pageItems = getJsonField(response.jsonBody, r'''$.data''').toList();
      final totalPages = valueOrDefault<int>(
        castToType<int>(
          getJsonField(response.jsonBody, r'''$.pagination.num_pages'''),
        ),
        1,
      );

      final existingIds = reset
          ? <String>{}
          : _model.equipmentItems
              .map((item) => getJsonField(item, r'''$.id''')?.toString())
              .whereType<String>()
              .toSet();
      final mergedItems = reset
          ? List<dynamic>.from(pageItems)
          : [
              ..._model.equipmentItems,
              ...pageItems.where((item) {
                final id = getJsonField(item, r'''$.id''')?.toString();
                return id == null || !existingIds.contains(id);
              }),
            ];

      if (!mounted) return;
      safeSetState(() {
        _model.page = nextPage;
        _model.totalPages = totalPages;
        _model.equipmentItems = mergedItems;
      });
    } catch (_) {
      if (!mounted) return;
      safeSetState(() {
        _model.loadErrorMessage = FFLocalizations.of(context).getVariableText(
          ruText: 'Ошибка загрузки оборудования',
          kkText: 'Жабдықты жүктеу қатесі',
        );
      });
    } finally {
      if (mounted) {
        safeSetState(() {
          _model.isInitialLoading = false;
          _model.isLoadingMore = false;
        });
      }
    }
  }

  Future<List<Map<String, dynamic>>> _loadAreas() async {
    final response = await GetAreaCall.call(access: currentAuthenticationToken);
    final areas = GetAreaCall.area(response.jsonBody) ?? [];
    return areas
        .map((item) => Map<String, dynamic>.from(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _openAddEquipmentFlow() async {
    final navigator = Navigator.of(context);
    final isCompleted = await EquipmentOnboardingPrefs.isCompleted();
    if (!mounted) return;

    if (!isCompleted) {
      await navigator.push(
        MaterialPageRoute(
          builder: (_) => const EquipmentAddOnboardingWidget(
            openSitesListAfter: true,
          ),
        ),
      );
      return;
    }

    final areas = await _loadAreas();
    if (!mounted) return;

    if (areas.length == 1) {
      final area = areas.first;
      final objectInfoList = area['object_info'] as List?;
      final objectInfo =
          objectInfoList != null && objectInfoList.isNotEmpty ? objectInfoList.first : null;
      final objectTitle = objectInfo is Map<String, dynamic>
          ? (objectInfo['title'] ?? '').toString().trim()
          : '';
      await context.pushNamed(
        SiteEquipmentListWidget.routeName,
        queryParameters: {
          'areaId': serializeParam(area['id'], ParamType.int),
          'areaTitle': serializeParam(
            (area['title'] ?? '').toString().trim(),
            ParamType.String,
          ),
          'objectTitle': serializeParam(
            objectTitle,
            ParamType.String,
          ),
        }.withoutNulls,
      );
      return;
    }

    await navigator.push(
      MaterialPageRoute(
        builder: (_) => const SitesListWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (_model.isInitialLoading) {
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

    if (_model.loadErrorMessage != null && _model.equipmentItems.isEmpty) {
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
              automaticallyImplyLeading: false,
              title: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Парк оборудования',
                  kkText: 'Жабдықтар паркі',
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
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: ListView(
                children: [
                    if (_canAddEquipment)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: FFButtonWidget(
                        onPressed: () async {
                          await _openAddEquipmentFlow();
                        },
                        text: FFLocalizations.of(context).getVariableText(
                          ruText: 'Добавить оборудование',
                          kkText: 'Жабдық қосу',
                        ),
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                Duration(milliseconds: 2000),
                                                () async {
                                  await _loadEquipments(reset: true);
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
                                hintText: FFLocalizations.of(context)
                                    .getVariableText(
                                  ruText: 'Поиск по названию',
                                  kkText: 'Атауы бойынша іздеу',
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
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
                                              await _loadEquipments(reset: true);
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
                            borderColor: Colors.transparent,
                            borderRadius: 8.0,
                            buttonSize: 50.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.search_sharp,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              await _loadEquipments(reset: true);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((_model.areaFilter != null &&
                                      _model.areaFilter != '') ||
                                  (_model.criticalityFilter != null &&
                                      _model.criticalityFilter != '') ||
                                  (_model.statusFilter != null &&
                                      _model.statusFilter != '') ||
                                  _model.showArchived ||
                                  _model.categoryFilter != null)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: InkWell(
                                    onTap: () async {
                                      safeSetState(() {
                                        _model.areaFilter = null;
                                        _model.criticalityFilter = null;
                                        _model.statusFilter = null;
                                        _model.categoryFilter = null;
                                        _model.showArchived = false;
                                        _model.dropDownValueController2?.reset();
                                        _model.criticalityValueController?.reset();
                                        _model.statusValueController?.reset();
                                      });
                                      await _loadEquipments(reset: true);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: FutureBuilder<ApiCallResponse>(
                                  future: GetAreaCall.call(
                                    access: currentAuthenticationToken,
                                  ),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox.shrink();
                                    }
                                    final dropDownGetAreaResponse =
                                        snapshot.data!;
                                    return FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController2 ??=
                                              FormFieldController<String>(null),
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
                                        safeSetState(() {
                                          _model.areaFilter = val;
                                        });
                                        await _loadEquipments(reset: true);
                                      },
                                      height: 48.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: FFLocalizations.of(context)
                                          .getVariableText(
                                        ruText: 'Филиал',
                                        kkText: 'Филиал',
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                            child: SizedBox(
                              height: 48.0,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FlutterFlowDropDown<String>(
                                      controller: _model
                                              .criticalityValueController ??=
                                          FormFieldController<String>(null),
                                      options: ['high', 'medium', 'low'],
                                      optionLabels: [
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Высокий',
                                          kkText: 'Жоғары',
                                        ),
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Средний',
                                          kkText: 'Орташа',
                                        ),
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Низкий',
                                          kkText: 'Төмен',
                                        ),
                                      ],
                                      onChanged: (val) async {
                                        safeSetState(() {
                                          _model.criticalityFilter = val;
                                        });
                                        await _loadEquipments(reset: true);
                                      },
                                      height: 48.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: FFLocalizations.of(context)
                                          .getVariableText(
                                        ruText: 'Критичность',
                                        kkText: 'Приоритет',
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: FlutterFlowDropDown<String>(
                                      controller:
                                          _model.statusValueController ??=
                                              FormFieldController<String>(null),
                                      options: [
                                        'draft',
                                        'in_progress',
                                        'on_repair'
                                      ],
                                      optionLabels: [
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'Черновик',
                                          kkText: 'Черновик',
                                        ),
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'В работе',
                                          kkText: 'Жұмыста',
                                        ),
                                        FFLocalizations.of(context)
                                            .getVariableText(
                                          ruText: 'На ремонте',
                                          kkText: 'Жөндеуде',
                                        ),
                                      ],
                                      onChanged: (val) async {
                                        safeSetState(() {
                                          _model.statusFilter = val;
                                        });
                                        await _loadEquipments(reset: true);
                                      },
                                      height: 48.0,
                                      textStyle: FlutterFlowTheme.of(context)
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
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    safeSetState(() {
                                      _model.categoryFilter = null;
                                      _model.showArchived = false;
                                    });
                                    await _loadEquipments(reset: true);
                                  },
                                  text: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Все',
                                    kkText: 'Барлығы',
                                  ),
                                  options: FFButtonOptions(
                                    height: 36.0,
                                    color: _model.categoryFilter == null &&
                                            !_model.showArchived
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: _model.categoryFilter == null &&
                                                  !_model.showArchived
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    safeSetState(() {
                                      _model.categoryFilter = 'basic_equipment';
                                      _model.showArchived = false;
                                    });
                                    await _loadEquipments(reset: true);
                                  },
                                  text: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Основное оборудование',
                                    kkText: 'Негізгі жабдық',
                                  ),
                                  options: FFButtonOptions(
                                    height: 36.0,
                                    color: _model.categoryFilter ==
                                                'basic_equipment' &&
                                            !_model.showArchived
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: _model.categoryFilter ==
                                                      'basic_equipment' &&
                                                  !_model.showArchived
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    safeSetState(() {
                                      _model.categoryFilter = 'furniture';
                                      _model.showArchived = false;
                                    });
                                    await _loadEquipments(reset: true);
                                  },
                                  text: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Мебель',
                                    kkText: 'Жиһаз',
                                  ),
                                  options: FFButtonOptions(
                                    height: 36.0,
                                    color: _model.categoryFilter == 'furniture' &&
                                            !_model.showArchived
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: _model.categoryFilter ==
                                                      'furniture' &&
                                                  !_model.showArchived
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    safeSetState(() {
                                      _model.categoryFilter = 'periphery';
                                      _model.showArchived = false;
                                    });
                                    await _loadEquipments(reset: true);
                                  },
                                  text: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Периферия',
                                    kkText: 'Периферия',
                                  ),
                                  options: FFButtonOptions(
                                    height: 36.0,
                                    color: _model.categoryFilter == 'periphery' &&
                                            !_model.showArchived
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: _model.categoryFilter ==
                                                      'periphery' &&
                                                  !_model.showArchived
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    safeSetState(() {
                                      _model.categoryFilter = null;
                                      _model.showArchived = true;
                                    });
                                    await _loadEquipments(reset: true);
                                  },
                                  text: FFLocalizations.of(context)
                                      .getVariableText(
                                    ruText: 'Архивные',
                                    kkText: 'Мұрағат',
                                  ),
                                  options: FFButtonOptions(
                                    height: 36.0,
                                    color: _model.showArchived
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: _model.showArchived
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final equipTRee = _model.equipmentItems;

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(equipTRee.length, (equipTReeIndex) {
                            final equipTReeItem = equipTRee[equipTReeIndex];
                            return Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await context.pushNamed(
                                    EquipmentsDetailedWidget.routeName,
                                    queryParameters: {
                                      'json': serializeParam(
                                        equipTReeItem,
                                        ParamType.JSON,
                                      ),
                                      'id': serializeParam(
                                        getJsonField(
                                          equipTReeItem,
                                          r'''$.id''',
                                        ),
                                        ParamType.int,
                                      ),
                                    }.withoutNulls,
                                  );
                                  if (!mounted) return;
                                  await _loadEquipments(reset: true);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.95,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
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
                                                      'https://app.etry.kz${getJsonField(
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
                                                            fontSize: 16.0,
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
                                                            fontSize: 16.0,
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
                                                            fontSize: 14.0,
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
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 5.0)),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${FFLocalizations.of(context).getVariableText(
                                                      ruText: 'Филиал',
                                                      kkText: 'Филиал',
                                                    )} : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipTReeItem,
                                                        r'''$.area_info.title''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                              ),
                                            ),
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${FFLocalizations.of(context).getVariableText(
                                                      ruText: 'Заводской номер',
                                                      kkText: 'Зауыт нөмірі',
                                                    )} : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipTReeItem,
                                                        r'''$.factory_number''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                              ),
                                            ),
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '${FFLocalizations.of(context).getVariableText(
                                                      ruText: 'Штрих - код',
                                                      kkText: 'Штрих-код',
                                                    )} : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 14.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipTReeItem,
                                                        r'''$.barcode''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                  )
                                                ],
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
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
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 5.0)),
                                        ),
                                      ].divide(SizedBox(height: 15.0)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).divide(SizedBox(height: 8.0)),
                        );
                      },
                    ),
                    Builder(
                      builder: (context) {
                        final currentPage = _model.page;
                        if (currentPage >= _model.totalPages) {
                          return Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 20.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await _loadEquipments();
                              },
                              text: FFLocalizations.of(context).getVariableText(
                                ruText: 'Показать ещё',
                                kkText: 'Тағы көрсету',
                              ),
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 40.0,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ]
                      .divide(SizedBox(height: 10.0))
                      .addToStart(SizedBox(height: 10.0)),
              ),
            ),
          ),
    );
  }
}
