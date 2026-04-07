import 'package:Etry/auth/custom_auth/auth_util.dart';

import 'package:Etry/backend/schema/structs/equipment_struct.dart';

import 'package:Etry/defects/defects/defects_widget.dart';

import 'package:Etry/flutter_flow/flutter_flow_icon_button.dart';

import 'package:Etry/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:easy_debounce/easy_debounce.dart';

// Убедитесь, что все эти импорты правильные

import 'package:Etry/flutter_flow/flutter_flow_theme.dart';

import 'package:Etry/flutter_flow/custom_functions.dart' as functions;

import 'package:Etry/backend/api_requests/api_calls.dart';

import 'package:Etry/backend/schema/structs/index.dart';

import 'package:Etry/defects/create_defect/create_defect_widget.dart';

import 'package:Etry/custom_code/actions/index.dart' as actions;

class ScanEquipmentPageWidget extends StatefulWidget {
  const ScanEquipmentPageWidget({super.key});

  static String routeName = 'scan';

  static String routePath = '/scan';

  @override
  State<ScanEquipmentPageWidget> createState() =>
      _ScanEquipmentPageWidgetState();
}

class _ScanEquipmentPageWidgetState extends State<ScanEquipmentPageWidget> {
  static const _searchEquipmentFields =
      '&fields=id,title,inventory_number,area_info,type_info';
  final TextEditingController _searchController = TextEditingController();

// УБРАЛ: _manualBarcodeController больше не нужен

  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoStart: true,
    cameraResolution: const Size(1080, 1920),
  );

  String? _pendingBarcode; // Код, который мы сейчас "держим" в прицеле

  DateTime? _firstDetectionTime;

  bool _isProcessing = false; // Флаг загрузки
  bool _isSearching = false;
  bool _isApiSearch = false;

  List<dynamic> _displayList = [];

  ApiCallResponse? qq;

  ApiCallResponse? zz;

  late String currentAuthenticationToken;

  @override
  void initState() {
    super.initState();

    currentAuthenticationToken = authManager.authenticationToken!;

    _filterQuickAccess('');

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);

    _searchController.dispose();

    cameraController.dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;

    // Если поле пустое или короткое, сбрасываем поиск и показываем быстрый доступ
    if (query.length <= 2) {
      _filterQuickAccess(query);
      if (_isSearching) {
        setState(() {
          _isSearching = false;
        });
      }
      return;
    }

    EasyDebounce.debounce(
      'searchDebouncer',
      const Duration(milliseconds: 500),
      () async {
        if (query.length > 2) {
          setState(() {
            _isApiSearch = true;
            _isSearching = true; // <--- ВКЛЮЧАЕМ ЛОАДЕР
            _displayList = []; // Очищаем старый список
          });

          await _searchApi(query);
        }
      },
    );
  }

  void _filterQuickAccess(String query) {
    setState(() {
      _isApiSearch = false;

      if (query.isEmpty) {
        _displayList =
            FFAppState().frequentlyUsedEquipment.map((e) => e.toMap()).toList();
      } else {
        _displayList = FFAppState()
            .frequentlyUsedEquipment
            .where((item) {
              final title = item.title.toLowerCase();

              final inventory = item.inventoryNumber.toLowerCase();

              final q = query.toLowerCase();

              return title.contains(q) || inventory.contains(q);
            })
            .map((e) => e.toMap())
            .toList();
      }
    });
  }

  Future<void> _searchApi(String query) async {
    // Выполняем запрос
    final apiResult = await GetEquipmentsPaginationCall.call(
      access: currentAuthenticationToken,
      page: 1,
      search: '&search=$query',
      fields: _searchEquipmentFields,
    );

    if (!mounted) return;

    if (apiResult.succeeded) {
      setState(() {
        _displayList = GetEquipmentsPaginationCall.data(apiResult.jsonBody) ?? [];
        _isSearching = false; // <--- ВЫКЛЮЧАЕМ ЛОАДЕР (Успех)
      });
    } else {
      setState(() {
        _displayList = [];
        _isSearching = false; // <--- ВЫКЛЮЧАЕМ ЛОАДЕР (Ошибка)
      });
    }
  }

  Future<void> _onEquipmentSelected(dynamic equipmentJson) async {
    if (equipmentJson == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              FFLocalizations.of(context).getVariableText(
                ruText: 'Ошибка! Не удалось получить данные оборудования.',
                kkText: 'Қате! Жабдық деректерін алу мүмкін болмады.',
              ),
            )),
      );

      return;
    }

    if (_isProcessing) return;

