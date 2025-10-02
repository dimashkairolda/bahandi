// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateAllResponsesById(
    List<dynamic> data, int id, String newResponse) async {
  // Поиск записи с заданным id
  for (var record in data) {
    if (record['id'] == id) {
      // Изменение каждого result['response'] в form_result, если type == 'radio_defect'
      for (var response in record['responses']) {
        for (var formResult in response['form_result']) {
          if (formResult['type'] == 'radio_defect') {
            formResult['result']['response'] = newResponse;
          }
        }
      }
    }
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
