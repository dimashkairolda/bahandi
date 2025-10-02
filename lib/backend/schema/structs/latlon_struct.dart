// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LatlonStruct extends BaseStruct {
  LatlonStruct({
    double? lat,
    double? lon,
    String? title,
    String? datetime,
  })  : _lat = lat,
        _lon = lon,
        _title = title,
        _datetime = datetime;

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  set lat(double? val) => _lat = val;

  void incrementLat(double amount) => lat = lat + amount;

  bool hasLat() => _lat != null;

  // "lon" field.
  double? _lon;
  double get lon => _lon ?? 0.0;
  set lon(double? val) => _lon = val;

  void incrementLon(double amount) => lon = lon + amount;

  bool hasLon() => _lon != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "datetime" field.
  String? _datetime;
  String get datetime => _datetime ?? '';
  set datetime(String? val) => _datetime = val;

  bool hasDatetime() => _datetime != null;

  static LatlonStruct fromMap(Map<String, dynamic> data) => LatlonStruct(
        lat: castToType<double>(data['lat']),
        lon: castToType<double>(data['lon']),
        title: data['title'] as String?,
        datetime: data['datetime'] as String?,
      );

  static LatlonStruct? maybeFromMap(dynamic data) =>
      data is Map ? LatlonStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'lat': _lat,
        'lon': _lon,
        'title': _title,
        'datetime': _datetime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'lat': serializeParam(
          _lat,
          ParamType.double,
        ),
        'lon': serializeParam(
          _lon,
          ParamType.double,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'datetime': serializeParam(
          _datetime,
          ParamType.String,
        ),
      }.withoutNulls;

  static LatlonStruct fromSerializableMap(Map<String, dynamic> data) =>
      LatlonStruct(
        lat: deserializeParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        lon: deserializeParam(
          data['lon'],
          ParamType.double,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        datetime: deserializeParam(
          data['datetime'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LatlonStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LatlonStruct &&
        lat == other.lat &&
        lon == other.lon &&
        title == other.title &&
        datetime == other.datetime;
  }

  @override
  int get hashCode => const ListEquality().hash([lat, lon, title, datetime]);
}

LatlonStruct createLatlonStruct({
  double? lat,
  double? lon,
  String? title,
  String? datetime,
}) =>
    LatlonStruct(
      lat: lat,
      lon: lon,
      title: title,
      datetime: datetime,
    );
