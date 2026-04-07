import 'package:flutter_test/flutter_test.dart';
import 'package:Etry/defects/create_defect/create_defect_payload_builder.dart';

void main() {
  group('buildCreateDefectPayload', () {
    test('requires areaId when equipmentId is null', () {
      expect(
        () => buildCreateDefectPayload(
          equipmentId: null,
          areaId: null,
          title: 'Test',
          spareParts: const [],
          priority: false,
          works: const [],
          fileIds: const [],
          formResult: const [],
          formId: null,
          errorMonitoring: false,
          criticality: 'medium',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('includes area when equipmentId is null', () {
      final payload = buildCreateDefectPayload(
        equipmentId: null,
        areaId: 76,
        title: 'Test',
        spareParts: const [],
        priority: false,
        works: const [],
        fileIds: const [1, 2],
        formResult: const [],
        formId: 123,
        errorMonitoring: true,
        criticality: 'low',
      );
      expect(payload['area'], 76);
      expect(payload['equipment'], isNull);
    });

    test('does not require area when equipmentId is provided', () {
      final payload = buildCreateDefectPayload(
        equipmentId: 950,
        areaId: null,
        title: 'Test',
        spareParts: const [],
        priority: true,
        works: const [],
        fileIds: const [],
        formResult: const [],
        formId: null,
        errorMonitoring: false,
        criticality: 'medium',
      );
      expect(payload.containsKey('area'), isFalse);
      expect(payload['equipment'], 950);
    });
  });
}
