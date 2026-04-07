import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '/auth/custom_auth/auth_util.dart';
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

class AddEquipmentSimpleWidget extends StatefulWidget {
  const AddEquipmentSimpleWidget({
    super.key,
    this.areaId,
    this.areaTitle,
    this.objectTitle,
    this.categoryCode,
  });

  final int? areaId;
  final String? areaTitle;
  final String? objectTitle;
  final String? categoryCode;

  static String routeName = 'AddEquipmentSimple';
  static String routePath = '/addEquipmentSimple';

  @override
  State<AddEquipmentSimpleWidget> createState() =>
      _AddEquipmentSimpleWidgetState();
}

class _AddEquipmentSimpleWidgetState extends State<AddEquipmentSimpleWidget> {
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

  final List<FFUploadedFile> _photoFiles = [];
  int _selectedAvatarIndex = 0;

  bool _isSubmitting = false;

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


  void _onNameFocusChanged() {
    if (_nameFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _nameFieldKey.currentContext;
        if (ctx != null) {
            Scrollable.ensureVisible(
              ctx,
              alignment: 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_onNameFocusChanged);
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Добавить оборудование',
                  kkText: 'Жабдық қосу',
                ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (widget.areaTitle != null)
                Text(
                  widget.areaTitle!,
                  style: theme.bodySmall.override(
                    fontFamily: 'SFProText',
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    color: theme.secondaryText,
                  ),
                ),
            ],
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
                  _buildManufacturerSection(theme),
                  const SizedBox(height: 12.0),
                  _buildModelSection(theme),
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
                                    FFLocalizations.of(context).getVariableText(
                                      ruText: 'Выберите тип оборудования',
                                      kkText: 'Жабдық түрін таңдаңыз',
                                    ),
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
                            if (widget.areaId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    FFLocalizations.of(context).getVariableText(
                                      ruText:
                                          'Не удалось определить участок (area)',
                                      kkText: 'Учаске анықталмады (area)',
                                    ),
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

                              final effectiveCategory = _selectedCategory ??
                                  widget.categoryCode ??
                                  'basic_equipment';

                              final Map<String, dynamic> body = {
                                'title': _nameController.text,
                                'status': 'in_progress',
                                'category': effectiveCategory,
                                'type': typeId,
                                'departments': <dynamic>[],
                                'barcode': _barcodeController.text.isEmpty
                                    ? null
                                    : _barcodeController.text,
                                'area': _isCashierRole
                                    ? int.tryParse(_selectedAreaIdForCashier ??
                                        widget.areaId?.toString() ??
                                        '')
                                    : widget.areaId,
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
                                'criticality': _criticality ?? 'medium',
                                'provider': null,
                                'parent': null,
                                'productive_asset': null,
                              };

                              if (_isCashierRole) {
                                final powerText = _powerController.text.trim();
                                body['power'] = powerText.isEmpty
                                    ? null
                                    : num.tryParse(powerText);
                              }

                              final categoryCode = effectiveCategory;
                              if (categoryCode == 'basic_equipment' ||
                                  categoryCode == 'periphery') {
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

                              if (_photoFiles.isNotEmpty) {
                                final fileObjects = _photoFiles.map((f) {
                                  final rawBase64 = actions.convertToBase64(f);
                                  final bytesLength = f.bytes?.length ?? 0;
                                  final sizeMb = (bytesLength / (1024 * 1024))
                                      .toStringAsFixed(2);
                                  final fileName = f.name ?? f.originalFilename;
                                  final extension =
                                      fileName.split('.').last.toLowerCase();
                                  final mime = extension == 'jpg' ||
                                          extension == 'jpeg'
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

                                final safeIndex = _selectedAvatarIndex < 0
                                    ? 0
                                    : (_selectedAvatarIndex >= fileObjects.length
                                        ? 0
                                        : _selectedAvatarIndex);
                                body['files'] = fileObjects;
                                body['img'] = fileObjects[safeIndex];
                              } else {
                                body['img'] = null;
                                body['files'] = <dynamic>[];
                              }

                              final token = authManager.authenticationToken;
                              final response = await CreateEquipmentCall.call(
                                access: token,
                                contentJson: body,
                              );

                              if (response.succeeded) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      FFLocalizations.of(context)
                                          .getVariableText(
                                        ruText:
                                            'Оборудование успешно добавлено',
                                        kkText: 'Жабдық сәтті қосылды',
                                      ),
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
                                String errorMsg = FFLocalizations.of(context)
                                    .getVariableText(
                                  ruText: 'Ошибка при добавлении оборудования',
                                  kkText: 'Жабдықты қосу қатесі',
                                );
                                final body = response.jsonBody;
                                if (body is Map) {
                                  final messages = <String>[];
                                  for (final entry in body.entries) {
                                    if (entry.value is List) {
                                      for (final item in entry.value as List) {
                                        if (item is String) {
                                          messages.add(item);
                                        }
                                      }
                                    }
                                  }
                                  if (messages.isNotEmpty) {
                                    errorMsg = messages.join('\n');
                                  }
                                }
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        errorMsg,
                                        style: theme.bodyMedium.override(
                                          fontFamily: 'SFProText',
                                          letterSpacing: 0.0,
                                          color: theme.primaryBackground,
                                        ),
                                      ),
                                      backgroundColor: theme.error,
                                      duration: const Duration(seconds: 4),
                                    ),
                                  );
                                }
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isSubmitting = false;
                                });
                              }
                            }
                          },
                    text: FFLocalizations.of(context).getVariableText(
                      ruText: 'Добавить',
                      kkText: 'Қосу',
                    ),
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
                  _photoFiles.add(uploaded);
                  if (_photoFiles.length == 1) {
                    _selectedAvatarIndex = 0;
                  }
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
              child: _photoFiles.isEmpty
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
                        itemCount: _photoFiles.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final bytes = _photoFiles[index].bytes;
                          final isSelected = index == _selectedAvatarIndex;
                          return InkWell(
                            onTap: () => setState(() {
                              _selectedAvatarIndex = index;
                            }),
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
                                    child: bytes == null
                                        ? const SizedBox.shrink()
                                        : Image.memory(
                                            bytes,
                                            fit: BoxFit.cover,
                                            width: 96,
                                            height: 96,
                                          ),
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
                                          _photoFiles.removeAt(index);
                                          if (_photoFiles.isEmpty) {
                                            _selectedAvatarIndex = 0;
                                          } else if (_selectedAvatarIndex >=
                                              _photoFiles.length) {
                                            _selectedAvatarIndex =
                                                _photoFiles.length - 1;
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
          FFLocalizations.of(context).getVariableText(
            ruText: 'Штрих‑код',
            kkText: 'Штрих‑код',
          ),
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
                  hintText: FFLocalizations.of(context).getVariableText(
                    ruText: 'Отсканируйте или введите код',
                    kkText: 'Кодты сканерлеңіз немесе енгізіңіз',
                  ),
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

  final FocusNode _nameFocusNode = FocusNode();
  final GlobalKey _nameFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(_onNameFocusChanged);
    const allowed = {'basic_equipment', 'furniture', 'periphery'};
    final fromRoute = widget.categoryCode;
    _selectedCategory = (fromRoute != null && allowed.contains(fromRoute))
        ? fromRoute
        : 'basic_equipment';
  }

  Widget _buildNameFieldWithSuggestions(FlutterFlowTheme theme) {
    return Builder(
      key: _nameFieldKey,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          FFLocalizations.of(context).getVariableText(
            ruText: 'Название',
            kkText: 'Атауы',
          ),
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
      ),
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
          onChanged: (val) {
            setState(() {
              _selectedCategory = val;
            });
          },
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
            isManual
                ? FFLocalizations.of(context).getVariableText(
                    ruText: 'Из списка',
                    kkText: 'Тізімнен',
                  )
                : FFLocalizations.of(context).getVariableText(
                    ruText: 'Ввести вручную',
                    kkText: 'Қолмен енгізу',
                  ),
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
              FFLocalizations.of(context).getVariableText(
                ruText: 'Тип',
                kkText: 'Түрі',
              ),
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
                maxHeight: 500,
                textStyle: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  letterSpacing: 0.0,
                ),
                hintText: FFLocalizations.of(context).getVariableText(
                  ruText: 'Выберите тип оборудования',
                  kkText: 'Жабдық түрін таңдаңыз',
                ),
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

  Widget _buildManufacturerSection(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FFLocalizations.of(context).getVariableText(
                ruText: 'Производитель',
                kkText: 'Өндіруші',
              ),
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
                hintText: FFLocalizations.of(context).getVariableText(
                  ruText: 'Выберите производителя',
                  kkText: 'Өндірушіні таңдаңыз',
                ),
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

  Widget _buildModelSection(FlutterFlowTheme theme) {
    final token = authManager.authenticationToken;
    final forceManual = _isManualManufacturer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              FFLocalizations.of(context).getVariableText(
                ruText: 'Модель',
                kkText: 'Модель',
              ),
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
                hintText: FFLocalizations.of(context).getVariableText(
                  ruText: 'Выберите модель',
                  kkText: 'Модельді таңдаңыз',
                ),
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
        const SizedBox(height: 8.0),
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
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.secondaryText,
            size: 24.0,
          ),
          fillColor: theme.secondaryBackground,
          elevation: 0,
          borderColor: theme.alternate,
          borderWidth: 1.0,
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
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.secondaryText,
                size: 24.0,
              ),
              fillColor: theme.secondaryBackground,
              elevation: 0,
              borderColor: theme.alternate,
              borderWidth: 1.0,
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
}

