// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

Future<void> updateDefectByIdWithImage(List<dynamic> jsonData, int searchId,
    int equipmentId, String formTitle, CreateDefectStruct newDefect) async {
  bool found = false;

  for (var item in jsonData) {
    if (item['id'] == searchId) {
      print('Found matching ID: $searchId');
      if (item.containsKey('responses')) {
        for (var response in item['responses']) {
          if (response['regulation_work_info']['equipment'] == equipmentId) {
            for (var formResult in response['form_result']) {
              if (formResult['data']['title'] == formTitle) {
                formResult['result']['defect'] = {
                  'type': newDefect.type,
                  'event': newDefect.event,
                  'title': newDefect.title,
                  'reason': newDefect.reason,
                  'status': 'new',
                  'is_fixed_on_place': newDefect
                      .isFixedOnPlace, // Boolean value assigned directly
                  'is_emergency_situation': newDefect.isEmergencySituation,
                  'spare_parts': jsonDecode(newDefect.spareparts)
                };

                print('Defect updated for $formTitle to $newDefect');
                found = true;
                break; // Останавливаем цикл после обновления, если нужно обновить только первое совпадение
              }
            }
          }
          if (found) {
            break; // Выход из внешнего цикла, если обновление выполнено
          }
        }
      }
      if (found) {
        break; // Выход из самого внешнего цикла, если обновление выполнено
      }
    }
  }

  if (!found) {
    print('No matching data found to update.');
    return;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
