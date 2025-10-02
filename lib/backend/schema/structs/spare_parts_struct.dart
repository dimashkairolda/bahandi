// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SparePartsStruct extends BaseStruct {
  SparePartsStruct({
    String? title,
    String? partNumber,
    String? amount,
  })  : _title = title,
        _partNumber = partNumber,
        _amount = amount;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "part_number" field.
  String? _partNumber;
  String get partNumber => _partNumber ?? '';
  set partNumber(String? val) => _partNumber = val;

  bool hasPartNumber() => _partNumber != null;

  // "amount" field.
  String? _amount;
  String get amount => _amount ?? '';
  set amount(String? val) => _amount = val;

  bool hasAmount() => _amount != null;

  static SparePartsStruct fromMap(Map<String, dynamic> data) =>
      SparePartsStruct(
        title: data['title'] as String?,
        partNumber: data['part_number'] as String?,
        amount: data['amount'] as String?,
      );

  static SparePartsStruct? maybeFromMap(dynamic data) => data is Map
      ? SparePartsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'part_number': _partNumber,
        'amount': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'part_number': serializeParam(
          _partNumber,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.String,
        ),
      }.withoutNulls;

  static SparePartsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SparePartsStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        partNumber: deserializeParam(
          data['part_number'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SparePartsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SparePartsStruct &&
        title == other.title &&
        partNumber == other.partNumber &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([title, partNumber, amount]);
}

SparePartsStruct createSparePartsStruct({
  String? title,
  String? partNumber,
  String? amount,
}) =>
    SparePartsStruct(
      title: title,
      partNumber: partNumber,
      amount: amount,
    );
