// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateEquipmentStruct extends BaseStruct {
  CreateEquipmentStruct({
    String? title,
    int? type,
    int? manufacturer,
    int? model,
    List<int>? departments,
    String? factoryNumber,
    String? inventoryNumber,
    String? dispatchNumber,
    String? operatingTime,
    String? operationalDate,
    String? barcode,
    String? numberScheme,
    bool? hasMonitoring,
  })  : _title = title,
        _type = type,
        _manufacturer = manufacturer,
        _model = model,
        _departments = departments,
        _factoryNumber = factoryNumber,
        _inventoryNumber = inventoryNumber,
        _dispatchNumber = dispatchNumber,
        _operatingTime = operatingTime,
        _operationalDate = operationalDate,
        _barcode = barcode,
        _numberScheme = numberScheme,
        _hasMonitoring = hasMonitoring;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "type" field.
  int? _type;
  int get type => _type ?? 0;
  set type(int? val) => _type = val;

  void incrementType(int amount) => type = type + amount;

  bool hasType() => _type != null;

  // "manufacturer" field.
  int? _manufacturer;
  int get manufacturer => _manufacturer ?? 0;
  set manufacturer(int? val) => _manufacturer = val;

  void incrementManufacturer(int amount) =>
      manufacturer = manufacturer + amount;

  bool hasManufacturer() => _manufacturer != null;

  // "model" field.
  int? _model;
  int get model => _model ?? 0;
  set model(int? val) => _model = val;

  void incrementModel(int amount) => model = model + amount;

  bool hasModel() => _model != null;

  // "departments" field.
  List<int>? _departments;
  List<int> get departments => _departments ?? const [];
  set departments(List<int>? val) => _departments = val;

  void updateDepartments(Function(List<int>) updateFn) {
    updateFn(_departments ??= []);
  }

  bool hasDepartments() => _departments != null;

  // "factory_number" field.
  String? _factoryNumber;
  String get factoryNumber => _factoryNumber ?? '';
  set factoryNumber(String? val) => _factoryNumber = val;

  bool hasFactoryNumber() => _factoryNumber != null;

  // "inventory_number" field.
  String? _inventoryNumber;
  String get inventoryNumber => _inventoryNumber ?? '';
  set inventoryNumber(String? val) => _inventoryNumber = val;

  bool hasInventoryNumber() => _inventoryNumber != null;

  // "dispatch_number" field.
  String? _dispatchNumber;
  String get dispatchNumber => _dispatchNumber ?? '';
  set dispatchNumber(String? val) => _dispatchNumber = val;

  bool hasDispatchNumber() => _dispatchNumber != null;

  // "operating_time" field.
  String? _operatingTime;
  String get operatingTime => _operatingTime ?? '';
  set operatingTime(String? val) => _operatingTime = val;

  bool hasOperatingTime() => _operatingTime != null;

  // "operational_date" field.
  String? _operationalDate;
  String get operationalDate => _operationalDate ?? '';
  set operationalDate(String? val) => _operationalDate = val;

  bool hasOperationalDate() => _operationalDate != null;

  // "barcode" field.
  String? _barcode;
  String get barcode => _barcode ?? '';
  set barcode(String? val) => _barcode = val;

  bool hasBarcode() => _barcode != null;

  // "number_scheme" field.
  String? _numberScheme;
  String get numberScheme => _numberScheme ?? '';
  set numberScheme(String? val) => _numberScheme = val;

  bool hasNumberScheme() => _numberScheme != null;

  // "has_monitoring" field.
  bool? _hasMonitoring;
  bool get hasMonitoring => _hasMonitoring ?? false;
  set hasMonitoring(bool? val) => _hasMonitoring = val;

  bool hasHasMonitoring() => _hasMonitoring != null;

  static CreateEquipmentStruct fromMap(Map<String, dynamic> data) =>
      CreateEquipmentStruct(
        title: data['title'] as String?,
        type: castToType<int>(data['type']),
        manufacturer: castToType<int>(data['manufacturer']),
        model: castToType<int>(data['model']),
        departments: getDataList(data['departments']),
        factoryNumber: data['factory_number'] as String?,
        inventoryNumber: data['inventory_number'] as String?,
        dispatchNumber: data['dispatch_number'] as String?,
        operatingTime: data['operating_time'] as String?,
        operationalDate: data['operational_date'] as String?,
        barcode: data['barcode'] as String?,
        numberScheme: data['number_scheme'] as String?,
        hasMonitoring: data['has_monitoring'] as bool?,
      );

  static CreateEquipmentStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateEquipmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'type': _type,
        'manufacturer': _manufacturer,
        'model': _model,
        'departments': _departments,
        'factory_number': _factoryNumber,
        'inventory_number': _inventoryNumber,
        'dispatch_number': _dispatchNumber,
        'operating_time': _operatingTime,
        'operational_date': _operationalDate,
        'barcode': _barcode,
        'number_scheme': _numberScheme,
        'has_monitoring': _hasMonitoring,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.int,
        ),
        'manufacturer': serializeParam(
          _manufacturer,
          ParamType.int,
        ),
        'model': serializeParam(
          _model,
          ParamType.int,
        ),
        'departments': serializeParam(
          _departments,
          ParamType.int,
          isList: true,
        ),
        'factory_number': serializeParam(
          _factoryNumber,
          ParamType.String,
        ),
        'inventory_number': serializeParam(
          _inventoryNumber,
          ParamType.String,
        ),
        'dispatch_number': serializeParam(
          _dispatchNumber,
          ParamType.String,
        ),
        'operating_time': serializeParam(
          _operatingTime,
          ParamType.String,
        ),
        'operational_date': serializeParam(
          _operationalDate,
          ParamType.String,
        ),
        'barcode': serializeParam(
          _barcode,
          ParamType.String,
        ),
        'number_scheme': serializeParam(
          _numberScheme,
          ParamType.String,
        ),
        'has_monitoring': serializeParam(
          _hasMonitoring,
          ParamType.bool,
        ),
      }.withoutNulls;

  static CreateEquipmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreateEquipmentStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.int,
          false,
        ),
        manufacturer: deserializeParam(
          data['manufacturer'],
          ParamType.int,
          false,
        ),
        model: deserializeParam(
          data['model'],
          ParamType.int,
          false,
        ),
        departments: deserializeParam<int>(
          data['departments'],
          ParamType.int,
          true,
        ),
        factoryNumber: deserializeParam(
          data['factory_number'],
          ParamType.String,
          false,
        ),
        inventoryNumber: deserializeParam(
          data['inventory_number'],
          ParamType.String,
          false,
        ),
        dispatchNumber: deserializeParam(
          data['dispatch_number'],
          ParamType.String,
          false,
        ),
        operatingTime: deserializeParam(
          data['operating_time'],
          ParamType.String,
          false,
        ),
        operationalDate: deserializeParam(
          data['operational_date'],
          ParamType.String,
          false,
        ),
        barcode: deserializeParam(
          data['barcode'],
          ParamType.String,
          false,
        ),
        numberScheme: deserializeParam(
          data['number_scheme'],
          ParamType.String,
          false,
        ),
        hasMonitoring: deserializeParam(
          data['has_monitoring'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'CreateEquipmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CreateEquipmentStruct &&
        title == other.title &&
        type == other.type &&
        manufacturer == other.manufacturer &&
        model == other.model &&
        listEquality.equals(departments, other.departments) &&
        factoryNumber == other.factoryNumber &&
        inventoryNumber == other.inventoryNumber &&
        dispatchNumber == other.dispatchNumber &&
        operatingTime == other.operatingTime &&
        operationalDate == other.operationalDate &&
        barcode == other.barcode &&
        numberScheme == other.numberScheme &&
        hasMonitoring == other.hasMonitoring;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        type,
        manufacturer,
        model,
        departments,
        factoryNumber,
        inventoryNumber,
        dispatchNumber,
        operatingTime,
        operationalDate,
        barcode,
        numberScheme,
        hasMonitoring
      ]);
}

CreateEquipmentStruct createCreateEquipmentStruct({
  String? title,
  int? type,
  int? manufacturer,
  int? model,
  String? factoryNumber,
  String? inventoryNumber,
  String? dispatchNumber,
  String? operatingTime,
  String? operationalDate,
  String? barcode,
  String? numberScheme,
  bool? hasMonitoring,
}) =>
    CreateEquipmentStruct(
      title: title,
      type: type,
      manufacturer: manufacturer,
      model: model,
      factoryNumber: factoryNumber,
      inventoryNumber: inventoryNumber,
      dispatchNumber: dispatchNumber,
      operatingTime: operatingTime,
      operationalDate: operationalDate,
      barcode: barcode,
      numberScheme: numberScheme,
      hasMonitoring: hasMonitoring,
    );
