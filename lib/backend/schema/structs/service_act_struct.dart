// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ServiceActStruct extends BaseStruct {
  ServiceActStruct({
    String? number,
    int? contractor,
    int? client,
    String? fromTime,
    String? toTime,
    bool? emergencyCall,
    bool? guarantee,
    bool? falseCall,
    bool? technicalService,
    List<int>? requests,
  })  : _number = number,
        _contractor = contractor,
        _client = client,
        _fromTime = fromTime,
        _toTime = toTime,
        _emergencyCall = emergencyCall,
        _guarantee = guarantee,
        _falseCall = falseCall,
        _technicalService = technicalService,
        _requests = requests;

  // "number" field.
  String? _number;
  String get number => _number ?? '';
  set number(String? val) => _number = val;

  bool hasNumber() => _number != null;

  // "contractor" field.
  int? _contractor;
  int get contractor => _contractor ?? 0;
  set contractor(int? val) => _contractor = val;

  void incrementContractor(int amount) => contractor = contractor + amount;

  bool hasContractor() => _contractor != null;

  // "client" field.
  int? _client;
  int get client => _client ?? 0;
  set client(int? val) => _client = val;

  void incrementClient(int amount) => client = client + amount;

  bool hasClient() => _client != null;

  // "from_time" field.
  String? _fromTime;
  String get fromTime => _fromTime ?? '';
  set fromTime(String? val) => _fromTime = val;

  bool hasFromTime() => _fromTime != null;

  // "to_time" field.
  String? _toTime;
  String get toTime => _toTime ?? '';
  set toTime(String? val) => _toTime = val;

  bool hasToTime() => _toTime != null;

  // "emergency_call" field.
  bool? _emergencyCall;
  bool get emergencyCall => _emergencyCall ?? false;
  set emergencyCall(bool? val) => _emergencyCall = val;

  bool hasEmergencyCall() => _emergencyCall != null;

  // "guarantee" field.
  bool? _guarantee;
  bool get guarantee => _guarantee ?? false;
  set guarantee(bool? val) => _guarantee = val;

  bool hasGuarantee() => _guarantee != null;

  // "false_call" field.
  bool? _falseCall;
  bool get falseCall => _falseCall ?? false;
  set falseCall(bool? val) => _falseCall = val;

  bool hasFalseCall() => _falseCall != null;

  // "technical_service" field.
  bool? _technicalService;
  bool get technicalService => _technicalService ?? false;
  set technicalService(bool? val) => _technicalService = val;

  bool hasTechnicalService() => _technicalService != null;

  // "requests" field.
  List<int>? _requests;
  List<int> get requests => _requests ?? const [];
  set requests(List<int>? val) => _requests = val;

  void updateRequests(Function(List<int>) updateFn) {
    updateFn(_requests ??= []);
  }

  bool hasRequests() => _requests != null;

  static ServiceActStruct fromMap(Map<String, dynamic> data) =>
      ServiceActStruct(
        number: data['number'] as String?,
        contractor: castToType<int>(data['contractor']),
        client: castToType<int>(data['client']),
        fromTime: data['from_time'] as String?,
        toTime: data['to_time'] as String?,
        emergencyCall: data['emergency_call'] as bool?,
        guarantee: data['guarantee'] as bool?,
        falseCall: data['false_call'] as bool?,
        technicalService: data['technical_service'] as bool?,
        requests: getDataList(data['requests']),
      );

  static ServiceActStruct? maybeFromMap(dynamic data) => data is Map
      ? ServiceActStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'number': _number,
        'contractor': _contractor,
        'client': _client,
        'from_time': _fromTime,
        'to_time': _toTime,
        'emergency_call': _emergencyCall,
        'guarantee': _guarantee,
        'false_call': _falseCall,
        'technical_service': _technicalService,
        'requests': _requests,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'number': serializeParam(
          _number,
          ParamType.String,
        ),
        'contractor': serializeParam(
          _contractor,
          ParamType.int,
        ),
        'client': serializeParam(
          _client,
          ParamType.int,
        ),
        'from_time': serializeParam(
          _fromTime,
          ParamType.String,
        ),
        'to_time': serializeParam(
          _toTime,
          ParamType.String,
        ),
        'emergency_call': serializeParam(
          _emergencyCall,
          ParamType.bool,
        ),
        'guarantee': serializeParam(
          _guarantee,
          ParamType.bool,
        ),
        'false_call': serializeParam(
          _falseCall,
          ParamType.bool,
        ),
        'technical_service': serializeParam(
          _technicalService,
          ParamType.bool,
        ),
        'requests': serializeParam(
          _requests,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static ServiceActStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServiceActStruct(
        number: deserializeParam(
          data['number'],
          ParamType.String,
          false,
        ),
        contractor: deserializeParam(
          data['contractor'],
          ParamType.int,
          false,
        ),
        client: deserializeParam(
          data['client'],
          ParamType.int,
          false,
        ),
        fromTime: deserializeParam(
          data['from_time'],
          ParamType.String,
          false,
        ),
        toTime: deserializeParam(
          data['to_time'],
          ParamType.String,
          false,
        ),
        emergencyCall: deserializeParam(
          data['emergency_call'],
          ParamType.bool,
          false,
        ),
        guarantee: deserializeParam(
          data['guarantee'],
          ParamType.bool,
          false,
        ),
        falseCall: deserializeParam(
          data['false_call'],
          ParamType.bool,
          false,
        ),
        technicalService: deserializeParam(
          data['technical_service'],
          ParamType.bool,
          false,
        ),
        requests: deserializeParam<int>(
          data['requests'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'ServiceActStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ServiceActStruct &&
        number == other.number &&
        contractor == other.contractor &&
        client == other.client &&
        fromTime == other.fromTime &&
        toTime == other.toTime &&
        emergencyCall == other.emergencyCall &&
        guarantee == other.guarantee &&
        falseCall == other.falseCall &&
        technicalService == other.technicalService &&
        listEquality.equals(requests, other.requests);
  }

  @override
  int get hashCode => const ListEquality().hash([
        number,
        contractor,
        client,
        fromTime,
        toTime,
        emergencyCall,
        guarantee,
        falseCall,
        technicalService,
        requests
      ]);
}

ServiceActStruct createServiceActStruct({
  String? number,
  int? contractor,
  int? client,
  String? fromTime,
  String? toTime,
  bool? emergencyCall,
  bool? guarantee,
  bool? falseCall,
  bool? technicalService,
}) =>
    ServiceActStruct(
      number: number,
      contractor: contractor,
      client: client,
      fromTime: fromTime,
      toTime: toTime,
      emergencyCall: emergencyCall,
      guarantee: guarantee,
      falseCall: falseCall,
      technicalService: technicalService,
    );
