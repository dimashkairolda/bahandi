// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateDefectStruct extends BaseStruct {
  CreateDefectStruct({
    String? type,
    String? event,
    String? title,
    String? reason,
    bool? isFixedOnPlace,
    bool? isEmergencySituation,
    String? spareparts,
    int? department,
    int? responsible,
  })  : _type = type,
        _event = event,
        _title = title,
        _reason = reason,
        _isFixedOnPlace = isFixedOnPlace,
        _isEmergencySituation = isEmergencySituation,
        _spareparts = spareparts,
        _department = department,
        _responsible = responsible;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "event" field.
  String? _event;
  String get event => _event ?? '';
  set event(String? val) => _event = val;

  bool hasEvent() => _event != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  set reason(String? val) => _reason = val;

  bool hasReason() => _reason != null;

  // "isFixedOnPlace" field.
  bool? _isFixedOnPlace;
  bool get isFixedOnPlace => _isFixedOnPlace ?? false;
  set isFixedOnPlace(bool? val) => _isFixedOnPlace = val;

  bool hasIsFixedOnPlace() => _isFixedOnPlace != null;

  // "isEmergencySituation" field.
  bool? _isEmergencySituation;
  bool get isEmergencySituation => _isEmergencySituation ?? false;
  set isEmergencySituation(bool? val) => _isEmergencySituation = val;

  bool hasIsEmergencySituation() => _isEmergencySituation != null;

  // "spareparts" field.
  String? _spareparts;
  String get spareparts => _spareparts ?? '';
  set spareparts(String? val) => _spareparts = val;

  bool hasSpareparts() => _spareparts != null;

  // "department" field.
  int? _department;
  int get department => _department ?? 0;
  set department(int? val) => _department = val;

  void incrementDepartment(int amount) => department = department + amount;

  bool hasDepartment() => _department != null;

  // "responsible" field.
  int? _responsible;
  int get responsible => _responsible ?? 0;
  set responsible(int? val) => _responsible = val;

  void incrementResponsible(int amount) => responsible = responsible + amount;

  bool hasResponsible() => _responsible != null;

  static CreateDefectStruct fromMap(Map<String, dynamic> data) =>
      CreateDefectStruct(
        type: data['type'] as String?,
        event: data['event'] as String?,
        title: data['title'] as String?,
        reason: data['reason'] as String?,
        isFixedOnPlace: data['isFixedOnPlace'] as bool?,
        isEmergencySituation: data['isEmergencySituation'] as bool?,
        spareparts: data['spareparts'] as String?,
        department: castToType<int>(data['department']),
        responsible: castToType<int>(data['responsible']),
      );

  static CreateDefectStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateDefectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'event': _event,
        'title': _title,
        'reason': _reason,
        'isFixedOnPlace': _isFixedOnPlace,
        'isEmergencySituation': _isEmergencySituation,
        'spareparts': _spareparts,
        'department': _department,
        'responsible': _responsible,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'event': serializeParam(
          _event,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
        'isFixedOnPlace': serializeParam(
          _isFixedOnPlace,
          ParamType.bool,
        ),
        'isEmergencySituation': serializeParam(
          _isEmergencySituation,
          ParamType.bool,
        ),
        'spareparts': serializeParam(
          _spareparts,
          ParamType.String,
        ),
        'department': serializeParam(
          _department,
          ParamType.int,
        ),
        'responsible': serializeParam(
          _responsible,
          ParamType.int,
        ),
      }.withoutNulls;

  static CreateDefectStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreateDefectStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        event: deserializeParam(
          data['event'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        reason: deserializeParam(
          data['reason'],
          ParamType.String,
          false,
        ),
        isFixedOnPlace: deserializeParam(
          data['isFixedOnPlace'],
          ParamType.bool,
          false,
        ),
        isEmergencySituation: deserializeParam(
          data['isEmergencySituation'],
          ParamType.bool,
          false,
        ),
        spareparts: deserializeParam(
          data['spareparts'],
          ParamType.String,
          false,
        ),
        department: deserializeParam(
          data['department'],
          ParamType.int,
          false,
        ),
        responsible: deserializeParam(
          data['responsible'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'CreateDefectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CreateDefectStruct &&
        type == other.type &&
        event == other.event &&
        title == other.title &&
        reason == other.reason &&
        isFixedOnPlace == other.isFixedOnPlace &&
        isEmergencySituation == other.isEmergencySituation &&
        spareparts == other.spareparts &&
        department == other.department &&
        responsible == other.responsible;
  }

  @override
  int get hashCode => const ListEquality().hash([
        type,
        event,
        title,
        reason,
        isFixedOnPlace,
        isEmergencySituation,
        spareparts,
        department,
        responsible
      ]);
}

CreateDefectStruct createCreateDefectStruct({
  String? type,
  String? event,
  String? title,
  String? reason,
  bool? isFixedOnPlace,
  bool? isEmergencySituation,
  String? spareparts,
  int? department,
  int? responsible,
}) =>
    CreateDefectStruct(
      type: type,
      event: event,
      title: title,
      reason: reason,
      isFixedOnPlace: isFixedOnPlace,
      isEmergencySituation: isEmergencySituation,
      spareparts: spareparts,
      department: department,
      responsible: responsible,
    );
