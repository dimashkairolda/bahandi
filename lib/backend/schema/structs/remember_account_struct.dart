// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RememberAccountStruct extends BaseStruct {
  RememberAccountStruct({
    String? name,
    String? password,
  })  : _name = name,
        _password = password;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  set password(String? val) => _password = val;

  bool hasPassword() => _password != null;

  static RememberAccountStruct fromMap(Map<String, dynamic> data) =>
      RememberAccountStruct(
        name: data['name'] as String?,
        password: data['password'] as String?,
      );

  static RememberAccountStruct? maybeFromMap(dynamic data) => data is Map
      ? RememberAccountStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'password': _password,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'password': serializeParam(
          _password,
          ParamType.String,
        ),
      }.withoutNulls;

  static RememberAccountStruct fromSerializableMap(Map<String, dynamic> data) =>
      RememberAccountStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        password: deserializeParam(
          data['password'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RememberAccountStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RememberAccountStruct &&
        name == other.name &&
        password == other.password;
  }

  @override
  int get hashCode => const ListEquality().hash([name, password]);
}

RememberAccountStruct createRememberAccountStruct({
  String? name,
  String? password,
}) =>
    RememberAccountStruct(
      name: name,
      password: password,
    );
