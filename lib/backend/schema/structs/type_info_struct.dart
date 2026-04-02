// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TypeInfoStruct extends BaseStruct {
  TypeInfoStruct({
    int? id,
    String? title,
    List<String>? technicalParameters,
    List<String>? operationalParameters,
  })  : _id = id,
        _title = title,
        _technicalParameters = technicalParameters,
        _operationalParameters = operationalParameters;

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

  // "technical_parameters" field.
  List<String>? _technicalParameters;
  List<String> get technicalParameters => _technicalParameters ?? const [];
  set technicalParameters(List<String>? val) => _technicalParameters = val;

  void updateTechnicalParameters(Function(List<String>) updateFn) {
    updateFn(_technicalParameters ??= []);
  }

  bool hasTechnicalParameters() => _technicalParameters != null;

  // "operational_parameters" field.
  List<String>? _operationalParameters;
  List<String> get operationalParameters => _operationalParameters ?? const [];
  set operationalParameters(List<String>? val) => _operationalParameters = val;

  void updateOperationalParameters(Function(List<String>) updateFn) {
    updateFn(_operationalParameters ??= []);
  }

  bool hasOperationalParameters() => _operationalParameters != null;

  static TypeInfoStruct fromMap(Map<String, dynamic> data) => TypeInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        technicalParameters: getDataList(data['technical_parameters']),
        operationalParameters: getDataList(data['operational_parameters']),
      );

  static TypeInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? TypeInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'technical_parameters': _technicalParameters,
        'operational_parameters': _operationalParameters,
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
        'technical_parameters': serializeParam(
          _technicalParameters,
          ParamType.String,
          isList: true,
        ),
        'operational_parameters': serializeParam(
          _operationalParameters,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static TypeInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      TypeInfoStruct(
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
        technicalParameters: deserializeParam<String>(
          data['technical_parameters'],
          ParamType.String,
          true,
        ),
        operationalParameters: deserializeParam<String>(
          data['operational_parameters'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'TypeInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is TypeInfoStruct &&
        id == other.id &&
        title == other.title &&
        listEquality.equals(technicalParameters, other.technicalParameters) &&
        listEquality.equals(operationalParameters, other.operationalParameters);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, title, technicalParameters, operationalParameters]);
}

TypeInfoStruct createTypeInfoStruct({
  int? id,
  String? title,
}) =>
    TypeInfoStruct(
      id: id,
      title: title,
    );
