import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_offline')) {
        try {
          final serializedData = prefs.getString('ff_offline') ?? '{}';
          _offline = OfflineDefectsStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_checkCache')) {
        try {
          _checkCache = jsonDecode(prefs.getString('ff_checkCache') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_Equiptree')) {
        try {
          _Equiptree = jsonDecode(prefs.getString('ff_Equiptree') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _AllEquipments = prefs.getStringList('ff_AllEquipments')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _AllEquipments;
    });
    _safeInit(() {
      _EventTimeTable = prefs
              .getStringList('ff_EventTimeTable')
              ?.map((x) {
                try {
                  return EventStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _EventTimeTable;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_Area')) {
        try {
          _Area = jsonDecode(prefs.getString('ff_Area') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _InspectionsResponses = prefs
              .getStringList('ff_InspectionsResponses')
              ?.map((x) {
                try {
                  return InspectionsArchiveStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _InspectionsResponses;
    });
    _safeInit(() {
      _endedInspections = prefs.getStringList('ff_endedInspections')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _endedInspections;
    });
    _safeInit(() {
      _rememberEmail = prefs.getString('ff_rememberEmail') ?? _rememberEmail;
    });
    _safeInit(() {
      _rememberPassword =
          prefs.getString('ff_rememberPassword') ?? _rememberPassword;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_alldefects')) {
        try {
          _alldefects = jsonDecode(prefs.getString('ff_alldefects') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_users')) {
        try {
          _users = jsonDecode(prefs.getString('ff_users') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_usersofchosendepartments')) {
        try {
          _usersofchosendepartments =
              jsonDecode(prefs.getString('ff_usersofchosendepartments') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_departments')) {
        try {
          _departments = jsonDecode(prefs.getString('ff_departments') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _Technic = prefs.getStringList('ff_Technic') ?? _Technic;
    });
    _safeInit(() {
      _doprasxody = prefs
              .getStringList('ff_doprasxody')
              ?.map((x) {
                try {
                  return DoprasxodyStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _doprasxody;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_tempInspections')) {
        try {
          _tempInspections =
              jsonDecode(prefs.getString('ff_tempInspections') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _fcmtoken = prefs.getString('ff_fcmtoken') ?? _fcmtoken;
    });
    _safeInit(() {
      _rememberAccount = prefs
              .getStringList('ff_rememberAccount')
              ?.map((x) {
                try {
                  return RememberAccountStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _rememberAccount;
    });
    _safeInit(() {
      _newdefects = prefs
              .getStringList('ff_newdefects')
              ?.map((x) {
                try {
                  return DefectsStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _newdefects;
    });
    _safeInit(() {
      _savedfcmtoken = prefs.getString('ff_savedfcmtoken') ?? _savedfcmtoken;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_account')) {
        try {
          _account = jsonDecode(prefs.getString('ff_account') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _secondFcmToken = prefs.getString('ff_secondFcmToken') ?? _secondFcmToken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _accesstoken = '';
  String get accesstoken => _accesstoken;
  set accesstoken(String value) {
    _accesstoken = value;
  }

  bool _online = true;
  bool get online => _online;
  set online(bool value) {
    _online = value;
  }

  OfflineDefectsStruct _offline = OfflineDefectsStruct.fromSerializableMap(
      jsonDecode('{\"spare_parts\":\"[]\"}'));
  OfflineDefectsStruct get offline => _offline;
  set offline(OfflineDefectsStruct value) {
    _offline = value;
    prefs.setString('ff_offline', value.serialize());
  }

  void updateOfflineStruct(Function(OfflineDefectsStruct) updateFn) {
    updateFn(_offline);
    prefs.setString('ff_offline', _offline.serialize());
  }

  int _loopCounterDefects = 0;
  int get loopCounterDefects => _loopCounterDefects;
  set loopCounterDefects(int value) {
    _loopCounterDefects = value;
  }

  int _sendDefectCounter = 0;
  int get sendDefectCounter => _sendDefectCounter;
  set sendDefectCounter(int value) {
    _sendDefectCounter = value;
  }

  int _loopAddingEquipTree = 0;
  int get loopAddingEquipTree => _loopAddingEquipTree;
  set loopAddingEquipTree(int value) {
    _loopAddingEquipTree = value;
  }

  int _loopaddingequips = 0;
  int get loopaddingequips => _loopaddingequips;
  set loopaddingequips(int value) {
    _loopaddingequips = value;
  }

  dynamic _checkCache;
  dynamic get checkCache => _checkCache;
  set checkCache(dynamic value) {
    _checkCache = value;
    prefs.setString('ff_checkCache', jsonEncode(value));
  }

  List<InspectionsStruct> _sendInspections = [];
  List<InspectionsStruct> get sendInspections => _sendInspections;
  set sendInspections(List<InspectionsStruct> value) {
    _sendInspections = value;
  }

  void addToSendInspections(InspectionsStruct value) {
    sendInspections.add(value);
  }

  void removeFromSendInspections(InspectionsStruct value) {
    sendInspections.remove(value);
  }

  void removeAtIndexFromSendInspections(int index) {
    sendInspections.removeAt(index);
  }

  void updateSendInspectionsAtIndex(
    int index,
    InspectionsStruct Function(InspectionsStruct) updateFn,
  ) {
    sendInspections[index] = updateFn(_sendInspections[index]);
  }

  void insertAtIndexInSendInspections(int index, InspectionsStruct value) {
    sendInspections.insert(index, value);
  }

  List<dynamic> _inspectionsRadio = [];
  List<dynamic> get inspectionsRadio => _inspectionsRadio;
  set inspectionsRadio(List<dynamic> value) {
    _inspectionsRadio = value;
  }

  void addToInspectionsRadio(dynamic value) {
    inspectionsRadio.add(value);
  }

  void removeFromInspectionsRadio(dynamic value) {
    inspectionsRadio.remove(value);
  }

  void removeAtIndexFromInspectionsRadio(int index) {
    inspectionsRadio.removeAt(index);
  }

  void updateInspectionsRadioAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    inspectionsRadio[index] = updateFn(_inspectionsRadio[index]);
  }

  void insertAtIndexInInspectionsRadio(int index, dynamic value) {
    inspectionsRadio.insert(index, value);
  }

  dynamic _result;
  dynamic get result => _result;
  set result(dynamic value) {
    _result = value;
  }

  ResultformStruct _result1 =
      ResultformStruct.fromSerializableMap(jsonDecode('{}'));
  ResultformStruct get result1 => _result1;
  set result1(ResultformStruct value) {
    _result1 = value;
  }

  void updateResult1Struct(Function(ResultformStruct) updateFn) {
    updateFn(_result1);
  }

  List<FormResultStruct> _formresult1 = [];
  List<FormResultStruct> get formresult1 => _formresult1;
  set formresult1(List<FormResultStruct> value) {
    _formresult1 = value;
  }

  void addToFormresult1(FormResultStruct value) {
    formresult1.add(value);
  }

  void removeFromFormresult1(FormResultStruct value) {
    formresult1.remove(value);
  }

  void removeAtIndexFromFormresult1(int index) {
    formresult1.removeAt(index);
  }

  void updateFormresult1AtIndex(
    int index,
    FormResultStruct Function(FormResultStruct) updateFn,
  ) {
    formresult1[index] = updateFn(_formresult1[index]);
  }

  void insertAtIndexInFormresult1(int index, FormResultStruct value) {
    formresult1.insert(index, value);
  }

  List<InspectionsStruct> _inspections = [];
  List<InspectionsStruct> get inspections => _inspections;
  set inspections(List<InspectionsStruct> value) {
    _inspections = value;
  }

  void addToInspections(InspectionsStruct value) {
    inspections.add(value);
  }

  void removeFromInspections(InspectionsStruct value) {
    inspections.remove(value);
  }

  void removeAtIndexFromInspections(int index) {
    inspections.removeAt(index);
  }

  void updateInspectionsAtIndex(
    int index,
    InspectionsStruct Function(InspectionsStruct) updateFn,
  ) {
    inspections[index] = updateFn(_inspections[index]);
  }

  void insertAtIndexInInspections(int index, InspectionsStruct value) {
    inspections.insert(index, value);
  }

  int _inspectionsTemp = 0;
  int get inspectionsTemp => _inspectionsTemp;
  set inspectionsTemp(int value) {
    _inspectionsTemp = value;
  }

  int _loopFormResult = 0;
  int get loopFormResult => _loopFormResult;
  set loopFormResult(int value) {
    _loopFormResult = value;
  }

  int _loopInspections = 0;
  int get loopInspections => _loopInspections;
  set loopInspections(int value) {
    _loopInspections = value;
  }

  dynamic _Equiptree;
  dynamic get Equiptree => _Equiptree;
  set Equiptree(dynamic value) {
    _Equiptree = value;
    prefs.setString('ff_Equiptree', jsonEncode(value));
  }

  List<RadiobuttondataStruct> _inspec = [];
  List<RadiobuttondataStruct> get inspec => _inspec;
  set inspec(List<RadiobuttondataStruct> value) {
    _inspec = value;
  }

  void addToInspec(RadiobuttondataStruct value) {
    inspec.add(value);
  }

  void removeFromInspec(RadiobuttondataStruct value) {
    inspec.remove(value);
  }

  void removeAtIndexFromInspec(int index) {
    inspec.removeAt(index);
  }

  void updateInspecAtIndex(
    int index,
    RadiobuttondataStruct Function(RadiobuttondataStruct) updateFn,
  ) {
    inspec[index] = updateFn(_inspec[index]);
  }

  void insertAtIndexInInspec(int index, RadiobuttondataStruct value) {
    inspec.insert(index, value);
  }

  List<dynamic> _AllEquipments = [];
  List<dynamic> get AllEquipments => _AllEquipments;
  set AllEquipments(List<dynamic> value) {
    _AllEquipments = value;
    prefs.setStringList(
        'ff_AllEquipments', value.map((x) => jsonEncode(x)).toList());
  }

  void addToAllEquipments(dynamic value) {
    AllEquipments.add(value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void removeFromAllEquipments(dynamic value) {
    AllEquipments.remove(value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromAllEquipments(int index) {
    AllEquipments.removeAt(index);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void updateAllEquipmentsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    AllEquipments[index] = updateFn(_AllEquipments[index]);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInAllEquipments(int index, dynamic value) {
    AllEquipments.insert(index, value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  int _loopTimeTable = 0;
  int get loopTimeTable => _loopTimeTable;
  set loopTimeTable(int value) {
    _loopTimeTable = value;
  }

  List<EventStruct> _EventTimeTable = [
    EventStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"1\",\"start\":\"1713244957800\",\"end\":\"1713248520000\"}')),
    EventStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"2\",\"start\":\"1713331860000\",\"end\":\"1713418260000\"}'))
  ];
  List<EventStruct> get EventTimeTable => _EventTimeTable;
  set EventTimeTable(List<EventStruct> value) {
    _EventTimeTable = value;
    prefs.setStringList(
        'ff_EventTimeTable', value.map((x) => x.serialize()).toList());
  }

  void addToEventTimeTable(EventStruct value) {
    EventTimeTable.add(value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void removeFromEventTimeTable(EventStruct value) {
    EventTimeTable.remove(value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromEventTimeTable(int index) {
    EventTimeTable.removeAt(index);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void updateEventTimeTableAtIndex(
    int index,
    EventStruct Function(EventStruct) updateFn,
  ) {
    EventTimeTable[index] = updateFn(_EventTimeTable[index]);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInEventTimeTable(int index, EventStruct value) {
    EventTimeTable.insert(index, value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  dynamic _Area;
  dynamic get Area => _Area;
  set Area(dynamic value) {
    _Area = value;
    prefs.setString('ff_Area', jsonEncode(value));
  }

  GetAreaStruct _CreateDefectArea = GetAreaStruct();
  GetAreaStruct get CreateDefectArea => _CreateDefectArea;
  set CreateDefectArea(GetAreaStruct value) {
    _CreateDefectArea = value;
  }

  void updateCreateDefectAreaStruct(Function(GetAreaStruct) updateFn) {
    updateFn(_CreateDefectArea);
  }

  GetAreaStruct _CreateDefectEquip = GetAreaStruct();
  GetAreaStruct get CreateDefectEquip => _CreateDefectEquip;
  set CreateDefectEquip(GetAreaStruct value) {
    _CreateDefectEquip = value;
  }

  void updateCreateDefectEquipStruct(Function(GetAreaStruct) updateFn) {
    updateFn(_CreateDefectEquip);
  }

  List<TmcStruct> _spareparts = [];
  List<TmcStruct> get spareparts => _spareparts;
  set spareparts(List<TmcStruct> value) {
    _spareparts = value;
  }

  void addToSpareparts(TmcStruct value) {
    spareparts.add(value);
  }

  void removeFromSpareparts(TmcStruct value) {
    spareparts.remove(value);
  }

  void removeAtIndexFromSpareparts(int index) {
    spareparts.removeAt(index);
  }

  void updateSparepartsAtIndex(
    int index,
    TmcStruct Function(TmcStruct) updateFn,
  ) {
    spareparts[index] = updateFn(_spareparts[index]);
  }

  void insertAtIndexInSpareparts(int index, TmcStruct value) {
    spareparts.insert(index, value);
  }

  List<InspectionsArchiveStruct> _InspectionsResponses = [];
  List<InspectionsArchiveStruct> get InspectionsResponses =>
      _InspectionsResponses;
  set InspectionsResponses(List<InspectionsArchiveStruct> value) {
    _InspectionsResponses = value;
    prefs.setStringList(
        'ff_InspectionsResponses', value.map((x) => x.serialize()).toList());
  }

  void addToInspectionsResponses(InspectionsArchiveStruct value) {
    InspectionsResponses.add(value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void removeFromInspectionsResponses(InspectionsArchiveStruct value) {
    InspectionsResponses.remove(value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromInspectionsResponses(int index) {
    InspectionsResponses.removeAt(index);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void updateInspectionsResponsesAtIndex(
    int index,
    InspectionsArchiveStruct Function(InspectionsArchiveStruct) updateFn,
  ) {
    InspectionsResponses[index] = updateFn(_InspectionsResponses[index]);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInInspectionsResponses(
      int index, InspectionsArchiveStruct value) {
    InspectionsResponses.insert(index, value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  List<dynamic> _endedInspections = [];
  List<dynamic> get endedInspections => _endedInspections;
  set endedInspections(List<dynamic> value) {
    _endedInspections = value;
    prefs.setStringList(
        'ff_endedInspections', value.map((x) => jsonEncode(x)).toList());
  }

  void addToEndedInspections(dynamic value) {
    endedInspections.add(value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void removeFromEndedInspections(dynamic value) {
    endedInspections.remove(value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromEndedInspections(int index) {
    endedInspections.removeAt(index);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void updateEndedInspectionsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    endedInspections[index] = updateFn(_endedInspections[index]);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInEndedInspections(int index, dynamic value) {
    endedInspections.insert(index, value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  int _loadingTimeTable = 0;
  int get loadingTimeTable => _loadingTimeTable;
  set loadingTimeTable(int value) {
    _loadingTimeTable = value;
  }

  int _loadingDefects = 0;
  int get loadingDefects => _loadingDefects;
  set loadingDefects(int value) {
    _loadingDefects = value;
  }

  int _loadingInspections = 0;
  int get loadingInspections => _loadingInspections;
  set loadingInspections(int value) {
    _loadingInspections = value;
  }

  int _loadingEquips = 0;
  int get loadingEquips => _loadingEquips;
  set loadingEquips(int value) {
    _loadingEquips = value;
  }

  int _loadingEquipTree = 0;
  int get loadingEquipTree => _loadingEquipTree;
  set loadingEquipTree(int value) {
    _loadingEquipTree = value;
  }

  String _rememberEmail = '';
  String get rememberEmail => _rememberEmail;
  set rememberEmail(String value) {
    _rememberEmail = value;
    prefs.setString('ff_rememberEmail', value);
  }

  String _rememberPassword = '';
  String get rememberPassword => _rememberPassword;
  set rememberPassword(String value) {
    _rememberPassword = value;
    prefs.setString('ff_rememberPassword', value);
  }

  DateTime? _selectedDay = DateTime.fromMillisecondsSinceEpoch(1721386740000);
  DateTime? get selectedDay => _selectedDay;
  set selectedDay(DateTime? value) {
    _selectedDay = value;
  }

  dynamic _alldefects;
  dynamic get alldefects => _alldefects;
  set alldefects(dynamic value) {
    _alldefects = value;
    prefs.setString('ff_alldefects', jsonEncode(value));
  }

  dynamic _users;
  dynamic get users => _users;
  set users(dynamic value) {
    _users = value;
    prefs.setString('ff_users', jsonEncode(value));
  }

  dynamic _usersofchosendepartments;
  dynamic get usersofchosendepartments => _usersofchosendepartments;
  set usersofchosendepartments(dynamic value) {
    _usersofchosendepartments = value;
    prefs.setString('ff_usersofchosendepartments', jsonEncode(value));
  }

  dynamic _departments;
  dynamic get departments => _departments;
  set departments(dynamic value) {
    _departments = value;
    prefs.setString('ff_departments', jsonEncode(value));
  }

  List<ConfirmdefectStruct> _confirmedDefects = [];
  List<ConfirmdefectStruct> get confirmedDefects => _confirmedDefects;
  set confirmedDefects(List<ConfirmdefectStruct> value) {
    _confirmedDefects = value;
  }

  void addToConfirmedDefects(ConfirmdefectStruct value) {
    confirmedDefects.add(value);
  }

  void removeFromConfirmedDefects(ConfirmdefectStruct value) {
    confirmedDefects.remove(value);
  }

  void removeAtIndexFromConfirmedDefects(int index) {
    confirmedDefects.removeAt(index);
  }

  void updateConfirmedDefectsAtIndex(
    int index,
    ConfirmdefectStruct Function(ConfirmdefectStruct) updateFn,
  ) {
    confirmedDefects[index] = updateFn(_confirmedDefects[index]);
  }

  void insertAtIndexInConfirmedDefects(int index, ConfirmdefectStruct value) {
    confirmedDefects.insert(index, value);
  }

  List<ConfirmdefectStruct> _rejectedDefects = [];
  List<ConfirmdefectStruct> get rejectedDefects => _rejectedDefects;
  set rejectedDefects(List<ConfirmdefectStruct> value) {
    _rejectedDefects = value;
  }

  void addToRejectedDefects(ConfirmdefectStruct value) {
    rejectedDefects.add(value);
  }

  void removeFromRejectedDefects(ConfirmdefectStruct value) {
    rejectedDefects.remove(value);
  }

  void removeAtIndexFromRejectedDefects(int index) {
    rejectedDefects.removeAt(index);
  }

  void updateRejectedDefectsAtIndex(
    int index,
    ConfirmdefectStruct Function(ConfirmdefectStruct) updateFn,
  ) {
    rejectedDefects[index] = updateFn(_rejectedDefects[index]);
  }

  void insertAtIndexInRejectedDefects(int index, ConfirmdefectStruct value) {
    rejectedDefects.insert(index, value);
  }

  int _loopConfirm = 0;
  int get loopConfirm => _loopConfirm;
  set loopConfirm(int value) {
    _loopConfirm = value;
  }

  int _loopReject = 0;
  int get loopReject => _loopReject;
  set loopReject(int value) {
    _loopReject = value;
  }

  List<String> _Technic = [
    'Toyota Camry, 077YES02',
    'Toyota Camry, 521ALL02',
    'BMW 540, 749AUG02'
  ];
  List<String> get Technic => _Technic;
  set Technic(List<String> value) {
    _Technic = value;
    prefs.setStringList('ff_Technic', value);
  }

  void addToTechnic(String value) {
    Technic.add(value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void removeFromTechnic(String value) {
    Technic.remove(value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void removeAtIndexFromTechnic(int index) {
    Technic.removeAt(index);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void updateTechnicAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    Technic[index] = updateFn(_Technic[index]);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void insertAtIndexInTechnic(int index, String value) {
    Technic.insert(index, value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  List<DoprasxodyStruct> _doprasxody = [];
  List<DoprasxodyStruct> get doprasxody => _doprasxody;
  set doprasxody(List<DoprasxodyStruct> value) {
    _doprasxody = value;
    prefs.setStringList(
        'ff_doprasxody', value.map((x) => x.serialize()).toList());
  }

  void addToDoprasxody(DoprasxodyStruct value) {
    doprasxody.add(value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void removeFromDoprasxody(DoprasxodyStruct value) {
    doprasxody.remove(value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDoprasxody(int index) {
    doprasxody.removeAt(index);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void updateDoprasxodyAtIndex(
    int index,
    DoprasxodyStruct Function(DoprasxodyStruct) updateFn,
  ) {
    doprasxody[index] = updateFn(_doprasxody[index]);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDoprasxody(int index, DoprasxodyStruct value) {
    doprasxody.insert(index, value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  List<String> _fotki = [];
  List<String> get fotki => _fotki;
  set fotki(List<String> value) {
    _fotki = value;
  }

  void addToFotki(String value) {
    fotki.add(value);
  }

  void removeFromFotki(String value) {
    fotki.remove(value);
  }

  void removeAtIndexFromFotki(int index) {
    fotki.removeAt(index);
  }

  void updateFotkiAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    fotki[index] = updateFn(_fotki[index]);
  }

  void insertAtIndexInFotki(int index, String value) {
    fotki.insert(index, value);
  }

  String _scannedNFCTag = '';
  String get scannedNFCTag => _scannedNFCTag;
  set scannedNFCTag(String value) {
    _scannedNFCTag = value;
  }

  List<ConfirmdefectStruct> _fixedDefects = [];
  List<ConfirmdefectStruct> get fixedDefects => _fixedDefects;
  set fixedDefects(List<ConfirmdefectStruct> value) {
    _fixedDefects = value;
  }

  void addToFixedDefects(ConfirmdefectStruct value) {
    fixedDefects.add(value);
  }

  void removeFromFixedDefects(ConfirmdefectStruct value) {
    fixedDefects.remove(value);
  }

  void removeAtIndexFromFixedDefects(int index) {
    fixedDefects.removeAt(index);
  }

  void updateFixedDefectsAtIndex(
    int index,
    ConfirmdefectStruct Function(ConfirmdefectStruct) updateFn,
  ) {
    fixedDefects[index] = updateFn(_fixedDefects[index]);
  }

  void insertAtIndexInFixedDefects(int index, ConfirmdefectStruct value) {
    fixedDefects.insert(index, value);
  }

  int _loopFixed = 0;
  int get loopFixed => _loopFixed;
  set loopFixed(int value) {
    _loopFixed = value;
  }

  String _nfcData = '';
  String get nfcData => _nfcData;
  set nfcData(String value) {
    _nfcData = value;
  }

  int _chosenEquip = 0;
  int get chosenEquip => _chosenEquip;
  set chosenEquip(int value) {
    _chosenEquip = value;
  }

  DateTime? _startedon = DateTime.fromMillisecondsSinceEpoch(1704088800000);
  DateTime? get startedon => _startedon;
  set startedon(DateTime? value) {
    _startedon = value;
  }

  dynamic _tempInspections;
  dynamic get tempInspections => _tempInspections;
  set tempInspections(dynamic value) {
    _tempInspections = value;
    prefs.setString('ff_tempInspections', jsonEncode(value));
  }

  List<dynamic> _photos = [];
  List<dynamic> get photos => _photos;
  set photos(List<dynamic> value) {
    _photos = value;
  }

  void addToPhotos(dynamic value) {
    photos.add(value);
  }

  void removeFromPhotos(dynamic value) {
    photos.remove(value);
  }

  void removeAtIndexFromPhotos(int index) {
    photos.removeAt(index);
  }

  void updatePhotosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    photos[index] = updateFn(_photos[index]);
  }

  void insertAtIndexInPhotos(int index, dynamic value) {
    photos.insert(index, value);
  }

  String _fcmtoken = '';
  String get fcmtoken => _fcmtoken;
  set fcmtoken(String value) {
    _fcmtoken = value;
    prefs.setString('ff_fcmtoken', value);
  }

  List<RememberAccountStruct> _rememberAccount = [];
  List<RememberAccountStruct> get rememberAccount => _rememberAccount;
  set rememberAccount(List<RememberAccountStruct> value) {
    _rememberAccount = value;
    prefs.setStringList(
        'ff_rememberAccount', value.map((x) => x.serialize()).toList());
  }

  void addToRememberAccount(RememberAccountStruct value) {
    rememberAccount.add(value);
    prefs.setStringList('ff_rememberAccount',
        _rememberAccount.map((x) => x.serialize()).toList());
  }

  void removeFromRememberAccount(RememberAccountStruct value) {
    rememberAccount.remove(value);
    prefs.setStringList('ff_rememberAccount',
        _rememberAccount.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromRememberAccount(int index) {
    rememberAccount.removeAt(index);
    prefs.setStringList('ff_rememberAccount',
        _rememberAccount.map((x) => x.serialize()).toList());
  }

  void updateRememberAccountAtIndex(
    int index,
    RememberAccountStruct Function(RememberAccountStruct) updateFn,
  ) {
    rememberAccount[index] = updateFn(_rememberAccount[index]);
    prefs.setStringList('ff_rememberAccount',
        _rememberAccount.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInRememberAccount(int index, RememberAccountStruct value) {
    rememberAccount.insert(index, value);
    prefs.setStringList('ff_rememberAccount',
        _rememberAccount.map((x) => x.serialize()).toList());
  }

  List<DefectsStruct> _newdefects = [];
  List<DefectsStruct> get newdefects => _newdefects;
  set newdefects(List<DefectsStruct> value) {
    _newdefects = value;
    prefs.setStringList(
        'ff_newdefects', value.map((x) => x.serialize()).toList());
  }

  void addToNewdefects(DefectsStruct value) {
    newdefects.add(value);
    prefs.setStringList(
        'ff_newdefects', _newdefects.map((x) => x.serialize()).toList());
  }

  void removeFromNewdefects(DefectsStruct value) {
    newdefects.remove(value);
    prefs.setStringList(
        'ff_newdefects', _newdefects.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromNewdefects(int index) {
    newdefects.removeAt(index);
    prefs.setStringList(
        'ff_newdefects', _newdefects.map((x) => x.serialize()).toList());
  }

  void updateNewdefectsAtIndex(
    int index,
    DefectsStruct Function(DefectsStruct) updateFn,
  ) {
    newdefects[index] = updateFn(_newdefects[index]);
    prefs.setStringList(
        'ff_newdefects', _newdefects.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInNewdefects(int index, DefectsStruct value) {
    newdefects.insert(index, value);
    prefs.setStringList(
        'ff_newdefects', _newdefects.map((x) => x.serialize()).toList());
  }

  String _savedfcmtoken = '';
  String get savedfcmtoken => _savedfcmtoken;
  set savedfcmtoken(String value) {
    _savedfcmtoken = value;
    prefs.setString('ff_savedfcmtoken', value);
  }

  dynamic _account;
  dynamic get account => _account;
  set account(dynamic value) {
    _account = value;
    prefs.setString('ff_account', jsonEncode(value));
  }

  RequestStruct _request = RequestStruct();
  RequestStruct get request => _request;
  set request(RequestStruct value) {
    _request = value;
  }

  void updateRequestStruct(Function(RequestStruct) updateFn) {
    updateFn(_request);
  }

  List<WorksStruct> _works = [];
  List<WorksStruct> get works => _works;
  set works(List<WorksStruct> value) {
    _works = value;
  }

  void addToWorks(WorksStruct value) {
    works.add(value);
  }

  void removeFromWorks(WorksStruct value) {
    works.remove(value);
  }

  void removeAtIndexFromWorks(int index) {
    works.removeAt(index);
  }

  void updateWorksAtIndex(
    int index,
    WorksStruct Function(WorksStruct) updateFn,
  ) {
    works[index] = updateFn(_works[index]);
  }

  void insertAtIndexInWorks(int index, WorksStruct value) {
    works.insert(index, value);
  }

  bool _isEdited = false;
  bool get isEdited => _isEdited;
  set isEdited(bool value) {
    _isEdited = value;
  }

  List<RequestStruct> _requests = [];
  List<RequestStruct> get requests => _requests;
  set requests(List<RequestStruct> value) {
    _requests = value;
  }

  void addToRequests(RequestStruct value) {
    requests.add(value);
  }

  void removeFromRequests(RequestStruct value) {
    requests.remove(value);
  }

  void removeAtIndexFromRequests(int index) {
    requests.removeAt(index);
  }

  void updateRequestsAtIndex(
    int index,
    RequestStruct Function(RequestStruct) updateFn,
  ) {
    requests[index] = updateFn(_requests[index]);
  }

  void insertAtIndexInRequests(int index, RequestStruct value) {
    requests.insert(index, value);
  }

  List<LatlonStruct> _latlon = [];
  List<LatlonStruct> get latlon => _latlon;
  set latlon(List<LatlonStruct> value) {
    _latlon = value;
  }

  void addToLatlon(LatlonStruct value) {
    latlon.add(value);
  }

  void removeFromLatlon(LatlonStruct value) {
    latlon.remove(value);
  }

  void removeAtIndexFromLatlon(int index) {
    latlon.removeAt(index);
  }

  void updateLatlonAtIndex(
    int index,
    LatlonStruct Function(LatlonStruct) updateFn,
  ) {
    latlon[index] = updateFn(_latlon[index]);
  }

  void insertAtIndexInLatlon(int index, LatlonStruct value) {
    latlon.insert(index, value);
  }

  String _secondFcmToken = '';
  String get secondFcmToken => _secondFcmToken;
  set secondFcmToken(String value) {
    _secondFcmToken = value;
    prefs.setString('ff_secondFcmToken', value);
  }

  String _typeId = '';
  String get typeId => _typeId;
  set typeId(String value) {
    _typeId = value;
  }

  String _manufacturerId = '';
  String get manufacturerId => _manufacturerId;
  set manufacturerId(String value) {
    _manufacturerId = value;
  }

  InventarizationStruct _aa = InventarizationStruct();
  InventarizationStruct get aa => _aa;
  set aa(InventarizationStruct value) {
    _aa = value;
  }

  void updateAaStruct(Function(InventarizationStruct) updateFn) {
    updateFn(_aa);
  }

  final _defectManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> defect({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _defectManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearDefectCache() => _defectManager.clear();
  void clearDefectCacheKey(String? uniqueKey) =>
      _defectManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
