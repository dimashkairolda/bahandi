// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilesStruct extends BaseStruct {
  FilesStruct({
    String? title,
    String? data,
    String? extension,
    String? url,
    int? id,
    String? createdOn,
    double? size,
  })  : _title = title,
        _data = data,
        _extension = extension,
        _url = url,
        _id = id,
        _createdOn = createdOn,
        _size = size;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "data" field.
  String? _data;
  String get data => _data ?? '';
  set data(String? val) => _data = val;

  bool hasData() => _data != null;

  // "extension" field.
  String? _extension;
  String get extension => _extension ?? '';
  set extension(String? val) => _extension = val;

  bool hasExtension() => _extension != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "created_on" field.
  String? _createdOn;
  String get createdOn => _createdOn ?? '';
  set createdOn(String? val) => _createdOn = val;

  bool hasCreatedOn() => _createdOn != null;

  // "size" field.
  double? _size;
  double get size => _size ?? 0.0;
  set size(double? val) => _size = val;

  void incrementSize(double amount) => size = size + amount;

  bool hasSize() => _size != null;

  static FilesStruct fromMap(Map<String, dynamic> data) => FilesStruct(
        title: data['title'] as String?,
        data: data['data'] as String?,
        extension: data['extension'] as String?,
        url: data['url'] as String?,
        id: castToType<int>(data['id']),
        createdOn: data['created_on'] as String?,
        size: castToType<double>(data['size']),
      );

  static FilesStruct? maybeFromMap(dynamic data) =>
      data is Map ? FilesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'data': _data,
        'extension': _extension,
        'url': _url,
        'id': _id,
        'created_on': _createdOn,
        'size': _size,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'data': serializeParam(
          _data,
          ParamType.String,
        ),
        'extension': serializeParam(
          _extension,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'created_on': serializeParam(
          _createdOn,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.double,
        ),
      }.withoutNulls;

  static FilesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FilesStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        data: deserializeParam(
          data['data'],
          ParamType.String,
          false,
        ),
        extension: deserializeParam(
          data['extension'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        createdOn: deserializeParam(
          data['created_on'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'FilesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FilesStruct &&
        title == other.title &&
        data == other.data &&
        extension == other.extension &&
        url == other.url &&
        id == other.id &&
        createdOn == other.createdOn &&
        size == other.size;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([title, data, extension, url, id, createdOn, size]);
}

FilesStruct createFilesStruct({
  String? title,
  String? data,
  String? extension,
  String? url,
  int? id,
  String? createdOn,
  double? size,
}) =>
    FilesStruct(
      title: title,
      data: data,
      extension: extension,
      url: url,
      id: id,
      createdOn: createdOn,
      size: size,
    );
