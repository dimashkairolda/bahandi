// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResultStruct extends BaseStruct {
  ResultStruct({
    bool? response,
    String? comment,
    String? image,
  })  : _response = response,
        _comment = comment,
        _image = image;

  // "response" field.
  bool? _response;
  bool get response => _response ?? false;
  set response(bool? val) => _response = val;

  bool hasResponse() => _response != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  static ResultStruct fromMap(Map<String, dynamic> data) => ResultStruct(
        response: data['response'] as bool?,
        comment: data['comment'] as String?,
        image: data['image'] as String?,
      );

  static ResultStruct? maybeFromMap(dynamic data) =>
      data is Map ? ResultStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'response': _response,
        'comment': _comment,
        'image': _image,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'response': serializeParam(
          _response,
          ParamType.bool,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
      }.withoutNulls;

  static ResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResultStruct(
        response: deserializeParam(
          data['response'],
          ParamType.bool,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ResultStruct &&
        response == other.response &&
        comment == other.comment &&
        image == other.image;
  }

  @override
  int get hashCode => const ListEquality().hash([response, comment, image]);
}

ResultStruct createResultStruct({
  bool? response,
  String? comment,
  String? image,
}) =>
    ResultStruct(
      response: response,
      comment: comment,
      image: image,
    );
