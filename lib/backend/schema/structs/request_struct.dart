// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RequestStruct extends BaseStruct {
  RequestStruct({
    String? title,
    int? equipment,
    List<FilesStruct>? files,
    String? branch,
    String? city,
    List<int>? contractors,
    String? status,
    List<int>? performers,
    String? comment,
    String? date,
    bool? errorMonitoring,
    List<LatlonStruct>? latLon,
  })  : _title = title,
        _equipment = equipment,
        _files = files,
        _branch = branch,
        _city = city,
        _contractors = contractors,
        _status = status,
        _performers = performers,
        _comment = comment,
        _date = date,
        _errorMonitoring = errorMonitoring,
        _latLon = latLon;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "equipment" field.
  int? _equipment;
  int get equipment => _equipment ?? 0;
  set equipment(int? val) => _equipment = val;

  void incrementEquipment(int amount) => equipment = equipment + amount;

  bool hasEquipment() => _equipment != null;

  // "files" field.
  List<FilesStruct>? _files;
  List<FilesStruct> get files => _files ?? const [];
  set files(List<FilesStruct>? val) => _files = val;

  void updateFiles(Function(List<FilesStruct>) updateFn) {
    updateFn(_files ??= []);
  }

  bool hasFiles() => _files != null;

  // "branch" field.
  String? _branch;
  String get branch => _branch ?? '';
  set branch(String? val) => _branch = val;

  bool hasBranch() => _branch != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "contractors" field.
  List<int>? _contractors;
  List<int> get contractors => _contractors ?? const [];
  set contractors(List<int>? val) => _contractors = val;

  void updateContractors(Function(List<int>) updateFn) {
    updateFn(_contractors ??= []);
  }

  bool hasContractors() => _contractors != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "performers" field.
  List<int>? _performers;
  List<int> get performers => _performers ?? const [];
  set performers(List<int>? val) => _performers = val;

  void updatePerformers(Function(List<int>) updateFn) {
    updateFn(_performers ??= []);
  }

  bool hasPerformers() => _performers != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "error_monitoring" field.
  bool? _errorMonitoring;
  bool get errorMonitoring => _errorMonitoring ?? false;
  set errorMonitoring(bool? val) => _errorMonitoring = val;

  bool hasErrorMonitoring() => _errorMonitoring != null;

  // "lat_lon" field.
  List<LatlonStruct>? _latLon;
  List<LatlonStruct> get latLon => _latLon ?? const [];
  set latLon(List<LatlonStruct>? val) => _latLon = val;

  void updateLatLon(Function(List<LatlonStruct>) updateFn) {
    updateFn(_latLon ??= []);
  }

  bool hasLatLon() => _latLon != null;

  static RequestStruct fromMap(Map<String, dynamic> data) => RequestStruct(
        title: data['title'] as String?,
        equipment: castToType<int>(data['equipment']),
        files: getStructList(
          data['files'],
          FilesStruct.fromMap,
        ),
        branch: data['branch'] as String?,
        city: data['city'] as String?,
        contractors: getDataList(data['contractors']),
        status: data['status'] as String?,
        performers: getDataList(data['performers']),
        comment: data['comment'] as String?,
        date: data['date'] as String?,
        errorMonitoring: data['error_monitoring'] as bool?,
        latLon: getStructList(
          data['lat_lon'],
          LatlonStruct.fromMap,
        ),
      );

  static RequestStruct? maybeFromMap(dynamic data) =>
      data is Map ? RequestStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'equipment': _equipment,
        'files': _files?.map((e) => e.toMap()).toList(),
        'branch': _branch,
        'city': _city,
        'contractors': _contractors,
        'status': _status,
        'performers': _performers,
        'comment': _comment,
        'date': _date,
        'error_monitoring': _errorMonitoring,
        'lat_lon': _latLon?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'equipment': serializeParam(
          _equipment,
          ParamType.int,
        ),
        'files': serializeParam(
          _files,
          ParamType.DataStruct,
          isList: true,
        ),
        'branch': serializeParam(
          _branch,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'contractors': serializeParam(
          _contractors,
          ParamType.int,
          isList: true,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'performers': serializeParam(
          _performers,
          ParamType.int,
          isList: true,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'error_monitoring': serializeParam(
          _errorMonitoring,
          ParamType.bool,
        ),
        'lat_lon': serializeParam(
          _latLon,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static RequestStruct fromSerializableMap(Map<String, dynamic> data) =>
      RequestStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        equipment: deserializeParam(
          data['equipment'],
          ParamType.int,
          false,
        ),
        files: deserializeStructParam<FilesStruct>(
          data['files'],
          ParamType.DataStruct,
          true,
          structBuilder: FilesStruct.fromSerializableMap,
        ),
        branch: deserializeParam(
          data['branch'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        contractors: deserializeParam<int>(
          data['contractors'],
          ParamType.int,
          true,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        performers: deserializeParam<int>(
          data['performers'],
          ParamType.int,
          true,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        errorMonitoring: deserializeParam(
          data['error_monitoring'],
          ParamType.bool,
          false,
        ),
        latLon: deserializeStructParam<LatlonStruct>(
          data['lat_lon'],
          ParamType.DataStruct,
          true,
          structBuilder: LatlonStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RequestStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is RequestStruct &&
        title == other.title &&
        equipment == other.equipment &&
        listEquality.equals(files, other.files) &&
        branch == other.branch &&
        city == other.city &&
        listEquality.equals(contractors, other.contractors) &&
        status == other.status &&
        listEquality.equals(performers, other.performers) &&
        comment == other.comment &&
        date == other.date &&
        errorMonitoring == other.errorMonitoring &&
        listEquality.equals(latLon, other.latLon);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        equipment,
        files,
        branch,
        city,
        contractors,
        status,
        performers,
        comment,
        date,
        errorMonitoring,
        latLon
      ]);
}

RequestStruct createRequestStruct({
  String? title,
  int? equipment,
  String? branch,
  String? city,
  String? status,
  String? comment,
  String? date,
  bool? errorMonitoring,
}) =>
    RequestStruct(
      title: title,
      equipment: equipment,
      branch: branch,
      city: city,
      status: status,
      comment: comment,
      date: date,
      errorMonitoring: errorMonitoring,
    );
