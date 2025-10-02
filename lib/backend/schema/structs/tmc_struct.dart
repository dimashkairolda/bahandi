// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TmcStruct extends BaseStruct {
  TmcStruct({
    String? title,
    int? amount,
    String? model,
  })  : _title = title,
        _amount = amount,
        _model = model;

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

  // "model" field.
  String? _model;
  String get model => _model ?? '';
  set model(String? val) => _model = val;

  bool hasModel() => _model != null;

  static TmcStruct fromMap(Map<String, dynamic> data) => TmcStruct(
        title: data['title'] as String?,
        amount: castToType<int>(data['amount']),
        model: data['model'] as String?,
      );

  static TmcStruct? maybeFromMap(dynamic data) =>
      data is Map ? TmcStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'amount': _amount,
        'model': _model,
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
        'model': serializeParam(
          _model,
          ParamType.String,
        ),
      }.withoutNulls;

  static TmcStruct fromSerializableMap(Map<String, dynamic> data) => TmcStruct(
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
        model: deserializeParam(
          data['model'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TmcStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TmcStruct &&
        title == other.title &&
        amount == other.amount &&
        model == other.model;
  }

  @override
  int get hashCode => const ListEquality().hash([title, amount, model]);
}

TmcStruct createTmcStruct({
  String? title,
  int? amount,
  String? model,
}) =>
    TmcStruct(
      title: title,
      amount: amount,
      model: model,
    );
