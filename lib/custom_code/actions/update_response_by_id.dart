// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Имя функции изменено для ясности
Future<void> updateResponseById(
  dynamic inspectionJson, // <-- ИЗМЕНЕНО: Теперь это один JSON-объект
  // List<dynamic> jsonData, // <-- УДАЛЕНО
  // int searchId, // <-- УДАЛЕНО
  int equipmentId,
  String formTitle,
  String? newResponse, // Тип String? (nullable) оставляем, это корректно
) async {
  bool updated = false; // Флаг для отслеживания обновления

  // Проверяем, что нам передали не пустой JSON
  if (inspectionJson == null || inspectionJson is! Map<String, dynamic>) {
    print('Ошибка: На вход подан пустой или некорректный JSON (не Map).');
    return;
  }

  // Самый внешний цикл и проверка по searchId УДАЛЕНЫ.
  // Сразу работаем с 'responses' внутри 'inspectionJson'.

  if (inspectionJson.containsKey('responses') &&
      inspectionJson['responses'] is List) {
    for (var response in inspectionJson['responses']) {
      // Проверяем, что 'response' - это Map и ID совпадает
      if (response is Map &&
          response.containsKey('regulation_work_info') &&
          response['regulation_work_info'] is Map &&
          response['regulation_work_info']['equipment'] == equipmentId) {
        // Проверяем наличие 'form_result'
        if (response.containsKey('form_result') &&
            response['form_result'] is List) {
          for (var formResult in response['form_result']) {
            // Проверяем, что 'formResult' - это Map, 'data' - это Map и title совпадает
            if (formResult is Map &&
                formResult.containsKey('data') &&
                formResult['data'] is Map &&
                formResult['data']['title'] == formTitle) {
              // Убедимся, что структура 'result' правильная
              if (formResult.containsKey('result') &&
                  formResult['result'] is Map) {
                // Обновляем значение (newResponse может быть String или null)
                formResult['result']['response'] = newResponse;
                print(
                    'Response (generic) для "$formTitle" обновлен на "$newResponse"');
                updated = true;
                break; // Прерываем цикл 'form_result'
              }
            }
          }
        }
      }
      if (updated) break; // Если обновление выполнено, прерываем 'responses'
    }
  }

  if (!updated) {
    print(
        'Обновление не выполнено. Не найдено совпадение для: [EquipmentID: $equipmentId, FormTitle: "$formTitle"]');
  }
}
