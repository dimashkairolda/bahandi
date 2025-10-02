// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorksStruct extends BaseStruct {
  WorksStruct({
    String? title,
    int? amount,
  })  : _title = title,
        _amount = amount;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  set amount(int? val) => _amount = val;

  void incrementAmount(int amount) => amount = amount + amount;

  bool hasAmount() => _amount != null;

  static WorksStruct fromMap(Map<String, dynamic> data) => WorksStruct(
        title: data['title'] as String?,
        amount: castToType<int>(data['amount']),
      );

  static WorksStruct? maybeFromMap(dynamic data) =>
      data is Map ? WorksStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'amount': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.int,
        ),
      }.withoutNulls;

  static WorksStruct fromSerializableMap(Map<String, dynamic> data) =>
      WorksStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'WorksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorksStruct &&
        title == other.title &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([title, amount]);
}

WorksStruct createWorksStruct({
  String? title,
  int? amount,
}) =>
    WorksStruct(
      title: title,
      amount: amount,
    );
