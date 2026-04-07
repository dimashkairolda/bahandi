Map<String, dynamic> buildCreateDefectPayload({
  required int? equipmentId,
  required int? areaId,
  required String title,
  required List<dynamic> spareParts,
  required bool priority,
  required List<dynamic> works,
  required List<int> fileIds,
  required List<dynamic> formResult,
  required int? formId,
  required bool errorMonitoring,
  required String criticality,
}) {
  final payload = <String, dynamic>{
    'equipment': equipmentId,
    'title': title,
    'spare_parts': spareParts,
    'priority': priority,
    'works': works,
    'note': null,
    'file_ids': fileIds,
    'form_result': formResult,
    'form': formId,
    'error_monitoring': errorMonitoring,
    'criticality': criticality,
  };

  if (equipmentId == null) {
    if (areaId == null) {
      throw ArgumentError('areaId is required when equipmentId is null');
    }
    payload['area'] = areaId;
  }

  return payload;
}
