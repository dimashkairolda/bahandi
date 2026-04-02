// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ObjectInfoStruct extends BaseStruct {
  ObjectInfoStruct({
    int? id,
    String? title,
    String? address,
  })  : _id = id,
        _title = title,
        _address = address;

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

  static ObjectInfoStruct fromMap(Map<String, dynamic> data) =>
      ObjectInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        address: data['address'] as String?,
      );

  static ObjectInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? ObjectInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'address': _address,
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
      }.withoutNulls;

  static ObjectInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ObjectInfoStruct(
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
      );

  @override
  String toString() => 'ObjectInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ObjectInfoStruct &&
        id == other.id &&
        title == other.title &&
        address == other.address;
  }

  @override
  int get hashCode => const ListEquality().hash([id, title, address]);
}

ObjectInfoStruct createObjectInfoStruct({
  int? id,
  String? title,
  String? address,
}) =>
    ObjectInfoStruct(
      id: id,
      title: title,
      address: address,
    );
