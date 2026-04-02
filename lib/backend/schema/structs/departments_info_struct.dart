// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DepartmentsInfoStruct extends BaseStruct {
  DepartmentsInfoStruct({
    int? id,
    String? title,
    String? fullTitle,
  })  : _id = id,
        _title = title,
        _fullTitle = fullTitle;

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

  // "full_title" field.
  String? _fullTitle;
  String get fullTitle => _fullTitle ?? '';
  set fullTitle(String? val) => _fullTitle = val;

  bool hasFullTitle() => _fullTitle != null;

  static DepartmentsInfoStruct fromMap(Map<String, dynamic> data) =>
      DepartmentsInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        fullTitle: data['full_title'] as String?,
      );

  static DepartmentsInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? DepartmentsInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'full_title': _fullTitle,
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
        'full_title': serializeParam(
          _fullTitle,
          ParamType.String,
        ),
      }.withoutNulls;

  static DepartmentsInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      DepartmentsInfoStruct(
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
        fullTitle: deserializeParam(
          data['full_title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DepartmentsInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DepartmentsInfoStruct &&
        id == other.id &&
        title == other.title &&
        fullTitle == other.fullTitle;
  }

  @override
  int get hashCode => const ListEquality().hash([id, title, fullTitle]);
}

DepartmentsInfoStruct createDepartmentsInfoStruct({
  int? id,
  String? title,
  String? fullTitle,
}) =>
    DepartmentsInfoStruct(
      id: id,
      title: title,
      fullTitle: fullTitle,
    );
