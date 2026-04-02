// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateResponseByIdCheckboxImage(
    dynamic inspectionJson,
    int equipmentId,
    String formTitle,
    String checkboxText,
    String? newResponse) async {
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
            // Проверяем, что 'formResult' - это Map и 'data' - это Map
            if (formResult is Map &&
                formResult.containsKey('data') &&
                formResult['data'] is Map &&
                formResult['data']['title'] == formTitle) {
              // Проверяем, есть ли в форме чекбоксы
              if (formResult['data'].containsKey('checkboxes') &&
                  formResult['data']['checkboxes'] is List) {
                for (var checkbox in formResult['data']['checkboxes']) {
                  // Проверяем, что 'checkbox' - это Map и текст совпадает
                  if (checkbox is Map &&
                      checkbox.containsKey('text') &&
                      checkbox['text'] == checkboxText) {
                    // Убедимся, что структура 'result' правильная
                    if (checkbox.containsKey('result') &&
                        checkbox['result'] is Map) {
                      // Обновляем значение чекбокса
                      checkbox['result']['image'] = newResponse;
                      print(
                          'Checkbox "$checkboxText" (в форме "$formTitle") обновлен на $newResponse');
                      updated = true;
                      break; // Прерываем цикл 'checkboxes'
                    }
                  }
                }
              }
            }
            if (updated) {
              break; // Если обновление выполнено, прерываем 'form_result'
            }
          }
        }
      }
      if (updated) break; // Если обновление выполнено, прерываем 'responses'
    }
  }

  if (!updated) {
    print(
        'Обновление не выполнено. Не найдено совпадение для: [EquipmentID: $equipmentId, FormTitle: "$formTitle", Checkbox: "$checkboxText"]');
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!