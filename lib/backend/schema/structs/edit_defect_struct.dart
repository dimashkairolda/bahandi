// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EditDefectStruct extends BaseStruct {
  EditDefectStruct({
    int? equipment,
    String? title,
    List<FilesStruct>? files,
    List<TmcStruct>? spareParts,
    String? city,
    String? branch,
    bool? corrected,
    bool? priority,
    List<WorksStruct>? works,
    bool? errorMonitoring,
    String? note,
    List<int>? contractors,
    List<int>? performers,
  })  : _equipment = equipment,
        _title = title,
        _files = files,
        _spareParts = spareParts,
        _city = city,
        _branch = branch,
        _corrected = corrected,
        _priority = priority,
        _works = works,
        _errorMonitoring = errorMonitoring,
        _note = note,
        _contractors = contractors,
        _performers = performers;

  // "equipment" field.
  int? _equipment;
  int get equipment => _equipment ?? 0;
  set equipment(int? val) => _equipment = val;

  void incrementEquipment(int amount) => equipment = equipment + amount;

  bool hasEquipment() => _equipment != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "files" field.
  List<FilesStruct>? _files;
  List<FilesStruct> get files => _files ?? const [];
  set files(List<FilesStruct>? val) => _files = val;

  void updateFiles(Function(List<FilesStruct>) updateFn) {
    updateFn(_files ??= []);
  }

  bool hasFiles() => _files != null;

  // "spare_parts" field.
  List<TmcStruct>? _spareParts;
  List<TmcStruct> get spareParts => _spareParts ?? const [];
  set spareParts(List<TmcStruct>? val) => _spareParts = val;

  void updateSpareParts(Function(List<TmcStruct>) updateFn) {
    updateFn(_spareParts ??= []);
  }

  bool hasSpareParts() => _spareParts != null;

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

  // "corrected" field.
  bool? _corrected;
  bool get corrected => _corrected ?? false;
  set corrected(bool? val) => _corrected = val;

  bool hasCorrected() => _corrected != null;

  // "priority" field.
  bool? _priority;
  bool get priority => _priority ?? false;
  set priority(bool? val) => _priority = val;

  bool hasPriority() => _priority != null;

  // "works" field.
  List<WorksStruct>? _works;
  List<WorksStruct> get works => _works ?? const [];
  set works(List<WorksStruct>? val) => _works = val;

  void updateWorks(Function(List<WorksStruct>) updateFn) {
    updateFn(_works ??= []);
  }

  bool hasWorks() => _works != null;

  // "error_monitoring" field.
  bool? _errorMonitoring;
  bool get errorMonitoring => _errorMonitoring ?? false;
  set errorMonitoring(bool? val) => _errorMonitoring = val;

  bool hasErrorMonitoring() => _errorMonitoring != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  // "contractors" field.
  List<int>? _contractors;
  List<int> get contractors => _contractors ?? const [];
  set contractors(List<int>? val) => _contractors = val;

  void updateContractors(Function(List<int>) updateFn) {
    updateFn(_contractors ??= []);
  }

  bool hasContractors() => _contractors != null;

  // "performers" field.
  List<int>? _performers;
  List<int> get performers => _performers ?? const [];
  set performers(List<int>? val) => _performers = val;

  void updatePerformers(Function(List<int>) updateFn) {
    updateFn(_performers ??= []);
  }

  bool hasPerformers() => _performers != null;

  static EditDefectStruct fromMap(Map<String, dynamic> data) =>
      EditDefectStruct(
        equipment: castToType<int>(data['equipment']),
        title: data['title'] as String?,
        files: getStructList(
          data['files'],
          FilesStruct.fromMap,
        ),
        spareParts: getStructList(
          data['spare_parts'],
          TmcStruct.fromMap,
        ),
        city: data['city'] as String?,
        branch: data['branch'] as String?,
        corrected: data['corrected'] as bool?,
        priority: data['priority'] as bool?,
        works: getStructList(
          data['works'],
          WorksStruct.fromMap,
        ),
        errorMonitoring: data['error_monitoring'] as bool?,
        note: data['note'] as String?,
        contractors: getDataList(data['contractors']),
        performers: getDataList(data['performers']),
      );

  static EditDefectStruct? maybeFromMap(dynamic data) => data is Map
      ? EditDefectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'equipment': _equipment,
        'title': _title,
        'files': _files?.map((e) => e.toMap()).toList(),
        'spare_parts': _spareParts?.map((e) => e.toMap()).toList(),
        'city': _city,
        'branch': _branch,
        'corrected': _corrected,
        'priority': _priority,
        'works': _works?.map((e) => e.toMap()).toList(),
        'error_monitoring': _errorMonitoring,
        'note': _note,
        'contractors': _contractors,
        'performers': _performers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'equipment': serializeParam(
          _equipment,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'files': serializeParam(
          _files,
          ParamType.DataStruct,
          isList: true,
        ),
        'spare_parts': serializeParam(
          _spareParts,
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
        'corrected': serializeParam(
          _corrected,
          ParamType.bool,
        ),
        'priority': serializeParam(
          _priority,
          ParamType.bool,
        ),
        'works': serializeParam(
          _works,
          ParamType.DataStruct,
          isList: true,
        ),
        'error_monitoring': serializeParam(
          _errorMonitoring,
          ParamType.bool,
        ),
        'note': serializeParam(
          _note,
          ParamType.String,
        ),
        'contractors': serializeParam(
          _contractors,
          ParamType.int,
          isList: true,
        ),
        'performers': serializeParam(
          _performers,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static EditDefectStruct fromSerializableMap(Map<String, dynamic> data) =>
      EditDefectStruct(
        equipment: deserializeParam(
          data['equipment'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        files: deserializeStructParam<FilesStruct>(
          data['files'],
          ParamType.DataStruct,
          true,
          structBuilder: FilesStruct.fromSerializableMap,
        ),
        spareParts: deserializeStructParam<TmcStruct>(
          data['spare_parts'],
          ParamType.DataStruct,
          true,
          structBuilder: TmcStruct.fromSerializableMap,
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
        corrected: deserializeParam(
          data['corrected'],
          ParamType.bool,
          false,
        ),
        priority: deserializeParam(
          data['priority'],
          ParamType.bool,
          false,
        ),
        works: deserializeStructParam<WorksStruct>(
          data['works'],
          ParamType.DataStruct,
          true,
          structBuilder: WorksStruct.fromSerializableMap,
        ),
        errorMonitoring: deserializeParam(
          data['error_monitoring'],
          ParamType.bool,
          false,
        ),
        note: deserializeParam(
          data['note'],
          ParamType.String,
          false,
        ),
        contractors: deserializeParam<int>(
          data['contractors'],
          ParamType.int,
          true,
        ),
        performers: deserializeParam<int>(
          data['performers'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'EditDefectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EditDefectStruct &&
        equipment == other.equipment &&
        title == other.title &&
        listEquality.equals(files, other.files) &&
        listEquality.equals(spareParts, other.spareParts) &&
        city == other.city &&
        branch == other.branch &&
        corrected == other.corrected &&
        priority == other.priority &&
        listEquality.equals(works, other.works) &&
        errorMonitoring == other.errorMonitoring &&
        note == other.note &&
        listEquality.equals(contractors, other.contractors) &&
        listEquality.equals(performers, other.performers);
  }

  @override
  int get hashCode => const ListEquality().hash([
        equipment,
        title,
        files,
        spareParts,
        city,
        branch,
        corrected,
        priority,
        works,
        errorMonitoring,
        note,
        contractors,
        performers
      ]);
}

EditDefectStruct createEditDefectStruct({
  int? equipment,
  String? title,
  String? city,
  String? branch,
  bool? corrected,
  bool? priority,
  bool? errorMonitoring,
  String? note,
}) =>
    EditDefectStruct(
      equipment: equipment,
      title: title,
      city: city,
      branch: branch,
      corrected: corrected,
      priority: priority,
      errorMonitoring: errorMonitoring,
      note: note,
    );
