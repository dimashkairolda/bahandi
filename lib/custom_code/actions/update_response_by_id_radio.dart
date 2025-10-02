// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateResponseByIdRadio(List<dynamic> jsonData, int searchId,
    int equipmentId, String formTitle, String selectedRadioText) async {
  bool updated = false; // Флаг для отслеживания, было ли обновление выполнено

  // Проходим по массиву JSON, чтобы найти соответствующий элемент
  for (var item in jsonData) {
    if (item['id'] == searchId) {
      // Проверяем, соответствует ли ID искомому
      print('Found matching ID: $searchId');
      if (item.containsKey('responses')) {
        for (var response in item['responses']) {
          if (response['regulation_work_info']['equipment'] == equipmentId) {
            for (var formResult in response['form_result']) {
              if (formResult['data']['title'] == formTitle) {
                // Проверяем, есть ли в форме радиокнопки
                if (formResult['data'].containsKey('radios')) {
                  List<dynamic> radios = formResult['data']['radios'];
                  int selectedIndex = radios.indexWhere(
                      (radio) => radio['text'] == selectedRadioText);

                  if (selectedIndex != -1) {
                    // Если элемент найден, обновляем значение ответа
                    formResult['result']['response'] = selectedIndex.toString();
                    print(
                        'Radio button "$selectedRadioText" found and updated to index $selectedIndex');
                    updated = true;
                    break; // Прерываем цикл после успешного обновления
                  } else {
                    print('Radio button "$selectedRadioText" not found');
                  }
                }
              }
              if (updated) break; // Если обновление выполнено, прерываем цикл
            }
          }
          if (updated) {
            break; // Если обновление выполнено, прерываем внешний цикл
          }
        }
      }
      if (updated) {
        break; // Если обновление выполнено, прерываем самый внешний цикл
      }
    }
  }

  if (!updated) {
    print(
        'No matching data found to update.'); // Выводим сообщение, если обновление не выполнено
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
