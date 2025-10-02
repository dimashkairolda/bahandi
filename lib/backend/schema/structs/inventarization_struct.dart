// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InventarizationStruct extends BaseStruct {
  InventarizationStruct({
    bool? isActive,
    String? title,
    String? inventoryNumber,
    int? author,
    int? equipment,
    int? area,
    String? status,
  })  : _isActive = isActive,
        _title = title,
        _inventoryNumber = inventoryNumber,
        _author = author,
        _equipment = equipment,
        _area = area,
        _status = status;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  set isActive(bool? val) => _isActive = val;

  bool hasIsActive() => _isActive != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "inventory_number" field.
  String? _inventoryNumber;
  String get inventoryNumber => _inventoryNumber ?? '';
  set inventoryNumber(String? val) => _inventoryNumber = val;

  bool hasInventoryNumber() => _inventoryNumber != null;

  // "author" field.
  int? _author;
  int get author => _author ?? 0;
  set author(int? val) => _author = val;

  void incrementAuthor(int amount) => author = author + amount;

  bool hasAuthor() => _author != null;

  // "equipment" field.
  int? _equipment;
  int get equipment => _equipment ?? 0;
  set equipment(int? val) => _equipment = val;

  void incrementEquipment(int amount) => equipment = equipment + amount;

  bool hasEquipment() => _equipment != null;

  // "area" field.
  int? _area;
  int get area => _area ?? 0;
  set area(int? val) => _area = val;

  void incrementArea(int amount) => area = area + amount;

  bool hasArea() => _area != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static InventarizationStruct fromMap(Map<String, dynamic> data) =>
      InventarizationStruct(
        isActive: data['is_active'] as bool?,
        title: data['title'] as String?,
        inventoryNumber: data['inventory_number'] as String?,
        author: castToType<int>(data['author']),
        equipment: castToType<int>(data['equipment']),
        area: castToType<int>(data['area']),
        status: data['status'] as String?,
      );

  static InventarizationStruct? maybeFromMap(dynamic data) => data is Map
      ? InventarizationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'is_active': _isActive,
        'title': _title,
        'inventory_number': _inventoryNumber,
        'author': _author,
        'equipment': _equipment,
        'area': _area,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'is_active': serializeParam(
          _isActive,
          ParamType.bool,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'inventory_number': serializeParam(
          _inventoryNumber,
          ParamType.String,
        ),
        'author': serializeParam(
          _author,
          ParamType.int,
        ),
        'equipment': serializeParam(
          _equipment,
          ParamType.int,
        ),
        'area': serializeParam(
          _area,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static InventarizationStruct fromSerializableMap(Map<String, dynamic> data) =>
      InventarizationStruct(
        isActive: deserializeParam(
          data['is_active'],
          ParamType.bool,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        inventoryNumber: deserializeParam(
          data['inventory_number'],
          ParamType.String,
          false,
        ),
        author: deserializeParam(
          data['author'],
          ParamType.int,
          false,
        ),
        equipment: deserializeParam(
          data['equipment'],
          ParamType.int,
          false,
        ),
        area: deserializeParam(
          data['area'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InventarizationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InventarizationStruct &&
        isActive == other.isActive &&
        title == other.title &&
        inventoryNumber == other.inventoryNumber &&
        author == other.author &&
        equipment == other.equipment &&
        area == other.area &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [isActive, title, inventoryNumber, author, equipment, area, status]);
}

InventarizationStruct createInventarizationStruct({
  bool? isActive,
  String? title,
  String? inventoryNumber,
  int? author,
  int? equipment,
  int? area,
  String? status,
}) =>
    InventarizationStruct(
      isActive: isActive,
      title: title,
      inventoryNumber: inventoryNumber,
      author: author,
      equipment: equipment,
      area: area,
      status: status,
    );
