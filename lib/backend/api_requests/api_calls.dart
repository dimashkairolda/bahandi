import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start EtryKZ Group Code

class EtryKZGroup {
  static String getBaseUrl() => 'https://bahandi.etry.kz/api/v1';
  static Map<String, String> headers = {};
  static DefectsCall defectsCall = DefectsCall();
}

class DefectsCall {
  Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    final baseUrl = EtryKZGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Defects',
      apiUrl: '${baseUrl}/defect',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? objecttype(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? objecttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.object_info[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// End EtryKZ Group Code

class AuthCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${username}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Auth',
      apiUrl: 'https://bahandi.etry.kz/api/v1/token/auth',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? accesstoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.access''',
      ));
  static String? refreshtoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refresh''',
      ));
}

class GetDefectsAPICall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? page = '',
    String? date = '',
    String? department = '',
    String? contractor = '',
    String? status = '',
    String? type = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsAPI',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request?per_page=50&page=1${search}${department}${contractor}${status}${type}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceActCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? page = '',
    String? search = '',
    String? date = '',
    String? contractor = '',
    String? area = '',
    String? type = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceAct',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/request/service-act?per_page=10&page=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipTypesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipTypes',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/type?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipManufacturerCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipManufacturer',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/equipment/manufacturer?s=1&type=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipModelCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipModel',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/equipment/model?s=1&manufacturer=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsHistoryByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsHistoryByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}/history',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsCommentByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsCommentByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}/comment',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PostDefectsCommentByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    bool? recommendation,
    String? content = '',
  }) async {
    final ffApiRequestBody = '''
{
  "content": "<p>${content}</p>",
  "recommendation": "${recommendation}"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'PostDefectsCommentByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}/comment',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CreateEquipmentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? contentJson,
  }) async {
    final content = _serializeJson(contentJson);
    final ffApiRequestBody = '''
${content}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateEquipment',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CreateEquipmentInventoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? contentJson,
  }) async {
    final content = _serializeJson(contentJson);
    final ffApiRequestBody = '''
${content}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateEquipmentInventory',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/inventory',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateEquipmentInventoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? contentJson,
    String? id = '',
  }) async {
    final content = _serializeJson(contentJson);
    final ffApiRequestBody = '''
${content}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateEquipmentInventory',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/equipment/inventory?s=1&type=${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateEquipmentInventoryCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? contentJson,
    String? id = '',
  }) async {
    final content = _serializeJson(contentJson);

    return ApiManager.instance.makeApiCall(
      callName: 'UpdateEquipmentInventory Copy',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/inventory/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PostDefectHistoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    List<double>? latLonList,
  }) async {
    final latLon = _serializeList(latLonList);

    final ffApiRequestBody = '''
{
  "request": 300,
  "title": "Исполнитель начал работу",
  "lat_lon": ${latLon}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PostDefectHistory',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/history',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class EditDefectsCommentByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    bool? recommendation,
    String? content = '',
    int? index,
  }) async {
    final ffApiRequestBody = '''
{
  "content": "<p>${content}</p>",
  "recommendation": "${recommendation}"
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'editDefectsCommentByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}/comment/${index}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class DeleteDefectsCommentByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    int? index,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteDefectsCommentByID',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}/comment/${index}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? firstname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? lastname(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? created(dynamic response) => (getJsonField(
        response,
        r'''$[:].created_on''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? company(dynamic response) => (getJsonField(
        response,
        r'''$[:].author_info.company_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceActByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceActByID ',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/service-act/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceActByIDCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceActByID  Copy',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/service-act/${id}/pdf',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
        'Content-Type': 'application/pdf',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetContractorsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetContractors',
      apiUrl: 'https://bahandi.etry.kz/api/v1/company?s=true&all=true',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetClientsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetClients',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/company?s=true&role=client&all=true',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipmentIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentId',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateDefectsByIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    dynamic? bodyJson,
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateDefectsById',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CreateDefectsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? bodyJson,
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateDefects',
      apiUrl: 'https://bahandi.etry.kz/api/v1/request',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateServiceActCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic? bodyJson,
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateServiceAct',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/request/service-act?per_page=10&page=1',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class TestCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? deviceid,
    String? fcmtoken = '',
    String? content = '',
  }) async {
    final ffApiRequestBody = '''
{
  "title": "Создан новый дефект",
  "content": "${content}",
  "device_id": ${deviceid},
  "registration_id": "${fcmtoken}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Test',
      apiUrl: 'https://bahandi.etry.kz/api/v1/notification/send',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic? detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class GetAreaCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetArea',
      apiUrl: 'https://bahandi.etry.kz/api/v1/object/area?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? area(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
}

class GetTypeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetType',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/type?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? area(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
}

class EquipmentsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Equipments',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/tree?s=1&rsp=true',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? eQuipment(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? childrentitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].children[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class UserAccountMeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UserAccountMe',
      apiUrl: 'https://bahandi.etry.kz/api/v1/account/me',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
  static String? role(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.role''',
      ));
}

class GetEquipmentsTreeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsTree',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment/tree?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? equipid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? img(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].img''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? factorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].factory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? inventorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].inventory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dispatchnumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].dispatch_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipmentsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipments',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment?per_page=400',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? equipid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? departmenttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? responsibles(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].responsibles_info[:].full_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? inventorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].inventory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dispatchnumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].dispatch_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? parentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].parent_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? factorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].factory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? img(dynamic response) => getJsonField(
        response,
        r'''$.data[:].img''',
        true,
      ) as List?;
  static List<int>? departmentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetEquipmentsBarcodeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? barcode = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsBarcode',
      apiUrl: 'https://bahandi.etry.kz/api/v1/equipment?search=${barcode}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? equipid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? departmenttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? responsibles(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].responsibles_info[:].full_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? inventorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].inventory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dispatchnumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].dispatch_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? parentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].parent_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? factorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].factory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? img(dynamic response) => getJsonField(
        response,
        r'''$.data[:].img''',
        true,
      ) as List?;
  static List<int>? departmentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetEquipmentsBarcodeCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? barcode = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsBarcode Copy',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/equipment/inventory?search=${barcode}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? equipid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? departmenttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? responsibles(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].responsibles_info[:].full_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? inventorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].inventory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dispatchnumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].dispatch_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? parentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].parent_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? factorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].factory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? img(dynamic response) => getJsonField(
        response,
        r'''$.data[:].img''',
        true,
      ) as List?;
  static List<int>? departmentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetEquipmentsPaginationCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? page = 1,
    String? search = '',
    String? department = '',
    String? area = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsPagination',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/equipment?per_page=10&page=${page}${search}${department}${area}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? equipid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? departmenttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? responsibles(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].responsibles_info[:].full_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? inventorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].inventory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? dispatchnumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].dispatch_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? parentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].parent_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? factorynumber(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].factory_number''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? img(dynamic response) => getJsonField(
        response,
        r'''$.data[:].img''',
        true,
      ) as List?;
  static List<int>? departmentid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].department_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetAllInspectionsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? date = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllInspections',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/regulation/history?per_page=700&page=1&date=${date}&f=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {
        'date': date,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? responses(dynamic response) => getJsonField(
        response,
        r'''$.data[:].responses''',
        true,
      ) as List?;
  static List<String>? regulationtitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.equipment_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAllInspectionsCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? date = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAllInspections Copy',
      apiUrl:
          'https://bahandi.etry.kz/api/v1/regulation/history?per_page=50&page=1&date=${date}&f=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {
        'date': date,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? responses(dynamic response) => getJsonField(
        response,
        r'''$.data[:].responses''',
        true,
      ) as List?;
  static List<String>? regulationtitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.equipment_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class InspectionFinishCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
    dynamic? responseJson,
    String? finishedOn = '',
    String? startedOn = '',
  }) async {
    final response = _serializeJson(responseJson, true);
    final ffApiRequestBody = '''
{
  "started_on": "${startedOn}",
  "finished_on": "${finishedOn}",
  "responses": ${response}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'InspectionFinish',
      apiUrl: 'https://bahandi.etry.kz/api/v1/regulation/history/${id}/finish',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class StartInspectionCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'StartInspection',
      apiUrl: 'https://bahandi.etry.kz/api/v1/regulation/history/${id}/start',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DepartmentsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Departments',
      apiUrl: 'https://bahandi.etry.kz/api/v1/department?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UsersListCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UsersList',
      apiUrl: 'https://bahandi.etry.kz/api/v1/account/user?s=1',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateFCMTokenCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? deviceid = '',
    String? fcmtoken = '',
    int? userId,
  }) async {
    final ffApiRequestBody = '''
{
  "device_id": "${deviceid}",
  "registration_id": "${fcmtoken}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'UpdateFCMToken',
      apiUrl: 'https://bahandi.etry.kz/api/v1/notification/fcm',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
