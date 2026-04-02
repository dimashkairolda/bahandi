// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RadiosStruct extends BaseStruct {
  RadiosStruct({
    String? text,
    String? value,
  })  : _text = text,
        _value = value;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  static RadiosStruct fromMap(Map<String, dynamic> data) => RadiosStruct(
        text: data['text'] as String?,
        value: data['value'] as String?,
      );

  static RadiosStruct? maybeFromMap(dynamic data) =>
      data is Map ? RadiosStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static RadiosStruct fromSerializableMap(Map<String, dynamic> data) =>
      RadiosStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RadiosStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RadiosStruct && text == other.text && value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([text, value]);
}

RadiosStruct createRadiosStruct({
  String? text,
  String? value,
}) =>
    RadiosStruct(
      text: text,
      value: value,
    );
