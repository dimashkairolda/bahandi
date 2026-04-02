import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObjectsAreasWidget extends StatefulWidget {
  const ObjectsAreasWidget({super.key});

  static String routeName = 'ObjectsAreas';
  static String routePath = '/objectsAreas';

  @override
  State<ObjectsAreasWidget> createState() => _ObjectsAreasWidgetState();
}

class _ObjectsAreasWidgetState extends State<ObjectsAreasWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loadingRoot = true;
  String? _rootError;
  List<dynamic> _rootObjects = [];

  final Map<int, bool> _expandedObjects = {};
  final Map<int, bool> _loadingChildren = {};
  final Map<int, String?> _childrenError = {};
  final Map<int, List<dynamic>> _childObjects = {};
  final Map<int, List<dynamic>> _childAreas = {};

  final Map<int, bool> _expandedAreas = {};
  final Map<int, bool> _loadingAreaEquip = {};
  final Map<int, String?> _areaEquipError = {};
  final Map<int, int> _areaEquipPage = {};
  final Map<int, int> _areaEquipNumPages = {};
  final Map<int, List<dynamic>> _areaEquipments = {};

  @override
  void initState() {
    super.initState();
    unawaited(_loadRoot());
  }

  Future<void> _loadRoot() async {
    setState(() {
      _loadingRoot = true;
      _rootError = null;
    });
    try {
      final resp = await GetObjectsCall.call(
        access: currentAuthenticationToken,
        page: 1,
        perPage: 10,
      );
      setState(() {
        _rootObjects = (GetObjectsCall.data(resp.jsonBody) ?? const <dynamic>[]).toList();
        _loadingRoot = false;
      });
    } catch (e) {
      setState(() {
        _rootError = e.toString();
        _loadingRoot = false;
      });
    }
  }

  Future<void> _toggleObject(int objectId) async {
    final isExpanded = _expandedObjects[objectId] ?? false;
    setState(() => _expandedObjects[objectId] = !isExpanded);
    if (isExpanded) return;
    if ((_childObjects[objectId]?.isNotEmpty ?? false) ||
        (_childAreas[objectId]?.isNotEmpty ?? false)) {
      return;
    }
    await _loadChildren(objectId);
  }

  Future<void> _loadChildren(int objectId) async {
    setState(() {
      _loadingChildren[objectId] = true;
      _childrenError[objectId] = null;
    });
    try {
      final resp = await GetObjectChildCall.call(
        access: currentAuthenticationToken,
        objectId: objectId,
      );
      setState(() {
        _childObjects[objectId] =
            (GetObjectChildCall.objects(resp.jsonBody) ?? const <dynamic>[]).toList();
        _childAreas[objectId] =
            (GetObjectChildCall.areas(resp.jsonBody) ?? const <dynamic>[]).toList();
        _loadingChildren[objectId] = false;
      });
    } catch (e) {
      setState(() {
        _childrenError[objectId] = e.toString();
        _loadingChildren[objectId] = false;
      });
    }
  }

  Future<void> _toggleArea(int areaId) async {
    final isExpanded = _expandedAreas[areaId] ?? false;
    setState(() => _expandedAreas[areaId] = !isExpanded);
    if (isExpanded) return;
    if ((_areaEquipments[areaId]?.isNotEmpty ?? false)) return;
    await _loadAreaEquipments(areaId, reset: true);
  }

  Future<void> _loadAreaEquipments(int areaId, {required bool reset}) async {
    final nextPage = reset ? 1 : ((_areaEquipPage[areaId] ?? 1) + 1);
    setState(() {
      _loadingAreaEquip[areaId] = true;
      _areaEquipError[areaId] = null;
      if (reset) {
        _areaEquipments[areaId] = [];
      }
    });
    try {
      final resp = await GetAreaEquipmentsCall.call(
        access: currentAuthenticationToken,
        areaId: areaId,
        page: nextPage,
        pagination: true,
      );
      final items =
          (GetAreaEquipmentsCall.equipments(resp.jsonBody) ?? const <dynamic>[]).toList();
      setState(() {
        _areaEquipments[areaId] = [...(_areaEquipments[areaId] ?? []), ...items];
        _areaEquipPage[areaId] = nextPage;
        _areaEquipNumPages[areaId] = GetAreaEquipmentsCall.numPages(resp.jsonBody) ?? 1;
        _loadingAreaEquip[areaId] = false;
      });
    } catch (e) {
      setState(() {
        _areaEquipError[areaId] = e.toString();
        _loadingAreaEquip[areaId] = false;
      });
    }
  }

  Future<void> _showAddObjectDialog({int? parentObjectId}) async {
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isSubmitting = false;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocalState) => AlertDialog(
          title: Text(
            parentObjectId == null
                ? FFLocalizations.of(context)
                    .getVariableText(ruText: 'Добавить объект', kkText: 'Нысан қосу')
                : FFLocalizations.of(context).getVariableText(
                    ruText: 'Добавить объект(ы)', kkText: 'Нысан(дар) қосу'),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context)
                        .getVariableText(ruText: 'Наименование', kkText: 'Атауы'),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context)
                        .getVariableText(ruText: 'Адрес', kkText: 'Мекенжай'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting ? null : () => Navigator.pop(ctx),
              child: Text(FFLocalizations.of(context)
                  .getVariableText(ruText: 'Отмена', kkText: 'Бас тарту')),
            ),
            ElevatedButton(
              onPressed: isSubmitting
                  ? null
                  : () async {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      setLocalState(() => isSubmitting = true);
                      try {
                        if (parentObjectId == null) {
                          await CreateObjectCall.call(
                            access: currentAuthenticationToken,
                            title: titleController.text.trim(),
                            address: addressController.text.trim(),
                          );
                          await _loadRoot();
                        } else {
                          await CreateObjectsBulkCall.call(
                            access: currentAuthenticationToken,
                            itemsJson: [
                              {
                                'title': titleController.text.trim(),
                                'address': addressController.text.trim(),
                                'parent': parentObjectId,
                              }
                            ],
                          );
                          await _loadChildren(parentObjectId);
                        }
                        if (mounted) Navigator.pop(ctx);
                      } catch (_) {
                        setLocalState(() => isSubmitting = false);
                      }
                    },
              child: Text(FFLocalizations.of(context)
                  .getVariableText(ruText: 'Добавить', kkText: 'Қосу')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddAreaDialog(int objectId) async {
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(FFLocalizations.of(context)
            .getVariableText(ruText: 'Добавить участок', kkText: 'Учаске қосу')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Отмена', kkText: 'Бас тарту')),
          ),
          ElevatedButton(
            onPressed: () async {
              await CreateAreasBulkCall.call(
                access: currentAuthenticationToken,
                itemsJson: [
                  {
                    'title': titleController.text.trim(),
                    'address': addressController.text.trim(),
                    'object': objectId,
                  }
                ],
              );
              if (mounted) Navigator.pop(ctx);
              await _loadChildren(objectId);
            },
            child: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Сохранить', kkText: 'Сақтау')),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditObjectDialog({
    required int objectId,
    required String initialTitle,
    required String initialAddress,
  }) async {
    final titleController = TextEditingController(text: initialTitle);
    final addressController = TextEditingController(text: initialAddress);
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(FFLocalizations.of(context)
            .getVariableText(ruText: 'Редактировать', kkText: 'Өзгерту')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(controller: titleController),
            const SizedBox(height: 12),
            TextFormField(controller: addressController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Отмена', kkText: 'Бас тарту')),
          ),
          ElevatedButton(
            onPressed: () async {
              await UpdateObjectCall.call(
                access: currentAuthenticationToken,
                objectId: objectId,
                title: titleController.text.trim(),
                address: addressController.text.trim(),
              );
              if (mounted) Navigator.pop(ctx);
              await _loadRoot();
            },
            child: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Сохранить', kkText: 'Сақтау')),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditAreaDialog({
    required int areaId,
    required int parentObjectId,
    required String initialTitle,
    required String initialAddress,
  }) async {
    final titleController = TextEditingController(text: initialTitle);
    final addressController = TextEditingController(text: initialAddress);
    final formKey = GlobalKey<FormState>();
    bool isSubmitting = false;
    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocalState) => AlertDialog(
          title: Text(FFLocalizations.of(context)
              .getVariableText(ruText: 'Редактировать участок', kkText: 'Учаскені өзгерту')),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context)
                        .getVariableText(ruText: 'Наименование', kkText: 'Атауы'),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: FFLocalizations.of(context)
                        .getVariableText(ruText: 'Адрес', kkText: 'Мекенжай'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting ? null : () => Navigator.pop(ctx),
              child: Text(FFLocalizations.of(context)
                  .getVariableText(ruText: 'Отмена', kkText: 'Бас тарту')),
            ),
            ElevatedButton(
              onPressed: isSubmitting
                  ? null
                  : () async {
                      if (!(formKey.currentState?.validate() ?? false)) return;
                      setLocalState(() => isSubmitting = true);
                      try {
                        await UpdateAreaCall.call(
                          access: currentAuthenticationToken,
                          areaId: areaId,
                          title: titleController.text.trim(),
                          address: addressController.text.trim(),
                        );
                        await _loadChildren(parentObjectId);
                        if (mounted) Navigator.pop(ctx);
                      } catch (_) {
                        if (mounted) Navigator.pop(ctx);
                      }
                    },
              child: Text(FFLocalizations.of(context)
                  .getVariableText(ruText: 'Сохранить', kkText: 'Сақтау')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteObject({required int objectId, required String title}) async {
    final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Удаление', kkText: 'Жою')),
            content: Text(title),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(FFLocalizations.of(context)
                    .getVariableText(ruText: 'Отмена', kkText: 'Бас тарту')),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(FFLocalizations.of(context)
                    .getVariableText(ruText: 'Удалить', kkText: 'Жою')),
              ),
            ],
          ),
        ) ??
        false;
    if (!ok) return;
    await DeleteObjectCall.call(
      access: currentAuthenticationToken,
      objectId: objectId,
    );
    await _loadRoot();
  }

  Color _statusColor(FlutterFlowTheme theme, String status) {
    switch (status) {
      case 'on_repair':
        return const Color(0xFFD8516A);
      case 'in_progress':
        return const Color(0xFFE28A16);
      case 'draft':
        return theme.secondaryText;
      default:
        return theme.secondaryText;
    }
  }

  RoundedRectangleBorder _softCardShape(FlutterFlowTheme theme) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Colors.transparent),
    );
  }

  Widget _equipmentRow(BuildContext context, dynamic item) {
    final theme = FlutterFlowTheme.of(context);
    final id = castToType<int>(getJsonField(item, r'''$.id''')) ?? 0;
    final title = valueOrDefault<String>(
      getJsonField(item, r'''$.title''')?.toString(),
      '-',
    );
    final typeTitle = valueOrDefault<String>(
      getJsonField(item, r'''$.type_info.title''')?.toString(),
      valueOrDefault<String>(
        getJsonField(item, r'''$.model_info.title''')?.toString(),
        '',
      ),
    );
    final barcode = valueOrDefault<String>(
      getJsonField(item, r'''$.barcode''')?.toString(),
      '-',
    );
    final responsiblesRaw =
        (getJsonField(item, r'''$.responsibles_info''', true) as List?)
                ?.whereType<dynamic>()
                .toList() ??
            const <dynamic>[];
    final responsibleNames = responsiblesRaw
        .map((e) {
          final fullName = valueOrDefault<String>(
            getJsonField(e, r'''$.full_name''')?.toString(),
            '',
          );
          if (fullName.isNotEmpty) {
            return fullName;
          }
          final firstName = valueOrDefault<String>(
            getJsonField(e, r'''$.first_name''')?.toString(),
            '',
          );
          final lastName = valueOrDefault<String>(
            getJsonField(e, r'''$.last_name''')?.toString(),
            '',
          );
          final patronymic = valueOrDefault<String>(
            getJsonField(e, r'''$.patronymic''')?.toString(),
            '',
          );
          return [firstName, lastName, patronymic]
              .where((part) => part.trim().isNotEmpty)
              .join(' ')
              .trim();
        })
        .where((e) => e.isNotEmpty)
        .toList();
    final responsible = responsibleNames.isEmpty
        ? valueOrDefault<String>(
            getJsonField(item, r'''$.responsible_info.full_name''')?.toString(),
            '',
          )
        : responsibleNames.first +
            (responsibleNames.length > 1
                ? ' +${responsibleNames.length - 1}'
                : '');
    final status = valueOrDefault<String>(
      getJsonField(item, r'''$.status''')?.toString(),
      '',
    );
    final statusColor = _statusColor(theme, status);
    final statusLabel = () {
      switch (status) {
        case 'on_repair':
          return FFLocalizations.of(context)
              .getVariableText(ruText: 'На ремонте', kkText: 'Жөндеуде');
        case 'in_progress':
          return FFLocalizations.of(context)
              .getVariableText(ruText: 'В работе', kkText: 'Жұмыста');
        case 'draft':
          return FFLocalizations.of(context)
              .getVariableText(ruText: 'Черновик', kkText: 'Черновик');
        default:
          return status;
      }
    }();
    return Card(
      margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
      elevation: 0,
      color: theme.secondaryBackground,
      shape: _softCardShape(theme),
      child: InkWell(
        onTap: () => context.pushNamed(
          EquipmentsDetailedWidget.routeName,
          queryParameters: {'id': serializeParam(id, ParamType.int)}.withoutNulls,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: theme.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.bodyMedium.override(
                                  fontFamily: 'SFProText',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            if (statusLabel.isNotEmpty) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 6, 12, 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: statusColor.withOpacity(0.25),
                                  ),
                                ),
                                child: Text(
                                  statusLabel,
                                  style: theme.bodySmall.override(
                                    fontFamily: 'SFProText',
                                    color: statusColor,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (typeTitle.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 2),
                            child: Text(
                              typeTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.bodySmall.override(
                                fontFamily: 'SFProText',
                                color: theme.secondaryText,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.qr_code_2_rounded,
                      color: theme.secondaryText, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      barcode,
                      style: theme.bodyMedium.override(
                        fontFamily: 'SFProText',
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (responsible.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person_outline_rounded,
                        color: theme.secondaryText, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        responsible,
                        style: theme.bodyMedium.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _areaTile(BuildContext context, dynamic area, {required int parentObjectId}) {
    final theme = FlutterFlowTheme.of(context);
    final id = castToType<int>(getJsonField(area, r'''$.id''')) ?? 0;
    final title = valueOrDefault<String>(
      getJsonField(area, r'''$.title''')?.toString(),
      '-',
    );
    final address = valueOrDefault<String>(
      getJsonField(area, r'''$.address''')?.toString(),
      '',
    );
    final areaEquipment = _areaEquipments[id] ?? const <dynamic>[];
    final expanded = _expandedAreas[id] ?? false;
    final areaLoading = _loadingAreaEquip[id] ?? false;
    final areaError = _areaEquipError[id];
    final equipmentCount = castToType<int>(
          getJsonField(area, r'''$.equipments_count'''),
        ) ??
        castToType<int>(getJsonField(area, r'''$.equipment_count''')) ??
        areaEquipment.length;
    return Column(
      children: [
        Card(
          margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
          elevation: 0,
          color: theme.secondaryBackground,
          shape: _softCardShape(theme),
          child: InkWell(
            onTap: () => _toggleArea(id),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.subdirectory_arrow_right_rounded,
                      color: theme.secondaryText, size: 22),
                  const SizedBox(width: 4),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        Icon(Icons.place_outlined, color: theme.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (address.isNotEmpty)
                          Text(
                            address,
                            style: theme.bodySmall.override(
                              fontFamily: 'SFProText',
                              color: theme.secondaryText,
                              letterSpacing: 0.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (equipmentCount > 0) ...[
                    Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: theme.primary.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        equipmentCount.toString(),
                        style: theme.bodySmall.override(
                          fontFamily: 'SFProText',
                          color: theme.info,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert_rounded, color: theme.secondaryText),
                    onSelected: (value) async {
                      if (value == 'attach_equip') {
                        context.pushNamed(
                          AreaEquipmentsSelectWidget.routeName,
                          queryParameters: {
                            'areaId': serializeParam(id, ParamType.int),
                            'parentObjectId': serializeParam(parentObjectId, ParamType.int),
                            'areaTitle': serializeParam(title, ParamType.String),
                          }.withoutNulls,
                        ).then((_) => _loadAreaEquipments(id, reset: true));
                      } else if (value == 'select_resp') {
                        context.pushNamed(
                          AreaResponsiblesSelectWidget.routeName,
                          queryParameters: {
                            'areaId': serializeParam(id, ParamType.int),
                            'parentObjectId': serializeParam(parentObjectId, ParamType.int),
                            'areaTitle': serializeParam(title, ParamType.String),
                          }.withoutNulls,
                        );
                      } else if (value == 'edit') {
                        await _showEditAreaDialog(
                          areaId: id,
                          parentObjectId: parentObjectId,
                          initialTitle: title,
                          initialAddress: address,
                        );
                      } else if (value == 'delete') {
                        await DeleteAreaCall.call(access: currentAuthenticationToken, areaId: id);
                        await _loadChildren(parentObjectId);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'attach_equip',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Прикрепить оборудование',
                          kkText: 'Жабдықты бекіту',
                        )),
                      ),
                      PopupMenuItem(
                        value: 'select_resp',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Выбрать ответственных',
                          kkText: 'Жауаптыларды таңдау',
                        )),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Редактировать',
                          kkText: 'Өзгерту',
                        )),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Удалить',
                          kkText: 'Жою',
                        )),
                      ),
                    ],
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: theme.secondaryText,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (expanded && areaLoading)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  ),
                ),
              ),
            ),
          ),
        if (expanded && areaError != null && !areaLoading)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              child: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Не удалось загрузить оборудование',
                  kkText: 'Жабдықты жүктеу мүмкін болмады',
                ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  color: theme.error,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ),
        if (expanded && areaEquipment.isEmpty && !areaLoading && areaError == null)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.transparent),
              ),
              child: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Оборудование не найдено',
                  kkText: 'Жабдық табылмады',
                ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  color: theme.secondaryText,
                  letterSpacing: 0.0,
                ),
              ),
            ),
          ),
        if (expanded && areaEquipment.isNotEmpty)
          ...areaEquipment.map((e) => _equipmentRow(context, e)).toList(),
        if (expanded &&
            (_areaEquipPage[id] ?? 1) < (_areaEquipNumPages[id] ?? 1) &&
            !(_loadingAreaEquip[id] ?? false))
          TextButton(
            onPressed: () => _loadAreaEquipments(id, reset: false),
            child: Text(FFLocalizations.of(context)
                .getVariableText(ruText: 'Показать ещё', kkText: 'Тағы көрсету')),
          ),
      ],
    );
  }

  Widget _objectTile(BuildContext context, dynamic obj, {required int level}) {
    final theme = FlutterFlowTheme.of(context);
    final id = castToType<int>(getJsonField(obj, r'''$.id''')) ?? 0;
    final title = valueOrDefault<String>(
      getJsonField(obj, r'''$.title''')?.toString(),
      '-',
    );
    final address = valueOrDefault<String>(
      getJsonField(obj, r'''$.address''')?.toString(),
      '',
    );
    final expanded = _expandedObjects[id] ?? false;
    final childCount = ((_childObjects[id] ?? const <dynamic>[]).length) +
        ((_childAreas[id] ?? const <dynamic>[]).length);
    return Column(
      children: [
        Card(
          margin: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
          elevation: 0,
          color: theme.secondaryBackground,
          shape: _softCardShape(theme),
          child: InkWell(
            onTap: () => _toggleObject(id),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Row(
                children: [
                  if (level > 0) ...[
                    Icon(Icons.subdirectory_arrow_right_rounded,
                        color: theme.secondaryText, size: 22),
                    const SizedBox(width: 4),
                  ],
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: theme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.business_outlined, color: theme.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (address.isNotEmpty)
                          Text(address,
                              style: theme.bodySmall.override(
                                  fontFamily: 'SFProText',
                                  color: theme.secondaryText,
                                  letterSpacing: 0.0)),
                      ],
                    ),
                  ),
                  if (childCount > 0) ...[
                    Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                        color: level == 0
                            ? theme.primary.withOpacity(0.10)
                            : theme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        childCount.toString(),
                        style: theme.bodySmall.override(
                          fontFamily: 'SFProText',
                          color: level == 0 ? theme.secondaryText : theme.info,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert_rounded, color: theme.secondaryText),
                    onSelected: (value) async {
                      if (value == 'add_object') {
                        await _showAddObjectDialog(parentObjectId: id);
                      } else if (value == 'add_area') {
                        await _showAddAreaDialog(id);
                      } else if (value == 'edit') {
                        await _showEditObjectDialog(
                          objectId: id,
                          initialTitle: title,
                          initialAddress: address,
                        );
                      } else if (value == 'delete') {
                        await _confirmDeleteObject(objectId: id, title: title);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'add_object',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Добавить объект',
                          kkText: 'Нысан қосу',
                        )),
                      ),
                      PopupMenuItem(
                        value: 'add_area',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Добавить участок',
                          kkText: 'Учаске қосу',
                        )),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Редактировать',
                          kkText: 'Өзгерту',
                        )),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(FFLocalizations.of(context).getVariableText(
                          ruText: 'Удалить',
                          kkText: 'Жою',
                        )),
                      ),
                    ],
                  ),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: theme.secondaryText,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (expanded) ...[
          for (final child in (_childObjects[id] ?? const <dynamic>[]))
            _objectTile(context, child, level: level + 1),
          for (final area in (_childAreas[id] ?? const <dynamic>[]))
            _areaTile(context, area, parentObjectId: id),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.secondaryBackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: theme.primaryText,
          onPressed: () => context.safePop(),
        ),
        title: Text(
          FFLocalizations.of(context)
              .getVariableText(ruText: 'Объекты и участки', kkText: 'Нысандар мен учаскелер'),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            fontSize: 18,
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _showAddObjectDialog(),
        backgroundColor: theme.primary,
        child: Icon(Icons.add, color: theme.info),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRoot,
        child: _loadingRoot
            ? const Center(child: CircularProgressIndicator())
            : _rootError != null
                ? ListView(children: [Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(_rootError!,
                        style: theme.bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            color: theme.error)),
                  )])
                : ListView(
                    padding: const EdgeInsetsDirectional.only(bottom: 24),
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 4),
                        child: Text(
                          FFLocalizations.of(context).getVariableText(
                            ruText: 'Объекты и участки',
                            kkText: 'Нысандар мен учаскелер',
                          ),
                          style: theme.bodyLarge.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      for (final obj in _rootObjects)
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 6),
                          child: _objectTile(context, obj, level: 0),
                        ),
                    ],
                  ),
      ),
    );
  }
}
