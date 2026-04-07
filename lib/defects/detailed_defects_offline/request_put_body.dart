import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// ID вложений для `file_ids` (в т.ч. видео), даже если [FilesStruct.maybeFromMap] вернул null.
List<int> extractAttachmentFileIds(List<dynamic> combinedFileJsonList) {
  final fileIds = <int>[];
  final seen = <int>{};
  for (final e in combinedFileJsonList) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final f = FilesStruct.maybeFromMap(m);
    int? id;
    if (f != null && f.hasId()) {
      id = f.id;
    } else {
      final raw = m['id'];
      if (raw != null && raw.toString() != 'null') {
        id = castToType<int>(raw) ?? int.tryParse(raw.toString());
      }
    }
    if (id != null && seen.add(id)) {
      fileIds.add(id);
    }
  }
  return fileIds;
}

/// Полное тело PUT `https://app.etry.kz/api/v1/request/{id}` в формате API.
/// Бэк ожидает и [files] (список объектов или `[]` при очистке), и [file_ids].
Map<String, dynamic> buildFullRequestPutBody({
  required dynamic defectJsonBody,
  required List<WorksStruct> works,
  required List<TmcStruct> spareParts,
  required List<dynamic> combinedFileJsonList,
}) {
  final title =
      getJsonField(defectJsonBody, r'''$.title''')?.toString() ?? '';

  int? equipmentId;
  final eq = getJsonField(defectJsonBody, r'''$.equipment''');
  if (eq != null && eq.toString() != 'null') {
    equipmentId = castToType<int>(eq) ?? int.tryParse(eq.toString());
  }
  if (equipmentId == null) {
    final infoId = getJsonField(defectJsonBody, r'''$.equipment_info.id''');
    if (infoId != null && infoId.toString() != 'null') {
      equipmentId =
          castToType<int>(infoId) ?? int.tryParse(infoId.toString());
    }
  }

  bool priority = false;
  final priorityVal = getJsonField(defectJsonBody, r'''$.priority''');
  if (priorityVal is bool) {
    priority = priorityVal;
  } else if (priorityVal != null &&
      priorityVal.toString().toLowerCase() == 'true') {
    priority = true;
  } else {
    final cr = getJsonField(defectJsonBody, r'''$.criticality''')?.toString() ??
        getJsonField(defectJsonBody, r'''$.priority_request''')?.toString() ??
        '';
    priority = cr == 'high';
  }

  final criticalityStr =
      getJsonField(defectJsonBody, r'''$.criticality''')?.toString() ??
          getJsonField(defectJsonBody, r'''$.priority_request''')?.toString() ??
          'medium';

  final errVal = getJsonField(defectJsonBody, r'''$.error_monitoring''');
  final bool errorMonitoring = errVal is bool
      ? errVal
      : (errVal?.toString().toLowerCase() == 'true');

  final noteVal = getJsonField(defectJsonBody, r'''$.note''');
  final String? note = (noteVal == null || noteVal.toString() == 'null')
      ? null
      : noteVal.toString();

  final fileIds = extractAttachmentFileIds(combinedFileJsonList);

  final filesMaps = <Map<String, dynamic>>[];
  for (final e in combinedFileJsonList) {
    if (e is! Map) continue;
    final m = Map<String, dynamic>.from(e);
    final f = FilesStruct.maybeFromMap(m);
    if (f != null) {
      filesMaps.add(f.toMap());
    } else {
      filesMaps.add(m);
    }
  }

  final body = <String, dynamic>{
    'title': title,
    'equipment': equipmentId,
    'priority': priority,
    'criticality': criticalityStr,
    'error_monitoring': errorMonitoring,
    'works': works
        .map(
          (w) => <String, dynamic>{
            'title': w.title,
            'amount': w.amount.toString(),
          },
        )
        .toList(),
    'spare_parts': spareParts
        .map(
          (t) => <String, dynamic>{
            'title': t.title,
            'model': t.model,
            'amount': t.amount.toString(),
          },
        )
        .toList(),
    'files': filesMaps,
    'file_ids': fileIds,
  };
  if (note != null) {
    body['note'] = note;
  }
  return body;
}
