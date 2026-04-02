// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckboxesStruct extends BaseStruct {
  CheckboxesStruct({
    String? text,
    bool? value,
    ResultStruct? result,
  })  : _text = text,
        _value = value,
        _result = result;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "value" field.
  bool? _value;
  bool get value => _value ?? false;
  set value(bool? val) => _value = val;

  bool hasValue() => _value != null;

  // "result" field.
  ResultStruct? _result;
  ResultStruct get result => _result ?? ResultStruct();
  set result(ResultStruct? val) => _result = val;

  void updateResult(Function(ResultStruct) updateFn) {
    updateFn(_result ??= ResultStruct());
  }

  bool hasResult() => _result != null;

  static CheckboxesStruct fromMap(Map<String, dynamic> data) =>
      CheckboxesStruct(
        text: data['text'] as String?,
        value: data['value'] as bool?,
        result: data['result'] is ResultStruct
            ? data['result']
            : ResultStruct.maybeFromMap(data['result']),
      );

  static CheckboxesStruct? maybeFromMap(dynamic data) => data is Map
      ? CheckboxesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
        'value': _value,
        'result': _result?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.bool,
        ),
        'result': serializeParam(
          _result,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static CheckboxesStruct fromSerializableMap(Map<String, dynamic> data) =>
      CheckboxesStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.bool,
          false,
        ),
        result: deserializeStructParam(
          data['result'],
          ParamType.DataStruct,
          false,
          structBuilder: ResultStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CheckboxesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CheckboxesStruct &&
        text == other.text &&
        value == other.value &&
        result == other.result;
  }

  @override
  int get hashCode => const ListEquality().hash([text, value, result]);
}

CheckboxesStruct createCheckboxesStruct({
  String? text,
  bool? value,
  ResultStruct? result,
}) =>
    CheckboxesStruct(
      text: text,
      value: value,
      result: result ?? ResultStruct(),
    );
