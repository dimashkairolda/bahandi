// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ModelInfoStruct extends BaseStruct {
  ModelInfoStruct({
    int? id,
    String? title,
  })  : _id = id,
        _title = title;

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

  static ModelInfoStruct fromMap(Map<String, dynamic> data) => ModelInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
      );

  static ModelInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? ModelInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
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
      }.withoutNulls;

  static ModelInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      ModelInfoStruct(
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
      );

  @override
  String toString() => 'ModelInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ModelInfoStruct && id == other.id && title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([id, title]);
}

ModelInfoStruct createModelInfoStruct({
  int? id,
  String? title,
}) =>
    ModelInfoStruct(
      id: id,
      title: title,
    );
