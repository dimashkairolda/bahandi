import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_manager.dart';
import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/uploaded_file.dart';
import '/site_equipment/equipment_name_suggestions.dart';

class EditEquipmentSimpleWidget extends StatefulWidget {
  const EditEquipmentSimpleWidget({
    super.key,
    required this.equipmentJson,
  });

  final dynamic equipmentJson;

  static String routeName = 'EditEquipmentSimple';
  static String routePath = '/editEquipmentSimple';

  @override
  State<EditEquipmentSimpleWidget> createState() =>
      _EditEquipmentSimpleWidgetState();
}

class _EditEquipmentSimpleWidgetState extends State<EditEquipmentSimpleWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  FormFieldController<String>? _typeController;
  String? _selectedType;
  bool _isManualType = false;
  final TextEditingController _manualTypeController = TextEditingController();

  FormFieldController<String>? _manufacturerController;
  String? _selectedManufacturer;
  bool _isManualManufacturer = false;
  final TextEditingController _manualManufacturerController =
      TextEditingController();

  FormFieldController<String>? _modelController;
  String? _selectedModel;
  bool _isManualModel = false;
  final TextEditingController _manualModelController = TextEditingController();

  final List<FFUploadedFile> _newPhotoFiles = [];
  int _selectedAvatarIndex = 0; // индекс в списке (existing + new)

  bool _isSubmitting = false;

  int? _areaId;
  int? _equipmentId;
  int? _draftId;
  String? _categoryCode;
  List<dynamic> _existingFiles = [];

  // Доп. поля только для кассира (в старых требованиях роль = director)
  final TextEditingController _powerController = TextEditingController();
  DateTime? _operationalDate;
  String? _criticality;
  FormFieldController<String>? _criticalityController;
  String? _selectedAreaIdForCashier;
  FormFieldController<String>? _areaControllerForCashier;
  String? _selectedCategory;
  FormFieldController<String>? _categoryController;

  String get _userRole => valueOrDefault<String>(
        getJsonField(
          FFAppState().account,
          r'''$.role''',
        )?.toString(),
        '',
      );

  bool get _isCashierRole {
    return _userRole == 'director' ||
        _userRole == '"director"' ||
        _userRole == 'cashier' ||
        _userRole == '"cashier"';
  }

  @override
  void initState() {
    super.initState();
    _applyEquipmentMap();
  }

  void _applyEquipmentMap() {
    final map = (widget.equipmentJson ?? {}) as Map<String, dynamic>;
    final files = map['files'];
    if (files is List) {
      _existingFiles = files.map((e) {
        if (e is Map<String, dynamic>) {
          final copy = Map<String, dynamic>.from(e);
          final url = copy['url'];
          if (url is String && url.startsWith('/')) {
            copy['url'] = 'https://app.etry.kz$url';
          }
          return copy;
        }
        return e;
      }).toList();
    } else {
      _existingFiles = [];
    }
    _equipmentId = map['id'] as int?;
    _areaId = map['area'] as int?;
    _categoryCode = (map['category'] ?? map['category_code'] ?? '').toString();
    const allowed = {'basic_equipment', 'furniture', 'periphery'};
    _selectedCategory =
        allowed.contains(_categoryCode) ? _categoryCode : 'basic_equipment';

    _selectedAvatarIndex = 0;

    _nameController.text = (map['title'] ?? '').toString();
    _barcodeController.text = (map['barcode'] ?? '').toString();

    final powerRaw = map['power'];
    if (powerRaw != null && powerRaw.toString().isNotEmpty && powerRaw.toString() != 'null') {
      _powerController.text = powerRaw.toString();
    }
    final critRaw = (map['criticality'] ?? '').toString().trim();
    _criticality = critRaw.isEmpty || critRaw == 'null' ? null : critRaw;

    final opDate = map['operational_date'];
    if (opDate is String && opDate.isNotEmpty && opDate != 'null') {
      _operationalDate = DateTime.tryParse(opDate);
    }

    if (_isCashierRole) {
      _selectedAreaIdForCashier = (map['area'] ?? _areaId)?.toString();
    }

    // type: prefer top-level int, fallback to type_info.id
    final topType = map['type'];
    if (topType != null && topType.toString() != 'null') {
      _selectedType = topType.toString();
    } else {
      final typeInfo = map['type_info'] as Map<String, dynamic>?;
      if (typeInfo != null && typeInfo['id'] != null) {
        _selectedType = typeInfo['id'].toString();
      }
    }

    final topMfr = map['manufacturer'];
    if (topMfr != null && topMfr.toString() != 'null') {
      _selectedManufacturer = topMfr.toString();
    } else {
      final manufacturerInfo = map['manufacturer_info'] as Map<String, dynamic>?;
      if (manufacturerInfo != null && manufacturerInfo['id'] != null) {
        _selectedManufacturer = manufacturerInfo['id'].toString();
      }
    }

    final topModel = map['model'];
    if (topModel != null && topModel.toString() != 'null') {
      _selectedModel = topModel.toString();
    } else {
      final modelInfo = map['model_info'] as Map<String, dynamic>?;
      if (modelInfo != null && modelInfo['id'] != null) {
        _selectedModel = modelInfo['id'].toString();
      }
    }

    final draftInfo = map['draft_info'] as Map<String, dynamic>?;
    if (draftInfo != null) {
      _draftId = draftInfo['id'] as int?;

      if (draftInfo['type_field'] == true && draftInfo['type'] != null) {
        _isManualType = true;
        _manualTypeController.text = draftInfo['type'].toString();
        _selectedType = null;
      }
      if (draftInfo['manufacturer_field'] == true &&
          draftInfo['manufacturer'] != null) {
        _isManualManufacturer = true;
        _manualManufacturerController.text =
            draftInfo['manufacturer'].toString();
        _selectedManufacturer = null;
      }
      if (draftInfo['model_field'] == true && draftInfo['model'] != null) {
        _isManualModel = true;
        _manualModelController.text = draftInfo['model'].toString();
        _selectedModel = null;
      }
    }
  }

  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _barcodeController.dispose();
    _nameController.dispose();
    _manualTypeController.dispose();
    _manualManufacturerController.dispose();
    _manualModelController.dispose();
    _powerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: theme.primaryText,
              size: 24.0,
            ),
            onPressed: () {
              context.safePop();
            },
          ),
          title: Text(
            'Редактировать оборудование',
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhotoBlock(theme),
                  const SizedBox(height: 16.0),
                  _buildBarcodeField(theme),
                  const SizedBox(height: 12.0),
                  _buildNameFieldWithSuggestions(theme),
                  const SizedBox(height: 12.0),
                  _buildCategoryDropdown(theme),
                  const SizedBox(height: 12.0),
                  _buildTypeDropdown(theme),
                  const SizedBox(height: 12.0),
                  _buildManufacturerDropdown(theme),
                  const SizedBox(height: 12.0),
                  _buildModelDropdown(theme),
                  const SizedBox(height: 24.0),
                  if (_isCashierRole) ...[
                    _buildCashierExtraFields(theme),
                    const SizedBox(height: 24.0),
                  ],
                  FFButtonWidget(
                    onPressed: _isSubmitting
                        ? null
                        : () async {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }
                            final hasType = _isManualType
                                ? _manualTypeController.text.trim().isNotEmpty
                                : _selectedType != null;
                            if (!hasType) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Выберите тип оборудования',
                                    style: theme.bodyMedium.override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                      color: theme.primaryBackground,
                                    ),
                                  ),
                                  backgroundColor: theme.error,
                                ),
                              );
                              return;
                            }
                            if (_areaId == null || _equipmentId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Не удалось определить оборудование или участок',
                                    style: theme.bodyMedium.override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                      color: theme.primaryBackground,
                                    ),
                                  ),
                                  backgroundColor: theme.error,
                                ),
                              );
                              return;
                            }

                            setState(() {
                              _isSubmitting = true;
                            });

                            try {
                              final typeId = _isManualType
                                  ? null
                                  : int.tryParse(_selectedType!);
                              final manufacturerId = _isManualManufacturer
                                  ? null
                                  : int.tryParse(_selectedManufacturer ?? '');
                              final modelId = _isManualModel
                                  ? null
                                  : int.tryParse(_selectedModel ?? '');

                              final Map<String, dynamic> body = {
                                'title': _nameController.text,
                                'type': typeId,
                                'status': 'draft',
                                'category': _selectedCategory ?? _categoryCode,
                                'departments': <dynamic>[],
                                'barcode': _barcodeController.text.isEmpty
                                    ? null
                                    : _barcodeController.text,
                                'area': _isCashierRole
                                    ? int.tryParse(_selectedAreaIdForCashier ??
                                        _areaId?.toString() ??
                                        '')
                                    : _areaId,
                                'has_monitoring': false,
                                'manufacturer': manufacturerId,
                                'model': modelId,
                                'factory_number': null,
                                'inventory_number': null,
                                'dispatch_number': null,
                                'operating_time': null,
                                'operational_date': _isCashierRole &&
                                        _operationalDate != null
                                    ? dateTimeFormat(
                                        'yyyy-MM-dd',
                                        _operationalDate,
                                        locale: 'en',
                                      )
                                    : null,
                                'technical_parameters': <dynamic>[],
                                'operational_parameters': <dynamic>[],
                                'spare_parts': <dynamic>[],
                                'works': <dynamic>[],
                                'catalog_group': null,
                                'criticality':
                                    _isCashierRole ? _criticality : null,
                                'parent': null,
                                'productive_asset': null,
                                'number_scheme': null,
                                'img': null,
                                'files': _existingFiles,
                              };

                              if (_isCashierRole) {
                                final powerText = _powerController.text.trim();
                                body['power'] = powerText.isEmpty
                                    ? null
                                    : num.tryParse(powerText);
                              }

                              final effectiveCategory =
                                  _selectedCategory ?? _categoryCode;
                              if (effectiveCategory == 'basic_equipment' ||
                                  effectiveCategory == 'periphery') {
                                final draftType = _isManualType
                                    ? _manualTypeController.text.trim()
                                    : null;
                                final draftManufacturer = _isManualManufacturer
                                    ? _manualManufacturerController.text.trim()
                                    : null;
                                final draftModel = _isManualModel
                                    ? _manualModelController.text.trim()
                                    : null;

                                final draft = <String, dynamic>{
                                  'type': null,
                                  'type_field': false,
                                  'manufacturer': null,
                                  'manufacturer_field': false,
                                  'model': null,
                                  'model_field': false,
                                };
                                if (_draftId != null) {
                                  draft['id'] = _draftId;
                                }
                                if (draftType != null &&
                                    draftType.isNotEmpty) {
                                  draft['type'] = draftType;
                                  draft['type_field'] = true;
                                }
                                if (draftManufacturer != null &&
                                    draftManufacturer.isNotEmpty) {
                                  draft['manufacturer'] = draftManufacturer;
                                  draft['manufacturer_field'] = true;
                                }
                                if (draftModel != null &&
                                    draftModel.isNotEmpty) {
                                  draft['model'] = draftModel;
                                  draft['model_field'] = true;
                                }
                                body['draft'] = draft;
                              }

                              // добавляем новые фото в files[] и выбираем img по _selectedAvatarIndex
                              final newFileObjects = _newPhotoFiles.map((f) {
                                final rawBase64 = actions.convertToBase64(f);
                                final bytesLength = f.bytes?.length ?? 0;
                                final sizeMb = (bytesLength / (1024 * 1024))
                                    .toStringAsFixed(2);
                                final fileName = f.name ?? f.originalFilename;
                                final extension =
                                    fileName.split('.').last.toLowerCase();
                                final mime =
                                    extension == 'jpg' || extension == 'jpeg'
                                        ? 'image/jpeg'
                                        : 'image/png';
                                final dataUri = 'data:$mime;base64,$rawBase64';
                                return {
                                  'data': dataUri,
                                  'extension': extension,
                                  'size': sizeMb,
                                  'title': fileName,
                                };
                              }).toList();

                              final mergedFiles = <dynamic>[
                                ..._existingFiles,
                                ...newFileObjects,
                              ];
                              body['files'] = mergedFiles;

                              if (mergedFiles.isNotEmpty) {
                                final safeIndex = _selectedAvatarIndex < 0
                                    ? 0
                                    : (_selectedAvatarIndex >= mergedFiles.length
                                        ? 0
                                        : _selectedAvatarIndex);
                                body['img'] = mergedFiles[safeIndex];
                              }

                              final token = authManager.authenticationToken;
                              final response =
                                  await ApiManager.instance.makeApiCall(
                                callName: 'UpdateEquipment',
                                apiUrl:
                                    'https://app.etry.kz/api/v1/equipment/$_equipmentId',
                                callType: ApiCallType.PUT,
                                headers: {
                                  'Authorization': 'JWT $token',
                                },
                                params: {},
                                body: _serializeJson(body),
                                bodyType: BodyType.JSON,
                                returnBody: true,
                                encodeBodyUtf8: true,
                                decodeUtf8: true,
                                cache: false,
                                isStreamingApi: false,
                                alwaysAllowBody: false,
                              );

                              if (response.succeeded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Оборудование обновлено',
                                      style: theme.bodyMedium.override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                    backgroundColor: theme.primary,
                                  ),
                                );
                                context.safePop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Ошибка при обновлении оборудования',
                                      style: theme.bodyMedium.override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
                                        color: theme.primaryBackground,
                                      ),
                                    ),
                                    backgroundColor: theme.error,
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isSubmitting = false;
                                });
                              }
                            }
                          },
                    text: 'Сохранить изменения',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 52.0,
                      color: theme.primary,
                      textStyle: theme.titleMedium.override(
                        fontFamily: 'SFProText',
                        letterSpacing: 0.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoBlock(FlutterFlowTheme theme) {
    final totalPhotos = _existingFiles.length + _newPhotoFiles.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Фото оборудования',
            kkText: 'Жабдықтың фотосы',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final selectedMedia = await selectMedia(
                  mediaSource: MediaSource.camera,
                  multiImage: false,
                );
                if (selectedMedia == null || selectedMedia.isEmpty) return;
                final m = selectedMedia.first;
                final uploaded = FFUploadedFile(
                  name: m.storagePath.split('/').last,
                  bytes: m.bytes,
                  height: m.dimensions?.height,
                  width: m.dimensions?.width,
                  blurHash: m.blurHash,
                  originalFilename: m.originalFilename,
                );
                setState(() {
                  _newPhotoFiles.add(uploaded);
                });
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.alternate),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined,
                        color: theme.primary, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      FFLocalizations.of(context).getVariableText(
                        ruText: 'Камера',
                        kkText: 'Камера',
                      ),
                      textAlign: TextAlign.center,
                      style: theme.bodySmall.override(
                        fontFamily: 'SFProText',
                        letterSpacing: 0.0,
                        color: theme.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: totalPhotos == 0
                  ? Container(
                      height: 96,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        FFLocalizations.of(context).getVariableText(
                          ruText: 'Добавьте фото оборудования',
                          kkText: 'Жабдықтың фотосын қосыңыз',
                        ),
                        style: theme.bodySmall.override(
                          fontFamily: 'SFProText',
                          letterSpacing: 0.0,
                          color: theme.secondaryText,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 96,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: totalPhotos,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final isSelected = index == _selectedAvatarIndex;

                          Uint8List? bytes;
                          String? url;
                          if (index < _existingFiles.length) {
                            final f = _existingFiles[index];
                            final rawUrl =
                                f is Map ? f['url']?.toString() : null;
                            if (rawUrl != null && rawUrl.isNotEmpty) {
                              url = rawUrl.startsWith('http')
                                  ? rawUrl
                                  : 'https://app.etry.kz$rawUrl';
                            }
                          } else {
                            bytes = _newPhotoFiles[index - _existingFiles.length]
                                .bytes;
                          }

                          return InkWell(
                            onTap: () =>
                                setState(() => _selectedAvatarIndex = index),
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? theme.primary
                                      : theme.alternate,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: bytes != null
                                        ? Image.memory(
                                            bytes,
                                            fit: BoxFit.cover,
                                            width: 96,
                                            height: 96,
                                          )
                                        : (url != null
                                            ? Image.network(
                                                url,
                                                fit: BoxFit.cover,
                                                width: 96,
                                                height: 96,
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      left: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.primary,
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Text(
                                          FFLocalizations.of(context)
                                              .getVariableText(
                                            ruText: 'Аватар',
                                            kkText: 'Аватар',
                                          ),
                                          style: theme.bodySmall.override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    right: 6,
                                    top: 6,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (index < _existingFiles.length) {
                                            _existingFiles.removeAt(index);
                                          } else {
                                            _newPhotoFiles.removeAt(
                                                index - _existingFiles.length);
                                          }
                                          final total = _existingFiles.length +
                                              _newPhotoFiles.length;
                                          if (total <= 0) {
                                            _selectedAvatarIndex = 0;
                                          } else if (_selectedAvatarIndex >=
                                              total) {
                                            _selectedAvatarIndex = total - 1;
                                          }
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(999),
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBarcodeField(FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Штрих‑код',
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  hintText: 'Отсканируйте или введите код',
                  hintStyle: theme.bodyMedium.override(
                    fontFamily: 'SFProText',
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                  filled: true,
                  fillColor: theme.secondaryBackground,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: theme.alternate,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: theme.primary,
                      width: 2.0,
                    ),
                  ),
                ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  letterSpacing: 0.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            FlutterFlowIconButton(
              borderRadius: 12.0,
              borderWidth: 1.0,
              buttonSize: 44.0,
              fillColor: theme.primary.withOpacity(0.06),
              icon: Icon(
                Icons.qr_code_scanner_rounded,
                color: theme.primary,
                size: 22.0,
              ),
              onPressed: () async {
                final scanned = await showDialog<String>(
                  context: context,
                  barrierColor: Colors.black54,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.black,
                      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 280.0,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: MobileScanner(
                                onDetect: (capture) {
                                  final barcodes = capture.barcodes;
                                  if (barcodes.isEmpty) return;
                                  final value = barcodes.first.rawValue;
                                  if (value == null) return;
                                  Navigator.of(context).pop(value);
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(null),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                if (scanned != null && scanned.isNotEmpty) {
                  setState(() {
                    _barcodeController.text = scanned;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNameFieldWithSuggestions(FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Название',
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        EquipmentNameAutocompleteField(
          controller: _nameController,
          focusNode: _nameFocusNode,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown(FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Категория',
            kkText: 'Санат',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        FlutterFlowDropDown<String>(
          controller: _categoryController ??=
              FormFieldController<String>(_selectedCategory),
          options: const ['basic_equipment', 'furniture', 'periphery'],
          optionLabels: [
            FFLocalizations.of(context).getVariableText(
              ruText: 'Основное оборудование',
              kkText: 'Негізгі жабдық',
            ),
            FFLocalizations.of(context).getVariableText(
              ruText: 'Мебель',
              kkText: 'Жиһаз',
            ),
            FFLocalizations.of(context).getVariableText(
              ruText: 'Периферия',
              kkText: 'Периферия',
            ),
          ],
          onChanged: (val) => setState(() => _selectedCategory = val),
          width: double.infinity,
          height: 48.0,
          textStyle: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
          ),
          hintText: FFLocalizations.of(context).getVariableText(
            ruText: 'Выберите категорию',
            kkText: 'Санатты таңдаңыз',
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.secondaryText,
            size: 24.0,
          ),
          fillColor: theme.secondaryBackground,
          elevation: 0.0,
          borderColor: theme.alternate,
          borderWidth: 1.0,
          borderRadius: 12.0,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
          hidesUnderline: true,
          isSearchable: false,
          isMultiSelect: false,
        ),
      ],
    );
  }

  void _setManualType(bool manual) {
    setState(() {
      _isManualType = manual;
      if (manual) {
        _selectedType = null;
        _typeController?.value = null;
      } else {
        _manualTypeController.clear();
      }
    });
  }

  void _setManualManufacturer(bool manual) {
    setState(() {
      _isManualManufacturer = manual;
      if (manual) {
        _selectedManufacturer = null;
        _manufacturerController?.value = null;
        _isManualModel = true;
        _selectedModel = null;
        _modelController?.value = null;
      } else {
        _manualManufacturerController.clear();
      }
    });
  }

  void _setManualModel(bool manual) {
    setState(() {
      _isManualModel = manual;
      if (manual) {
        _selectedModel = null;
        _modelController?.value = null;
      } else {
        _manualModelController.clear();
      }
    });
  }

  Widget _buildManualToggle(
    FlutterFlowTheme theme, {
    required bool isManual,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!isManual),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isManual ? Icons.edit : Icons.list,
            size: 16.0,
            color: theme.primary,
          ),
          const SizedBox(width: 4.0),
          Text(
            isManual ? 'Из списка' : 'Ввести вручную',
            style: theme.bodySmall.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
              color: theme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _manualInputDecoration(
    FlutterFlowTheme theme, {
    required String hint,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: theme.bodyMedium.override(
        fontFamily: 'SFProText',
        letterSpacing: 0.0,
        color: theme.secondaryText,
      ),
      filled: true,
      fillColor: theme.secondaryBackground,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: theme.alternate),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: theme.primary, width: 2.0),
      ),
    );
  }

  Widget _buildTypeDropdown(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Тип',
              style: theme.bodyMedium.override(
                fontFamily: 'SFProText',
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            _buildManualToggle(
              theme,
              isManual: _isManualType,
              onChanged: _setManualType,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        if (_isManualType)
          TextFormField(
            controller: _manualTypeController,
            decoration: _manualInputDecoration(
              theme,
              hint: 'Введите тип оборудования',
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
            ),
          )
        else
          FutureBuilder<ApiCallResponse>(
            future: GetEquipTypesCall.call(access: token),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(theme.primary),
                    ),
                  ),
                );
              }
              final response = snapshot.data!;
              final data =
                  (GetEquipTypesCall.data(response.jsonBody) ?? []).toList();

              final options = data
                  .map<String>(
                      (e) => (e as Map<String, dynamic>)['id'].toString())
                  .toList();
              final labels = data
                  .map<String>((e) =>
                      ((e as Map<String, dynamic>)['title'] ?? '').toString())
                  .toList();

              return FlutterFlowDropDown<String>(
                controller: _typeController ??=
                    FormFieldController<String>(_selectedType),
                options: options,
                optionLabels: labels,
                onChanged: (val) {
                  setState(() {
                    _selectedType = val;
                  });
                },
                width: double.infinity,
                height: 48.0,
                maxHeight: 300.0,
                textStyle: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  letterSpacing: 0.0,
                ),
                hintText: 'Выберите тип оборудования',
                isSearchable: true,
                searchHintText: 'Поиск типа оборудования',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: theme.secondaryText,
                  size: 24.0,
                ),
                fillColor: theme.secondaryBackground,
                elevation: 0.0,
                borderColor: theme.alternate,
                borderWidth: 1.0,
                borderRadius: 12.0,
                margin: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 4.0, 12.0, 4.0),
                hidesUnderline: true,
              );
            },
          ),
      ],
    );
  }

  Widget _buildManufacturerDropdown(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Производитель',
              style: theme.bodyMedium.override(
                fontFamily: 'SFProText',
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            _buildManualToggle(
              theme,
              isManual: _isManualManufacturer,
              onChanged: _setManualManufacturer,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        if (_isManualManufacturer)
          TextFormField(
            controller: _manualManufacturerController,
            decoration: _manualInputDecoration(
              theme,
              hint: 'Введите производителя',
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
            ),
          )
        else
          FutureBuilder<ApiCallResponse>(
            future: GetEquipManufacturerCall.call(access: token),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(theme.primary),
                    ),
                  ),
                );
              }
              final response = snapshot.data!;
              final data =
                  (GetEquipManufacturerCall.data(response.jsonBody) ?? [])
                      .toList();

              if (data.isEmpty) {
                return Text(
                  'Нет доступных производителей',
                  style: theme.bodySmall.override(
                    fontFamily: 'SFProText',
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                );
              }

              final options = data
                  .map<String>(
                      (e) => (e as Map<String, dynamic>)['id'].toString())
                  .toList();
              final labels = data
                  .map<String>((e) =>
                      ((e as Map<String, dynamic>)['title'] ?? '').toString())
                  .toList();

              return FlutterFlowDropDown<String>(
                controller: _manufacturerController ??=
                    FormFieldController<String>(_selectedManufacturer),
                options: options,
                optionLabels: labels,
                onChanged: (val) {
                  setState(() {
                    _selectedManufacturer = val;
                    _selectedModel = null;
                    _modelController?.value = null;
                  });
                },
                width: double.infinity,
                height: 48.0,
                maxHeight: 400,
                textStyle: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  letterSpacing: 0.0,
                ),
                hintText: 'Выберите производителя',
                isSearchable: true,
                searchHintText: 'Поиск производителя',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: theme.secondaryText,
                  size: 24.0,
                ),
                fillColor: theme.secondaryBackground,
                elevation: 0.0,
                borderColor: theme.alternate,
                borderWidth: 1.0,
                borderRadius: 12.0,
                margin: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 4.0, 12.0, 4.0),
                hidesUnderline: true,
              );
            },
          ),
      ],
    );
  }

  Widget _buildModelDropdown(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;
    final forceManual = _isManualManufacturer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Модель',
              style: theme.bodyMedium.override(
                fontFamily: 'SFProText',
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (!forceManual)
              _buildManualToggle(
                theme,
                isManual: _isManualModel,
                onChanged: _setManualModel,
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        if (_isManualModel || forceManual)
          TextFormField(
            controller: _manualModelController,
            decoration: _manualInputDecoration(
              theme,
              hint: 'Введите модель',
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
            ),
          )
        else if (_selectedManufacturer != null)
          FutureBuilder<ApiCallResponse>(
            key: ValueKey<String>('model_mfr_$_selectedManufacturer'),
            future: GetEquipModelCall.call(
              access: token,
              id: _selectedManufacturer,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(theme.primary),
                    ),
                  ),
                );
              }
              final response = snapshot.data!;
              final data =
                  (GetEquipModelCall.data(response.jsonBody) ?? []).toList();

              if (data.isEmpty) {
                return Text(
                  'Нет доступных моделей',
                  style: theme.bodySmall.override(
                    fontFamily: 'SFProText',
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                );
              }

              final options = data
                  .map<String>(
                      (e) => (e as Map<String, dynamic>)['id'].toString())
                  .toList();
              final labels = data
                  .map<String>((e) =>
                      ((e as Map<String, dynamic>)['title'] ?? '').toString())
                  .toList();

              return FlutterFlowDropDown<String>(
                controller: _modelController ??=
                    FormFieldController<String>(_selectedModel),
                options: options,
                optionLabels: labels,
                onChanged: (val) => setState(() => _selectedModel = val),
                width: double.infinity,
                height: 48.0,
                maxHeight: 400,
                textStyle: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  letterSpacing: 0.0,
                ),
                hintText: 'Выберите модель',
                isSearchable: true,
                searchHintText: 'Поиск модели',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: theme.secondaryText,
                  size: 24.0,
                ),
                fillColor: theme.secondaryBackground,
                elevation: 0.0,
                borderColor: theme.alternate,
                borderWidth: 1.0,
                borderRadius: 12.0,
                margin: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 4.0, 12.0, 4.0),
                hidesUnderline: true,
              );
            },
          )
        else
          Text(
            'Сначала выберите производителя',
            style: theme.bodySmall.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
              color: theme.secondaryText,
            ),
          ),
      ],
    );
  }

  Widget _buildCashierExtraFields(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Дополнительные поля',
            kkText: 'Қосымша өрістер',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _powerController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: FFLocalizations.of(context).getVariableText(
              ruText: 'Мощность',
              kkText: 'Қуаты',
            ),
            filled: true,
            fillColor: theme.secondaryBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Критичность',
            kkText: 'Сындылық',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        FlutterFlowDropDown<String>(
          controller: _criticalityController ??=
              FormFieldController<String>(_criticality),
          options: const ['low', 'medium', 'high'],
          optionLabels: [
            FFLocalizations.of(context).getVariableText(
              ruText: 'Низкая',
              kkText: 'Төмен',
            ),
            FFLocalizations.of(context).getVariableText(
              ruText: 'Средняя',
              kkText: 'Орташа',
            ),
            FFLocalizations.of(context).getVariableText(
              ruText: 'Высокая',
              kkText: 'Жоғары',
            ),
          ],
          onChanged: (val) => setState(() => _criticality = val),
          width: double.infinity,
          height: 52,
          textStyle: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
          ),
          hintText: FFLocalizations.of(context).getVariableText(
            ruText: 'Критичность',
            kkText: 'Сындылық',
          ),
          fillColor: theme.secondaryBackground,
          elevation: 0,
          borderColor: Colors.transparent,
          borderWidth: 0,
          borderRadius: 12,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
          hidesUnderline: true,
          isSearchable: false,
        ),
        const SizedBox(height: 12),
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Дата ввода в эксплуатацию',
            kkText: 'Пайдалануға беру күні',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _operationalDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked == null) return;
            setState(() => _operationalDate = picked);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.date_range_rounded, color: theme.secondaryText),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _operationalDate == null
                        ? FFLocalizations.of(context).getVariableText(
                            ruText: 'Дата ввода в эксплуатацию',
                            kkText: 'Пайдалануға беру күні',
                          )
                        : dateTimeFormat(
                            'dd.MM.yyyy',
                            _operationalDate,
                            locale: FFLocalizations.of(context).languageCode,
                          ),
                    style: theme.bodyMedium.override(
                      fontFamily: 'SFProText',
                      letterSpacing: 0.0,
                      color: _operationalDate == null
                          ? theme.secondaryText
                          : theme.primaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
         Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Филиал',
            kkText: 'Филиал',
          ),
          style: theme.bodyMedium.override(
            fontFamily: 'SFProText',
            letterSpacing: 0.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        FutureBuilder<ApiCallResponse>(
          future: GetAreaCall.call(access: token),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  ),
                ),
              );
            }
            final res = snapshot.data!;
            final ids = (getJsonField(res.jsonBody, r'''$.data[:].id''', true)
                        as List?)
                    ?.map((e) => e?.toString())
                    .whereType<String>()
                    .toList() ??
                const <String>[];
            final labels =
                (getJsonField(res.jsonBody, r'''$.data[:].title''', true) as List?)
                        ?.map((e) => e?.toString())
                        .whereType<String>()
                        .toList() ??
                    const <String>[];

            return FlutterFlowDropDown<String>(
              controller: _areaControllerForCashier ??=
                  FormFieldController<String>(_selectedAreaIdForCashier),
              options: ids,
              optionLabels: labels,
              onChanged: (val) => setState(() => _selectedAreaIdForCashier = val),
              width: double.infinity,
              height: 52,
              textStyle: theme.bodyMedium.override(
                fontFamily: 'SFProText',
                letterSpacing: 0.0,
              ),
              hintText: FFLocalizations.of(context).getVariableText(
                ruText: 'Филиал',
                kkText: 'Филиал',
              ),
              fillColor: theme.secondaryBackground,
              elevation: 0,
              borderColor: Colors.transparent,
              borderWidth: 0,
              borderRadius: 12,
              margin: const EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 4.0),
              hidesUnderline: true,
              isSearchable: true,
            );
          },
        ),
      ],
    );
  }

  String _serializeJson(dynamic jsonVar) => jsonVar == null
      ? '{}'
      : jsonVar is String
          ? jsonVar
          : json.encode(jsonVar);
}