// ВКЛЮЧАЕМ ЗАГРУЗКУ

    setState(() => _isProcessing = true);

    try {
      final equipmentStruct =
          EquipmentStruct.fromMap(equipmentJson as Map<String, dynamic>);

      await actions.updateFrequentlyUsed(equipmentStruct);
    } catch (e) {
      print('Ошибка добавления в быстрый доступ: $e');
    }

    try {
      zz = await GetDefectsFormCall.call(
        access: currentAuthenticationToken,
        equipment: getJsonField(equipmentJson, r'''$.id'''),
        type: getJsonField(equipmentJson, r'''$.type_info.id'''),
      );

      if (!mounted) {
        setState(() => _isProcessing = false);

        return;
      }

      if (zz?.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              FFLocalizations.of(context).getVariableText(
                ruText: 'Ошибка: Нету доступа к этой форме.',
                kkText: 'Қате: Бұл формаға қолжетімділік жоқ.',
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );

        setState(() => _isProcessing = false);

        return;
      }

// Проверка наличия формы

      if ((zz?.succeeded ?? false) &&
          functions
                  .jsonToList(getJsonField(
                    (zz?.jsonBody ?? ''),
                    r'''$.data''',
                  ))
                  .length
                  .toString() !=
              '0') {
        dynamic structureData = getJsonField(
          (zz?.jsonBody ?? ''),
          r'''$.data[0].structure''',
        );

        if (structureData != null && structureData is List) {
          FFAppState().formresult1 = (structureData
                  .map<FormResultStruct?>(FormResultStruct.maybeFromMap)
                  .toList() as Iterable<FormResultStruct?>)
              .withoutNulls
              .toList()
              .cast<FormResultStruct>();
        } else {
          FFAppState().formresult1 = [];
        }

        setState(
            () {}); // Обновляем UI перед переходом (хотя с оверлеем это не обязательно)

        await context.pushNamed(
          CreateDefectWidget.routeName,
          queryParameters: {
            'equip': serializeParam(
              getJsonField(equipmentJson, r'''$.title''').toString(),
              ParamType.String,
            ),
            'equipId': serializeParam(
              getJsonField(equipmentJson, r'''$.id'''),
              ParamType.int,
            ),
            'ispravil': serializeParam(false, ParamType.bool),
            'priority': serializeParam(false, ParamType.bool),
            'typeId': serializeParam(
              getJsonField(equipmentJson, r'''$.type_info.id'''),
              ParamType.int,
            ),
            'formid': serializeParam(
              getJsonField((zz?.jsonBody ?? ''), r'''$.data[0].id'''),
              ParamType.int,
            ),
            'inventory': serializeParam(
              getJsonField(equipmentJson, r'''$.inventory_number''')?.toString() ?? '-',
              ParamType.String,
            ),
            'area': serializeParam(
              getJsonField(equipmentJson, r'''$.area_info.title''')
                      ?.toString() ??
                  '-',
              ParamType.String,
            ),
          }.withoutNulls,
        );
      } else {
        FFAppState().formresult1 = [];

        setState(() {});

        await context.pushNamed(
          CreateDefectWidget.routeName,
          queryParameters: {
            'equip': serializeParam(
              getJsonField(equipmentJson, r'''$.title''').toString(),
              ParamType.String,
            ),
            'equipId': serializeParam(
              getJsonField(equipmentJson, r'''$.id'''),
              ParamType.int,
            ),
            'ispravil': serializeParam(false, ParamType.bool),
            'priority': serializeParam(false, ParamType.bool),
            'typeId': serializeParam(
              getJsonField(equipmentJson, r'''$.type_info.id'''),
              ParamType.int,
            ),
            'inventory': serializeParam(
              getJsonField(equipmentJson, r'''$.inventory_number''')?.toString() ?? '-',
              ParamType.String,
            ),
            'area': serializeParam(
              getJsonField(equipmentJson, r'''$.area_info.title''')
                  .toString(),
              ParamType.String,
            ),
          }.withoutNulls,
        );
      }
    } catch (e) {
      print("Ошибка при _onEquipmentSelected: $e");
    } finally {
      if (mounted) {
// ВЫКЛЮЧАЕМ ЗАГРУЗКУ когда вернулись или закончили

        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _processScannedBarcode(String barcode) async {
    if (_isProcessing) return;

// ВКЛЮЧАЕМ ЗАГРУЗКУ

    setState(() {
      _isProcessing = true;
    });

    await cameraController.stop();

    if (barcode != '-1') {
      qq = await GetEquipmentsBarcodeCall.call(
        access: currentAuthenticationToken,
        barcode: barcode,
      );

      if (functions.emptyList(getJsonField(
        (qq?.jsonBody ?? ''),
        r'''$.data''',
        true,
      ))!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              FFLocalizations.of(context).getVariableText(
                ruText: 'Ошибка! Оборудование не найдено.',
                kkText: 'Қате! Жабдық табылмады.',
              ),
              style: TextStyle(color: FlutterFlowTheme.of(context).primaryText),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );

// Если ошибка - возобновляем камеру и убираем загрузку

        if (mounted) {
          setState(() => _isProcessing = false);

          await cameraController.start();
        }
      } else {
        try {
          final equipmentJson =
              (getJsonField((qq?.jsonBody ?? ''), r'''$.data''') as List).first;

          final equipmentStruct =
              EquipmentStruct.fromMap(equipmentJson as Map<String, dynamic>);

          await actions.updateFrequentlyUsed(equipmentStruct);
        } catch (e) {
          print('Ошибка добавления в быстрый доступ: $e');
        }

        zz = await GetDefectsFormCall.call(
          access: currentAuthenticationToken,
          equipment: getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].id'''),
          type:
              getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].type_info.id'''),
        );

        if (zz?.statusCode == 403) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                FFLocalizations.of(context).getVariableText(
                  ruText: 'Ошибка: Нету доступа к этой форме.',
                  kkText: 'Қате: Бұл формаға қолжетімділік жоқ.',
                ),
              ),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );

          if (mounted) {
            setState(() => _isProcessing = false);

            await cameraController.start();
          }

          return;
        }

        if ((zz?.succeeded ?? false) &&
            functions
                    .jsonToList(
                        getJsonField((zz?.jsonBody ?? ''), r'''$.data'''))
                    .length
                    .toString() !=
                '0') {
          dynamic structureData = getJsonField(
            (zz?.jsonBody ?? ''),
            r'''$.data[0].structure''',
          );

          if (structureData != null && structureData is List) {
            FFAppState().formresult1 = (structureData
                    .map<FormResultStruct?>(FormResultStruct.maybeFromMap)
                    .toList() as Iterable<FormResultStruct?>)
                .withoutNulls
                .toList()
                .cast<FormResultStruct>();
          } else {
            FFAppState().formresult1 = [];
          }

          setState(() {});

          await context.pushNamed(
            CreateDefectWidget.routeName,
            queryParameters: {
              'equip': serializeParam(
                getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].title''')
                    .toString(),
                ParamType.String,
              ),
              'equipId': serializeParam(
                getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].id'''),
                ParamType.int,
              ),
              'ispravil': serializeParam(false, ParamType.bool),
              'priority': serializeParam(false, ParamType.bool),
              'typeId': serializeParam(
                getJsonField(
                    (qq?.jsonBody ?? ''), r'''$.data[0].type_info.id'''),
                ParamType.int,
              ),
              'formid': serializeParam(
                getJsonField((zz?.jsonBody ?? ''), r'''$.data[0].id'''),
                ParamType.int,
              ),
              'inventory': serializeParam(
                getJsonField(
                        (qq?.jsonBody ?? ''), r'''$.data[0].inventory_number''')
                    .toString(),
                ParamType.String,
              ),
              'area': serializeParam(
                getJsonField((qq?.jsonBody ?? ''),
                            r'''$.data[0].area_info.title''')
                    .toString(),
                ParamType.String,
              ),
            }.withoutNulls,
          );
        } else {
          FFAppState().formresult1 = [];

          setState(() {});

          await context.pushNamed(
            CreateDefectWidget.routeName,
            queryParameters: {
              'equip': serializeParam(
                getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].title''')
                    .toString(),
                ParamType.String,
              ),
              'equipId': serializeParam(
                getJsonField((qq?.jsonBody ?? ''), r'''$.data[0].id'''),
                ParamType.int,
              ),
              'ispravil': serializeParam(false, ParamType.bool),
              'priority': serializeParam(false, ParamType.bool),
              'typeId': serializeParam(
                getJsonField(
                    (qq?.jsonBody ?? ''), r'''$.data[0].type_info.id'''),
                ParamType.int,
              ),
              'inventory': serializeParam(
                getJsonField(
                        (qq?.jsonBody ?? ''), r'''$.data[0].inventory_number''')
                    .toString(),
                ParamType.String,
              ),
              'area': serializeParam(
                getJsonField(
                        (qq?.jsonBody ?? ''), r'''$.data[0].area_info.title''')
                    .toString(),
                ParamType.String,
              ),
            }.withoutNulls,
          );
        }
      }
    } else {
      context.goNamed(DefectsWidget.routeName);
    }

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      await cameraController.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            FFLocalizations.of(context).getVariableText(
              ruText: 'Сканирование оборудования',
              kkText: 'Жабдықты сканерлеу',
            ),
            style: theme.bodyMedium.override(
              fontFamily: 'SFProText',
              fontSize: 16,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w400,
              color: theme.primaryText,
            ),
          ),
          backgroundColor: theme.primaryBackground,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: theme.primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
        ),
      
        backgroundColor: theme.primaryBackground,
      
      // ИСПОЛЬЗУЕМ STACK ДЛЯ ОТОБРАЖЕНИЯ LOADER ПОВЕРХ ВСЕГО
      
        // ... начало файла ...
      
        // ЗАМЕНИТЕ ВЕСЬ body: Stack(...) НА ЭТОТ КОД:
        body: Stack(
          children: [
            // Основной слой
            Column(
              children: [
                // 1. Скроллящаяся область (занимает всё свободное место)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(theme),
                        _buildScannerSection(theme),
                        _buildEquipmentList(theme),
                      ],
                    ),
                  ),
                ),
      
                // 2. ФУТЕР (Зафиксирован внизу)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground, // Фон футера, чтобы контент не просвечивал
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: const Color(0x33000000),
                        offset: const Offset(0, -2),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24), // Отступы (внизу побольше для iOS)
                  child: ElevatedButton(
                    onPressed: () async {
                      // Логика кнопки
                      FFAppState().formresult1 = [];
                      
                      await context.pushNamed(
                        CreateDefectWidget.routeName,
                        queryParameters: {
                          'equip': serializeParam(null, ParamType.String),
                          'equipId': serializeParam(null, ParamType.int),
                          'ispravil': serializeParam(false, ParamType.bool),
                          'priority': serializeParam(false, ParamType.bool),
                          // Добавьте остальные параметры как null или дефолтные, если нужно
                        }.withoutNulls,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      minimumSize: const Size(double.infinity, 50), // Высота кнопки
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      FFLocalizations.of(context).getVariableText(
                        ruText: 'Создать дефект без штрих кода',
                        kkText: 'Штрих-кодсыз ақау жасау',
                      ),
                      style: theme.titleSmall.override(
                        fontFamily: 'SFProText',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      
            // Оверлей загрузки (поверх всего)
            if (_isProcessing)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: theme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          FFLocalizations.of(context).getVariableText(
                            ruText: 'Загрузка...',
                            kkText: 'Жүктелуде...',
                          ),
                          style: theme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

 Widget _buildSearchBar(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        // Добавляем действие клавиатуры "Поиск"
        textInputAction: TextInputAction.search, 
        // Обработка нажатия на кнопку "Поиск" на клавиатуре
        onSubmitted: (value) async {
          if (value.length > 2) {
            // Отменяем активный таймер дебаунса, чтобы не было двойного вызова
            EasyDebounce.cancel('searchDebouncer'); 
            
            setState(() {
              _isApiSearch = true;
              _isSearching = true; // Сразу показываем лоадер
              _displayList = [];
            });
            await _searchApi(value);
          }
        },
        decoration: InputDecoration(
          hintText: FFLocalizations.of(context).getVariableText(
            ruText: 'Поиск оборудования...',
            kkText: 'Жабдықты іздеу...',
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          filled: true,
          fillColor: theme.secondaryBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
// Widget _buildScannerSection(FlutterFlowTheme theme) {
//     // 1. Получаем размеры контейнера камеры
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double cameraViewWidth = screenWidth - 32; 
//     const double cameraViewHeight = 200.0;
    
//     // 2. ЗАДАЕМ РАЗМЕРЫ ОБЛАСТИ СКАНИРОВАНИЯ
//     // Защита: если экран очень узкий, рамка подстроится
//     final double scanBoxWidth = (cameraViewWidth < 300) ? cameraViewWidth - 40 : 300.0;
//     const double scanBoxHeight = 120.0;

//     // Прямоугольник для визуализации (не передаем его в контроллер для Android!)
//     final Rect scanWindowRect = Rect.fromCenter(
//       center: Offset(cameraViewWidth / 2, cameraViewHeight / 2),
//       width: scanBoxWidth,
//       height: scanBoxHeight,
//     );

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Container(
//             height: cameraViewHeight,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.black, // Черный фон лучше смотрится при инициализации
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16.0),
//               child: Stack(
//                 children: [
//                   MobileScanner(
//                     controller: cameraController,
//                     // ВАЖНО: Убрали scanWindow из параметров сканера.
//                     // Это решает проблему смещения координат на Android.
//                     // Сканер видит ВСЮ область (200px высотой), но пользователь целится в рамку.
//                     // scanWindow: scanWindowRect, 
                    
//                     onDetect: (capture) {
//                       // 1. Если уже идет загрузка/обработка — игнорируем новые коды
//                       if (_isProcessing) return;

//                       final List<Barcode> barcodes = capture.barcodes;
                      
//                       if (barcodes.isEmpty) return;

//                       final String? currentBarcode = barcodes.first.rawValue;

//                       if (currentBarcode != null && currentBarcode.isNotEmpty) {
//                         // 2. МГНОВЕННЫЙ ВЫЗОВ (Таймер убран)
//                         _processScannedBarcode(currentBarcode);
//                       }
//                     },
//                   ),

//                   // Затемнение (Overlay)
//                   ColorFiltered(
//                     colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.6), 
//                       BlendMode.srcOut
//                     ),
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: const BoxDecoration(
//                             color: Colors.transparent,
//                             backgroundBlendMode: BlendMode.dstOut,
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Container(
//                             width: scanBoxWidth,
//                             height: scanBoxHeight,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Визуальная рамка
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: scanBoxWidth,
//                       height: scanBoxHeight,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: theme.primary, 
//                           width: 3.0,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Center(
//                         child: Opacity(
//                           opacity: 0.5,
//                           child: Icon(
//                             Icons.linear_scale, 
//                             color: Colors.white, 
//                             size: 40
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
                  
//                   // Доп. индикатор, если камера грузится
//                   if (_isProcessing)
//                      Center(child: CircularProgressIndicator(color: theme.primary)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
// }


  Widget _buildScannerSection(FlutterFlowTheme theme) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cameraViewWidth = screenWidth - 32;
    final double cameraViewHeight = 200.0;
    final double scanBoxWidth =
        (cameraViewWidth < 300) ? cameraViewWidth - 40 : 300.0;
    final double scanBoxHeight = 120.0;

    final Rect scanWindowRect = Rect.fromCenter(
      center: Offset(cameraViewWidth / 2, cameraViewHeight / 2),
      width: scanBoxWidth,
      height: scanBoxHeight,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: cameraViewHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  MobileScanner(
                    fit: BoxFit.cover,
                    controller: cameraController,
                    scanWindow: isAndroid ? null : scanWindowRect,
                    onDetect: (capture) {
                      if (_isProcessing) return;

                      final List<Barcode> barcodes = capture.barcodes;

                      if (barcodes.isEmpty) {
                        _pendingBarcode = null;
                        _firstDetectionTime = null;
                        return;
                      }

                      final String? currentBarcode = barcodes.first.rawValue;
                      if (currentBarcode == null || currentBarcode.isEmpty) {
                        return;
                      }

                      if (isAndroid) {
                        // Android: без scanWindow, мгновенная обработка.
                        _processScannedBarcode(currentBarcode);
                        return;
                      }

                      // iOS: сохраняем старую логику стабилизации считывания.
                      if (_pendingBarcode == currentBarcode &&
                          _firstDetectionTime != null) {
                        final msPassed = DateTime.now()
                            .difference(_firstDetectionTime!)
                            .inMilliseconds;
                        if (msPassed >= 500) {
                          _pendingBarcode = null;
                          _firstDetectionTime = null;
                          _processScannedBarcode(currentBarcode);
                        }
                      } else {
                        _pendingBarcode = currentBarcode;
                        _firstDetectionTime = DateTime.now();
                      }
                    },
                  ),
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcOut),
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            backgroundBlendMode: BlendMode.dstOut,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: scanBoxWidth,
                            height: scanBoxHeight,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: scanBoxWidth,
                      height: scanBoxHeight,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primary,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Center(
                        child: Opacity(
                          opacity: 0.5,
                          child: Icon(Icons.linear_scale,
                              color: Colors.white, size: 40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEquipmentList(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isApiSearch
                ? FFLocalizations.of(context).getVariableText(
                    ruText: 'Результаты поиска',
                    kkText: 'Іздеу нәтижелері',
                  )
                : FFLocalizations.of(context).getVariableText(
                    ruText: 'Часто используемые',
                    kkText: 'Жиі қолданылатындар',
                  ),
            style: theme.headlineSmall.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          // --- НАЧАЛО ИЗМЕНЕНИЙ ---
          if (_isSearching) 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: theme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      FFLocalizations.of(context).getVariableText(
                        ruText: 'Поиск...',
                        kkText: 'Іздеу...',
                      ),
                      style: theme.bodyMedium.override(
                        fontFamily: 'SFProText',
                        color: theme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (_displayList.isEmpty)
          // --- КОНЕЦ ИЗМЕНЕНИЙ (дальше ваш старый код) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: Text(
                  _isApiSearch
                      ? FFLocalizations.of(context).getVariableText(
                          ruText: 'Ничего не найдено',
                          kkText: 'Ештеңе табылмады',
                        )
                      : FFLocalizations.of(context).getVariableText(
                          ruText:
                              'Вы пока не сканировали оборудование.\nОно появится здесь.',
                          kkText:
                              'Сіз әлі жабдықты сканерлемедіңіз.\nОл осында пайда болады.',
                        ),
                  textAlign: TextAlign.center,
                  style: theme.bodyMedium,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _displayList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = _displayList[index];
                return _buildEquipmentListItem(theme, item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildEquipmentListItem(FlutterFlowTheme theme, dynamic item) {
    String title = getJsonField(item, r'''$.title''').toString();

    String inventory = getJsonField(item, r'''$.inventory_number''')?.toString() ?? '';

    String area =
        getJsonField(item, r'''$.area_info.title''')?.toString() ?? '';

    return InkWell(
      onTap: () {
        _onEquipmentSelected(item);
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: theme.alternate, width: 1),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: theme.primary,
            ),
          ),
          title: Text(
            title.isNotEmpty
                ? title
                : FFLocalizations.of(context).getVariableText(
                    ruText: 'Оборудование',
                    kkText: 'Жабдық',
                  ),
            style: theme.titleMedium.override(
              fontFamily: 'SFProText',
              letterSpacing: 0.0,
              color: theme.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 2),
              Text(
                inventory.isNotEmpty
                    ? inventory
                    : '',
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  color: theme.primaryText,
                  letterSpacing: 0.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                area.isNotEmpty
                    ? area
                    : FFLocalizations.of(context).getVariableText(
                        ruText: 'Нет данных об участке',
                        kkText: 'Учаске туралы дерек жоқ',
                      ),
                style: theme.bodyMedium.override(
                  fontFamily: 'SFProText',
                  color: theme.secondaryText,
                  letterSpacing: 0.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
