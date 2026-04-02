// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AreaInfoStruct extends BaseStruct {
  AreaInfoStruct({
    int? id,
    String? title,
    String? address,
    List<int>? responsibles,
    List<ObjectInfoStruct>? objectInfo,
  })  : _id = id,
        _title = title,
        _address = address,
        _responsibles = responsibles,
        _objectInfo = objectInfo;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  // "responsibles" field.
  List<int>? _responsibles;
  List<int> get responsibles => _responsibles ?? const [];
  set responsibles(List<int>? val) => _responsibles = val;

  void updateResponsibles(Function(List<int>) updateFn) {
    updateFn(_responsibles ??= []);
  }

  bool hasResponsibles() => _responsibles != null;

  // "object_info" field.
  List<ObjectInfoStruct>? _objectInfo;
  List<ObjectInfoStruct> get objectInfo => _objectInfo ?? const [];
  set objectInfo(List<ObjectInfoStruct>? val) => _objectInfo = val;

  void updateObjectInfo(Function(List<ObjectInfoStruct>) updateFn) {
    updateFn(_objectInfo ??= []);
  }

  bool hasObjectInfo() => _objectInfo != null;

  static AreaInfoStruct fromMap(Map<String, dynamic> data) => AreaInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        address: data['address'] as String?,
        responsibles: getDataList(data['responsibles']),
        objectInfo: getStructList(
          data['object_info'],
          ObjectInfoStruct.fromMap,
        ),
      );

  static AreaInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? AreaInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'address': _address,
        'responsibles': _responsibles,
        'object_info': _objectInfo?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
        'responsibles': serializeParam(
          _responsibles,
          ParamType.int,
          isList: true,
        ),
        'object_info': serializeParam(
          _objectInfo,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static AreaInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      AreaInfoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
        responsibles: deserializeParam<int>(
          data['responsibles'],
          ParamType.int,
          true,
        ),
        objectInfo: deserializeStructParam<ObjectInfoStruct>(
          data['object_info'],
          ParamType.DataStruct,
          true,
          structBuilder: ObjectInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'AreaInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AreaInfoStruct &&
        id == other.id &&
        title == other.title &&
        address == other.address &&
        listEquality.equals(responsibles, other.responsibles) &&
        listEquality.equals(objectInfo, other.objectInfo);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, title, address, responsibles, objectInfo]);
}

AreaInfoStruct createAreaInfoStruct({
  int? id,
  String? title,
  String? address,
}) =>
    AreaInfoStruct(
      id: id,
      title: title,
      address: address,
    );
