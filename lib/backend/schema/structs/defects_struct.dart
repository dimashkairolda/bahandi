// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DefectsStruct extends BaseStruct {
  DefectsStruct({
    String? createdDate,
    String? createdTime,
    int? equipment,
    String? type,
    int? department,
    int? responsible,
    String? title,
    String? reason,
    String? event,
    String? plannedFixDate,
    String? riskOfFailureInDependentEquipment,
    bool? isFixedOnPlace,
    bool? isEmergencySituation,
    String? fixedBy,
    String? fixedOn,
    List<TmcStruct>? spareParts,
    List<FilesStruct>? files,
    String? city,
    String? branch,
  })  : _createdDate = createdDate,
        _createdTime = createdTime,
        _equipment = equipment,
        _type = type,
        _department = department,
        _responsible = responsible,
        _title = title,
        _reason = reason,
        _event = event,
        _plannedFixDate = plannedFixDate,
        _riskOfFailureInDependentEquipment = riskOfFailureInDependentEquipment,
        _isFixedOnPlace = isFixedOnPlace,
        _isEmergencySituation = isEmergencySituation,
        _fixedBy = fixedBy,
        _fixedOn = fixedOn,
        _spareParts = spareParts,
        _files = files,
        _city = city,
        _branch = branch;

  // "created_date" field.
  String? _createdDate;
  String get createdDate => _createdDate ?? '';
  set createdDate(String? val) => _createdDate = val;

  bool hasCreatedDate() => _createdDate != null;

  // "created_time" field.
  String? _createdTime;
  String get createdTime => _createdTime ?? '';
  set createdTime(String? val) => _createdTime = val;

  bool hasCreatedTime() => _createdTime != null;

  // "equipment" field.
  int? _equipment;
  int get equipment => _equipment ?? 0;
  set equipment(int? val) => _equipment = val;

  void incrementEquipment(int amount) => equipment = equipment + amount;

  bool hasEquipment() => _equipment != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

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

  // "event" field.
  String? _event;
  String get event => _event ?? '';
  set event(String? val) => _event = val;

  bool hasEvent() => _event != null;

  // "planned_fix_date" field.
  String? _plannedFixDate;
  String get plannedFixDate => _plannedFixDate ?? '';
  set plannedFixDate(String? val) => _plannedFixDate = val;

  bool hasPlannedFixDate() => _plannedFixDate != null;

  // "risk_of_failure_in_dependent_equipment" field.
  String? _riskOfFailureInDependentEquipment;
  String get riskOfFailureInDependentEquipment =>
      _riskOfFailureInDependentEquipment ?? '';
  set riskOfFailureInDependentEquipment(String? val) =>
      _riskOfFailureInDependentEquipment = val;

  bool hasRiskOfFailureInDependentEquipment() =>
      _riskOfFailureInDependentEquipment != null;

  // "is_fixed_on_place" field.
  bool? _isFixedOnPlace;
  bool get isFixedOnPlace => _isFixedOnPlace ?? false;
  set isFixedOnPlace(bool? val) => _isFixedOnPlace = val;

  bool hasIsFixedOnPlace() => _isFixedOnPlace != null;

  // "is_emergency_situation" field.
  bool? _isEmergencySituation;
  bool get isEmergencySituation => _isEmergencySituation ?? false;
  set isEmergencySituation(bool? val) => _isEmergencySituation = val;

  bool hasIsEmergencySituation() => _isEmergencySituation != null;

  // "fixed_by" field.
  String? _fixedBy;
  String get fixedBy => _fixedBy ?? '';
  set fixedBy(String? val) => _fixedBy = val;

  bool hasFixedBy() => _fixedBy != null;

  // "fixed_on" field.
  String? _fixedOn;
  String get fixedOn => _fixedOn ?? '';
  set fixedOn(String? val) => _fixedOn = val;

  bool hasFixedOn() => _fixedOn != null;

  // "spare_parts" field.
  List<TmcStruct>? _spareParts;
  List<TmcStruct> get spareParts => _spareParts ?? const [];
  set spareParts(List<TmcStruct>? val) => _spareParts = val;

  void updateSpareParts(Function(List<TmcStruct>) updateFn) {
    updateFn(_spareParts ??= []);
  }

  bool hasSpareParts() => _spareParts != null;

  // "files" field.
  List<FilesStruct>? _files;
  List<FilesStruct> get files => _files ?? const [];
  set files(List<FilesStruct>? val) => _files = val;

  void updateFiles(Function(List<FilesStruct>) updateFn) {
    updateFn(_files ??= []);
  }

  bool hasFiles() => _files != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "branch" field.
  String? _branch;
  String get branch => _branch ?? '';
  set branch(String? val) => _branch = val;

  bool hasBranch() => _branch != null;

  static DefectsStruct fromMap(Map<String, dynamic> data) => DefectsStruct(
        createdDate: data['created_date'] as String?,
        createdTime: data['created_time'] as String?,
        equipment: castToType<int>(data['equipment']),
        type: data['type'] as String?,
        department: castToType<int>(data['department']),
        responsible: castToType<int>(data['responsible']),
        title: data['title'] as String?,
        reason: data['reason'] as String?,
        event: data['event'] as String?,
        plannedFixDate: data['planned_fix_date'] as String?,
        riskOfFailureInDependentEquipment:
            data['risk_of_failure_in_dependent_equipment'] as String?,
        isFixedOnPlace: data['is_fixed_on_place'] as bool?,
        isEmergencySituation: data['is_emergency_situation'] as bool?,
        fixedBy: data['fixed_by'] as String?,
        fixedOn: data['fixed_on'] as String?,
        spareParts: getStructList(
          data['spare_parts'],
          TmcStruct.fromMap,
        ),
        files: getStructList(
          data['files'],
          FilesStruct.fromMap,
        ),
        city: data['city'] as String?,
        branch: data['branch'] as String?,
      );

  static DefectsStruct? maybeFromMap(dynamic data) =>
      data is Map ? DefectsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'created_date': _createdDate,
        'created_time': _createdTime,
        'equipment': _equipment,
        'type': _type,
        'department': _department,
        'responsible': _responsible,
        'title': _title,
        'reason': _reason,
        'event': _event,
        'planned_fix_date': _plannedFixDate,
        'risk_of_failure_in_dependent_equipment':
            _riskOfFailureInDependentEquipment,
        'is_fixed_on_place': _isFixedOnPlace,
        'is_emergency_situation': _isEmergencySituation,
        'fixed_by': _fixedBy,
        'fixed_on': _fixedOn,
        'spare_parts': _spareParts?.map((e) => e.toMap()).toList(),
        'files': _files?.map((e) => e.toMap()).toList(),
        'city': _city,
        'branch': _branch,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'created_date': serializeParam(
          _createdDate,
          ParamType.String,
        ),
        'created_time': serializeParam(
          _createdTime,
          ParamType.String,
        ),
        'equipment': serializeParam(
          _equipment,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
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
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
        'event': serializeParam(
          _event,
          ParamType.String,
        ),
        'planned_fix_date': serializeParam(
          _plannedFixDate,
          ParamType.String,
        ),
        'risk_of_failure_in_dependent_equipment': serializeParam(
          _riskOfFailureInDependentEquipment,
          ParamType.String,
        ),
        'is_fixed_on_place': serializeParam(
          _isFixedOnPlace,
          ParamType.bool,
        ),
        'is_emergency_situation': serializeParam(
          _isEmergencySituation,
          ParamType.bool,
        ),
        'fixed_by': serializeParam(
          _fixedBy,
          ParamType.String,
        ),
        'fixed_on': serializeParam(
          _fixedOn,
          ParamType.String,
        ),
        'spare_parts': serializeParam(
          _spareParts,
          ParamType.DataStruct,
          isList: true,
        ),
        'files': serializeParam(
          _files,
          ParamType.DataStruct,
          isList: true,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'branch': serializeParam(
          _branch,
          ParamType.String,
        ),
      }.withoutNulls;

  static DefectsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DefectsStruct(
        createdDate: deserializeParam(
          data['created_date'],
          ParamType.String,
          false,
        ),
        createdTime: deserializeParam(
          data['created_time'],
          ParamType.String,
          false,
        ),
        equipment: deserializeParam(
          data['equipment'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
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
        event: deserializeParam(
          data['event'],
          ParamType.String,
          false,
        ),
        plannedFixDate: deserializeParam(
          data['planned_fix_date'],
          ParamType.String,
          false,
        ),
        riskOfFailureInDependentEquipment: deserializeParam(
          data['risk_of_failure_in_dependent_equipment'],
          ParamType.String,
          false,
        ),
        isFixedOnPlace: deserializeParam(
          data['is_fixed_on_place'],
          ParamType.bool,
          false,
        ),
        isEmergencySituation: deserializeParam(
          data['is_emergency_situation'],
          ParamType.bool,
          false,
        ),
        fixedBy: deserializeParam(
          data['fixed_by'],
          ParamType.String,
          false,
        ),
        fixedOn: deserializeParam(
          data['fixed_on'],
          ParamType.String,
          false,
        ),
        spareParts: deserializeStructParam<TmcStruct>(
          data['spare_parts'],
          ParamType.DataStruct,
          true,
          structBuilder: TmcStruct.fromSerializableMap,
        ),
        files: deserializeStructParam<FilesStruct>(
          data['files'],
          ParamType.DataStruct,
          true,
          structBuilder: FilesStruct.fromSerializableMap,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        branch: deserializeParam(
          data['branch'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DefectsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DefectsStruct &&
        createdDate == other.createdDate &&
        createdTime == other.createdTime &&
        equipment == other.equipment &&
        type == other.type &&
        department == other.department &&
        responsible == other.responsible &&
        title == other.title &&
        reason == other.reason &&
        event == other.event &&
        plannedFixDate == other.plannedFixDate &&
        riskOfFailureInDependentEquipment ==
            other.riskOfFailureInDependentEquipment &&
        isFixedOnPlace == other.isFixedOnPlace &&
        isEmergencySituation == other.isEmergencySituation &&
        fixedBy == other.fixedBy &&
        fixedOn == other.fixedOn &&
        listEquality.equals(spareParts, other.spareParts) &&
        listEquality.equals(files, other.files) &&
        city == other.city &&
        branch == other.branch;
  }

  @override
  int get hashCode => const ListEquality().hash([
        createdDate,
        createdTime,
        equipment,
        type,
        department,
        responsible,
        title,
        reason,
        event,
        plannedFixDate,
        riskOfFailureInDependentEquipment,
        isFixedOnPlace,
        isEmergencySituation,
        fixedBy,
        fixedOn,
        spareParts,
        files,
        city,
        branch
      ]);
}

DefectsStruct createDefectsStruct({
  String? createdDate,
  String? createdTime,
  int? equipment,
  String? type,
  int? department,
  int? responsible,
  String? title,
  String? reason,
  String? event,
  String? plannedFixDate,
  String? riskOfFailureInDependentEquipment,
  bool? isFixedOnPlace,
  bool? isEmergencySituation,
  String? fixedBy,
  String? fixedOn,
  String? city,
  String? branch,
}) =>
    DefectsStruct(
      createdDate: createdDate,
      createdTime: createdTime,
      equipment: equipment,
      type: type,
      department: department,
      responsible: responsible,
      title: title,
      reason: reason,
      event: event,
      plannedFixDate: plannedFixDate,
      riskOfFailureInDependentEquipment: riskOfFailureInDependentEquipment,
      isFixedOnPlace: isFixedOnPlace,
      isEmergencySituation: isEmergencySituation,
      fixedBy: fixedBy,
      fixedOn: fixedOn,
      city: city,
      branch: branch,
    );
