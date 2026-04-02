// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateStartedOn(
  dynamic inspectionJson, // <-- ИЗМЕНЕНО: Теперь это один JSON-объект
  // List<dynamic> jsonData, // <-- УДАЛЕНО
  // int searchId, // <-- УДАЛЕНО
) async {
  // Проверяем, что нам передали не пустой JSON и это Map
  if (inspectionJson == null || inspectionJson is! Map<String, dynamic>) {
    print('Ошибка: На вход подан пустой или некорректный JSON (не Map).');
    return;
  }

  // Самый внешний цикл и проверка по searchId УДАЛЕНЫ.
  // Сразу работаем с 'inspectionJson'.

  // Проверяем, установлено ли значение 'started_on'
  // (Чтобы не перезаписывать его, если оно уже есть)
  if (inspectionJson['started_on'] == null ||
      (inspectionJson['started_on'] as String).isEmpty) {
    // Устанавливаем сегодняшнюю дату в поле started_on
    inspectionJson['started_on'] = DateTime.now().toIso8601String();

    print(
        'Поле started_on обновлено на ${inspectionJson['started_on']} для инспекции ID: ${inspectionJson['id']}');
  } else {
    print(
        'Поле started_on уже было установлено: ${inspectionJson['started_on']}. Обновление не требуется.');
  }
}