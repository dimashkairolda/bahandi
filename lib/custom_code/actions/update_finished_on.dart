// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateFinishedOn(List<dynamic> jsonData, int searchId) async {
  bool updated = false; // Флаг для отслеживания, было ли обновление выполнено

  // Проходим по массиву JSON, чтобы найти соответствующий элемент
  for (var item in jsonData) {
    if (item['id'] == searchId) {
      // Устанавливаем сегодняшнюю дату в поле finished_on
      item['finished_on'] = DateTime.now().toIso8601String();
      print('Finished_on updated for ID: $searchId to ${item['finished_on']}');
      return;
    }
  }

  if (!updated) {
    print(
        'No matching data found to update.'); // Выводим сообщение, если обновление не выполнено
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
