// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DescriptionsStruct extends BaseStruct {
  DescriptionsStruct({
    String? text,
  }) : _text = text;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  static DescriptionsStruct fromMap(Map<String, dynamic> data) =>
      DescriptionsStruct(
        text: data['text'] as String?,
      );

  static DescriptionsStruct? maybeFromMap(dynamic data) => data is Map
      ? DescriptionsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
      }.withoutNulls;

  static DescriptionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DescriptionsStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DescriptionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DescriptionsStruct && text == other.text;
  }

  @override
  int get hashCode => const ListEquality().hash([text]);
}

DescriptionsStruct createDescriptionsStruct({
  String? text,
}) =>
    DescriptionsStruct(
      text: text,
    );
