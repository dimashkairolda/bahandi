import 'dart:convert';

import 'package:intl/intl.dart';
import '/backend/schema/structs/index.dart';

Color? colorDefect(String? value) {
  Color color = Colors.black;
  if (value == 'workable') {
    color = const Color(0xFF1AB759);
  } else if (value == 'unworkable') {
    color = const Color(0xFFFFE001);
  } else {
    color = const Color(0xFFFF3B30);
  }

  return color;
}


String validateRadioDefectFilling23(dynamic inspectionJson) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1. Проверка на общую валидность
  if (inspectionJson == null || inspectionJson is! Map) {
    return "Ошибка структуры данных";
  }

  // 2. Получаем список ответов
  if (!inspectionJson.containsKey('responses') ||
      inspectionJson['responses'] is! List) {
    return "Нет данных для проверки";
  }

  List<String> missingQuestions = [];
  int questionCounter = 1; // Общий счетчик вопросов для пользователя

  // 3. Проходим по всем Responses
  for (var response in inspectionJson['responses']) {
    if (response is Map && response['form_result'] is List) {
      // 4. Проходим по всем элементам формы
      for (var item in response['form_result']) {
        if (item is Map) {
          // Проверяем только тип "radio_defect"
          if (item['type'] == 'radio_defect') {
            bool isInvalid = false;

            // Проверка наличия блока result
            if (item['result'] == null || item['result'] is! Map) {
              isInvalid = true;
            } else {
              var result = item['result'];

              // Проверяем заполнение ответа и наличие фото
              bool hasResponse = result['response'] != null &&
                  result['response'].toString().isNotEmpty;
              bool hasImage = result['image'] != null &&
                  result['image'].toString().isNotEmpty;

              if (!hasResponse || !hasImage) {
                isInvalid = true;
              }
            }

            // Если нашли ошибку, добавляем текущий номер в список
            if (isInvalid) {
              missingQuestions.add(questionCounter.toString());
            }

            // Инкрементируем счетчик только для вопросов типа radio_defect
            questionCounter++;
          }
        }
      }
    }
  }

  // Если список пуст — всё заполнено. Если нет — возвращаем номера через запятую.
  return missingQuestions.isEmpty
      ? ""
      : "Заполните вопросы: ${missingQuestions.join(', ')}";

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

bool validateRadioDefectFilling(dynamic inspectionJson) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1. Проверка на валидность JSON
  if (inspectionJson == null || inspectionJson is! Map) {
    return false;
  }

  // 2. Получаем список ответов
  if (!inspectionJson.containsKey('responses') ||
      inspectionJson['responses'] is! List) {
    return false;
  }

  // 3. Проходим по всем Responses (оборудованию/регламентам)
  for (var response in inspectionJson['responses']) {
    if (response is Map && response['form_result'] is List) {
      // 4. Проходим по всем элементам формы
      for (var item in response['form_result']) {
        if (item is Map) {
          // Нас интересуют только элементы типа "radio_defect"
          if (item['type'] == 'radio_defect') {
            // Проверяем наличие блока result
            if (item['result'] == null || item['result'] is! Map) {
              return false; // Результата вообще нет
            }

            var result = item['result'];

            // 5. ПРОВЕРКА ПОЛЕЙ
            // Проверяем response (должен быть не null и не пустой строкой)
            bool hasResponse = result['response'] != null &&
                result['response'].toString().isNotEmpty;

            // Проверяем image (должен быть не null и не пустой строкой)
            bool hasImage = result['image'] != null &&
                result['image'].toString().isNotEmpty;

            // Если хотя бы одно из условий не выполнено — возвращаем false (валидация не прошла)
            if (!hasResponse || !hasImage) {
              // Для отладки можно раскомментировать строку ниже, чтобы видеть, где ошибка:
              // print('Ошибка валидации в пункте: ${item['data']['title']}');
              return false;
            }
          }
        }
      }
    }
  }

  // Если цикл прошел до конца и не вернул false, значит всё заполнено
  return true;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

List<dynamic> filterFinishedReglament(dynamic jsonData) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1. Проверяем, что входные данные не null
  if (jsonData == null) {
    return [];
  }

  // 2. Определяем список для фильтрации.
  // В твоем JSON массив лежит внутри ключа "data".
  List<dynamic> dataList = [];

  if (jsonData is Map && jsonData.containsKey('data') && jsonData['data'] is List) {
    dataList = jsonData['data'];
  } else if (jsonData is List) {
    // На случай, если в функцию передали сразу список (минуя ключ data)
    dataList = jsonData;
  } else {
    return [];
  }

  // 3. Фильтруем список
  // Оставляем только те элементы, где finished_on НЕ равно null
  return dataList.where((item) {
    return item is Map && item["finished_on"] != null;
  }).toList();

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

String? getResponseByIdRadioImage(
  dynamic inspectionJson,
  int equipmentId,
  String formTitle,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1. Проверяем валидность входного JSON
  if (inspectionJson == null || inspectionJson is! Map) {
    return null;
  }

  // 2. Ищем массив 'responses'
  if (!inspectionJson.containsKey('responses') ||
      inspectionJson['responses'] is! List) {
    return null;
  }

  // 3. Перебираем responses
  for (var response in inspectionJson['responses']) {
    // Проверка Equipment ID
    if (response is Map &&
        response['regulation_work_info'] is Map &&
        response['regulation_work_info']['equipment'] == equipmentId) {
      // Ищем form_result
      if (response['form_result'] is List) {
        for (var formResult in response['form_result']) {
          // Проверяем структуру элемента (должен содержать data и result)
          if (formResult is Map &&
              formResult['data'] is Map &&
              formResult['result'] is Map) {
            // Проверка Form Title (название поля)
            // Например: "Күзеттен белгі қою (ОСО-дегі нүктелерге қатысты)"
            if (formResult['data']['title'] == formTitle) {
              // Возвращаем image, если он есть и не null
              if (formResult['result']['image'] != null) {
                return formResult['result']['image'].toString();
              }
            }
          }
        }
      }
    }
  }

  // Если ничего не найдено или image == null
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
String? getResponseByIdCheckboxImage(
  dynamic inspectionJson,
  int equipmentId,
  String formTitle,
  String checkboxText,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // 1. Проверяем валидность входного JSON
  if (inspectionJson == null || inspectionJson is! Map) {
    return null;
  }

  // 2. Ищем массив 'responses'
  if (!inspectionJson.containsKey('responses') ||
      inspectionJson['responses'] is! List) {
    return null;
  }

  // 3. Перебираем responses
  for (var response in inspectionJson['responses']) {
    // Проверка Equipment ID
    if (response is Map &&
        response['regulation_work_info'] is Map &&
        response['regulation_work_info']['equipment'] == equipmentId) {
      // Ищем form_result
      if (response['form_result'] is List) {
        for (var formResult in response['form_result']) {
          // Проверка Form Title
          if (formResult is Map &&
              formResult['data'] is Map &&
              formResult['data']['title'] == formTitle) {
            // Ищем checkboxes
            if (formResult['data']['checkboxes'] is List) {
              for (var checkbox in formResult['data']['checkboxes']) {
                // Проверка текста чекбокса
                if (checkbox is Map && checkbox['text'] == checkboxText) {
                  // Возвращаем image, если он есть
                  if (checkbox['result'] is Map &&
                      checkbox['result']['image'] != null) {
                    return checkbox['result']['image'].toString();
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  // Если ничего не найдено
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

String? jsonToStringCopy(dynamic resulttitle) {
  String dataConvertedToJSON = json.encode(resulttitle);
  // print(dataConvertedToJSON);
  return dataConvertedToJSON;
}

int? stringToInt(String? name) {
  if (name == null) {
    return null;
  } else {
    int num = int.parse(name);
    return num;
  }
}

String? statusToRus(String? status) {
  if (status == 'fixed') {
    return 'Исправен';
  } else if (status == 'new') {
    return 'Новый дефект';
  } else if (status == 'reject') {
    return 'Отклонен';
  } else {
    return 'Неисправен';
  }
}

Color? colorDefectCopy(String? value) {
  Color color = Colors.black;
  if (value == 'open') {
    color = const Color(0xFFFF3B2F);
  } else if (value == 'contractor_appointed') {
    color = const Color(0xFF460092);
  } else if (value == 'at_performer') {
    color = const Color(0xFFBE6500);
  } else if (value == 'postponed') {
    color = const Color(0xFF757575);
  } else if (value == 'contractor_accept') {
    color = const Color(0xFFBC00D9);
  } else if (value == 'in_progress') {
    color = const Color(0xFFCF8700);
  } else if (value == 'completed') {
    color = const Color(0xFF1234E1);
  } else if (value == 'under_review') {
    color = const Color(0xFF1976D2);
  } else if (value == 'rejected') {
    color = const Color(0xFF8A8A8A);
  } else {
    color = const Color(0xFF04A856);
  }

  return color;
}

List<dynamic> combineArrays(
  List<dynamic>? array1,
  List<dynamic>? array2,
) {
  List<dynamic> combinedArray = [];

  if (array1 != null) {
    combinedArray.addAll(array1); // Добавляем первый массив, если не null
  }

  if (array2 != null) {
    combinedArray.addAll(array2); // Добавляем второй массив, если не null
  }

  return combinedArray;
}

String? formatDateTime(String? datetime) {
  var parsedDate = DateTime.parse(datetime!);
  final DateTime now = parsedDate;
  final DateFormat formatter = DateFormat('dd MM yyyy');
  final String formatted = formatter.format(now);
  return formatted;
}

String? statusToEng(String? status) {
  if (status == 'Работоспособное') {
    return 'workable';
  } else if (status == 'Нерабоспособное') {
    return 'unworkable';
  } else {
    return 'critical';
  }
}

int? boolToInt(bool boolean) {
  if (boolean == true) {
    return 1;
  } else if (boolean == false) {
    return 0;
  }
  return null;
}

List<dynamic> filterFinishedInspections(List<dynamic> jsonData) {
  return jsonData.where((item) => item["finished_on"] != null).toList();
}

bool? intToBool(int num) {
  if (num == 1) {
    return true;
  } else {
    return false;
  }
}

dynamic findJsonByBarcode(
  String idd,
  List<dynamic> jsonData,
) {
  try {
    // Используем firstWhere для поиска элемента с нужным id
    return jsonData.firstWhere((json) => json['barcode'] == idd,
        orElse: () => null // Возвращаем null, если элемент не найден
        );
  } catch (e) {
    // Обрабатываем исключение, если что-то пошло не так
    print('Error: $e');
    return null;
  }
}

String? extractResponsesCopy(
  List<dynamic> jsonData,
  int index,
) {
  // Проверяем, что индекс находится в пределах диапазона списка
  if (index >= 0 && index < jsonData.length) {
    var item = jsonData[index];
    if (item.containsKey('started_on')) {
      return item[
          'started_on']; // Возвращаем список responses, если он существует
    }
  }
  return null; // Возвращаем null, если индекс вне диапазона или нет ключа 'responses'
}

String? jsonToString(List<dynamic> resulttitle) {
  var dataConvertedToJSON = json.encode(resulttitle);
  // print(dataConvertedToJSON);
  return dataConvertedToJSON;
}

int listlength(List<dynamic> listt) {
  return listt.length;
}

String defectorNormal(String isNormal) {
  if (isNormal == 'normal') {
    return 'defect';
  } else {
    return 'normal';
  }
}

int indexOf(
  List<dynamic> listt,
  dynamic item,
) {
  int index = listt.indexWhere((map) =>
      map.keys.every((key) => item.containsKey(key) && map[key] == item[key]) &&
      item.keys.every((key) => map.containsKey(key) && map[key] == item[key]));
  return index;
}

List<dynamic> filterDefectiveDefect(dynamic jsonData) {
  return jsonData.where((item) => item["status"] != "fixed").toList();
}

String searchFromList(
  List<dynamic> listt,
  String item,
) {
  for (var map in listt) {
    if (map.containsKey(item)) {
      return map[item] ?? ''; // Возвращаем значение, если ключ найден
    }
  }
  return '';
}

String findWithIndexFromList(
  List<String> listt,
  int index,
) {
  return listt[index];
}

int? findWithIndexFromINTList(
  List<dynamic> listt,
  int index,
) {
  return listt[index];
}

dynamic findWithIndexFromListJson(
  List<dynamic> listt,
  int index,
) {
  return listt[index];
}

int plus(
  int a,
  int b,
) {
  return a + b;
}

List<dynamic> findJsonByEquipment(
  int idd,
  List<dynamic> jsonData,
) {
  return jsonData.where((item) => item["equipment"] == idd).toList();
}

dynamic stringToJson(String jsonString) {
  return jsonDecode(jsonString);
}

dynamic deleteJsonByKey(
  List<dynamic> list,
  int value,
) {
  // Проверяем, найден ли элемент

  // Если элемент найден, удаляем его
  print(list);
  list.removeAt(value);
  print(list);
  return list;
}

bool containsItem(
  List<RadiobuttondataStruct> list,
  String search1,
  String search2,
  String search3,
) {
  return list.any((item) =>
      item.equiptitle == search1 &&
      item.datatitle == search2 &&
      item.response == search3);
}

List<dynamic> findResponsesByTechnicalPlace(
  List<dynamic> jsonData,
  int technicalPlaceId,
) {
  List<dynamic> foundResponses = [];

  for (var item in jsonData) {
    // Проверяем наличие regulation_info и соответствие technical_place
    if (item['regulation_info'] != null &&
        item['regulation_info']['technical_place'] == technicalPlaceId) {
      // Проверяем наличие responses
      if (item['responses'] != null) {
        List<dynamic> responses = [];

        // Собираем все responses для данного technical_place
        for (var response in item['responses']) {
          responses.add(response);
        }

        // Если responses найдены, добавляем элемент в результат
        if (responses.isNotEmpty) {
          var newItem =
              Map<String, dynamic>.from(item); // Создание копии элемента
          newItem['responses'] = responses;
          foundResponses.add(newItem);
        }
      }
    }
  }

  return foundResponses;
}

int findIxdexOfDataType(
  List<RadiobuttondataStruct> list,
  String search1,
  String search2,
  String search3,
) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].equiptitle == search1 &&
        list[i].datatitle == search2 &&
        list[i].response == search3) {
      // Возвращаем индекс, если нашли совпадение
      return i;
    }
  }
  return -1;
}

String? searchFromDataTypeList2Enters(
  List<RadiobuttondataStruct> data,
  String search1,
  String search2,
) {
  try {
    // Используем firstWhere без orElse и обрабатываем исключение, если элемент не найден
    final item = data.firstWhere(
      (item) => item.equiptitle == search1 && item.datatitle == search2,
    );

    // Возвращаем response, если элемент найден
    return item.response;
  } catch (e) {
    // Возвращаем null, если элемент не найден
    return null;
  }
}

List<dynamic> filterUnfinishedInspections(List<dynamic> jsonData) {
  return jsonData.where((item) => item["finished_on"] == null).toList();
}

List<dynamic> filterEquipments(
  List<dynamic> jsonData,
  int idd,
) {
  return jsonData.where((item) => item["id"] == idd).toList();
}

dynamic findJsonByID(
  int idd,
  List<dynamic> jsonData,
) {
  try {
    // Используем firstWhere для поиска элемента с нужным id
    return jsonData.firstWhere((json) => json['id'] == idd,
        orElse: () => null // Возвращаем null, если элемент не найден
        );
  } catch (e) {
    // Обрабатываем исключение, если что-то пошло не так
    print('Error: $e');
    return null;
  }
}

String roleToRus(String text) {
  if (text == 'operational_duty') {
    return "Оперативный дежурный";
  } else if (text == 'engineer') {
    return "Инженер";
  } else if (text == 'head') {
    return "Начальник";
  } else if (text == 'electrician') {
    return "Электрослесарь";
  } else if (text == 'electrician_underground') {
    return "Подземный электрослесарь";
  } else if (text == 'lead_engineer') {
    return "Ведущий инженер";
  } else if (text == 'director') {
    return "Директор";
  } else {
    return text;
  }
}

List<dynamic> notNewDefects(List<dynamic> jsonData) {
  return jsonData.where((item) => item["status"] != "new").toList();
}

List<dynamic> filterChildEquips(
  List<dynamic> jsonData,
  int parentId,
) {
  return jsonData.where((item) {
    // Получаем словарь parent_info и сравниваем его элемент parentId с заданным parentId
    if (item.containsKey('parent_info') &&
        item['parent_info'] is Map<String, dynamic>) {
      return item['parent_info']['id'] == parentId;
    }
    return false; // Если нет ключа parent_info или он не соответствует структуре, возвращаем false
  }).toList();
}

DateTime? stringToDateTime(String date) {
  try {
    // Пробуем преобразовать строку в DateTime
    return DateTime.parse(date);
  } catch (e) {
    // В случае ошибки выводим информацию об ошибке и возвращаем null
    print('Error parsing date string: $e');
    return null;
  }
}

DateTime? dateTimeNow() {
  return DateTime.now();
}

bool imageNull(dynamic input) {
  const List<Map<String, dynamic>> targets = [
    {
      'data': "data:image/jpeg;base64,",
      'extension': 'jpeg',
      'size': 0,
      'title': null
    },
    {
      'data': "data:image/png;base64,",
      'extension': 'png',
      'size': 0,
      'title': null
    },
    {
      'data': "data:image/gif;base64,",
      'extension': 'gif',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mp4;base64,",
      'extension': 'mp4',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mov;base64,",
      'extension': 'mov',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/avi;base64,",
      'extension': 'avi',
      'size': 0,
      'title': null
    },
    {
      'data': "data:video/mkv;base64,",
      'extension': 'mkv',
      'size': 0,
      'title': null
    },
    {
      'data': 'data:application/octet-stream;base64,',
      'extension': "",
      'size': 0,
      'title': ""
    },
  ];

  // Проверяем, что input — Map (любой)
  if (input is! Map) return false;

  // Приводим к Map<String, dynamic> (если ключи не String — выбросит, но у тебя ключи String)
  final Map<String, dynamic> inputMap = Map<String, dynamic>.from(input);

  // Сравниваем с каждым шаблоном
  for (final target in targets) {
    if (inputMap.length != target.length) continue;

    var isEqual = true;
    for (final key in target.keys) {
      if (!inputMap.containsKey(key)) {
        isEqual = false;
        break;
      }

      final v1 = inputMap[key];
      final v2 = target[key];

      // Если строки — можно сравнить с trim() на случай лишних пробелов:
      if (v1 is String && v2 is String) {
        if (v1.trim() != v2.trim()) {
          isEqual = false;
          break;
        }
      } else {
        if (v1 != v2) {
          isEqual = false;
          break;
        }
      }
    }

    if (isEqual) return true;
  }

  return false;
}

List<dynamic>? extractResponses(
  List<dynamic> jsonData,
  int index,
) {
  // Проверяем, что индекс находится в пределах диапазона списка
  if (index >= 0 && index < jsonData.length) {
    var item = jsonData[index];
    if (item.containsKey('responses')) {
      return item[
          'responses']; // Возвращаем список responses, если он существует
    }
  }
  return null; // Возвращаем null, если индекс вне диапазона или нет ключа 'responses'
}

String? imageNullList() {
  List<String> encodedFiles = [];
  Map<String, dynamic> newJson = {
    'data': "data:image/jpeg;base64,",
    'extension': 'jpg',
    'size': 0, // размер файла равен длине массива байтов
    'title': null
  };

  String finalJsonString = jsonEncode(newJson);
  print(finalJsonString);
  encodedFiles.add(finalJsonString);
  return encodedFiles.toString();
}

List<dynamic> filterFixedDefect(dynamic jsonData) {
  return jsonData.where((item) => item["status"] == "fixed").toList();
}

dynamic sortUsers(
  dynamic jsonData,
  int departmentId,
) {
  var filteredData = (jsonData['data'] as List)
      .where((item) => item['department'] == departmentId)
      .toList();
  return {'data': filteredData};
}

bool hasStuff(
  dynamic jsonData,
  int? departmentId,
) {
  var filteredData = (jsonData['data'] as List)
      .where((item) => item['department'] == departmentId)
      .toList();

  return filteredData
      .isNotEmpty; // Return true if filtered list is not empty, false otherwise.
}

int newDefectsSum(
  dynamic jsonData,
  DateTime inputDate,
) {
  var filteredData = (jsonData as List).where((item) {
    var createdOn = DateTime.parse(item['created_on']);

    // Сравнение даты без времени
    return item['status'] == 'not_confirmed' &&
        createdOn.year == inputDate.year &&
        createdOn.month == inputDate.month &&
        createdOn.day == inputDate.day;
  }).toList();

  return filteredData.length;
}

List<dynamic> newDefects(dynamic jsonData) {
  return jsonData.where((item) => item["status"] == "new").toList();
}

List<dynamic> filterdoprasxody(
  List<dynamic> jsonData,
  String technic,
) {
  return jsonData.where((item) => item["technic"] == technic).toList();
}

List<dynamic> findResponsesByEquipment(
  List<dynamic> jsonData,
  int equipmentId,
) {
  List<dynamic> foundResponses = [];

  for (var item in jsonData) {
    if (item['responses'] != null) {
      List<dynamic> responses = [];
      for (var response in item['responses']) {
        if (response['regulation_work_info'] != null &&
            response['regulation_work_info']['equipment_info'] != null &&
            response['regulation_work_info']['equipment_info']['id'] ==
                equipmentId) {
          responses.add(response);
          break; // Остановка поиска, если оборудование найдено в данном осмотре
        }
      }
      if (responses.isNotEmpty) {
        var newItem =
            Map<String, dynamic>.from(item); // Создание копии элемента
        newItem['responses'] = responses;
        foundResponses.add(newItem);
      }
    }
  }

  return foundResponses;
}

List<dynamic> filterInspectionsByTitle(
  List<dynamic> data,
  String title,
) {
  return data
      .where((item) => item['regulation_info']['title'] == title)
      .toList();
}

List<dynamic> findUniqueRegulationAndEquipmentTitles(List<dynamic> data) {
  Set<String> uniqueTitles = {};

  // Создаем список для хранения данных с уникальными заголовками
  List<dynamic> uniqueInspections = [];

  // Проходим по всем осмотрам
  for (var inspection in data) {
    var title = inspection['regulation_info']['title'];

    // Проверяем, есть ли этот заголовок в множестве уникальных заголовков
    if (!uniqueTitles.contains(title)) {
      // Если заголовка еще нет, добавляем его в множество уникальных заголовков
      uniqueTitles.add(title);

      // Добавляем данные с этим уникальным заголовком в список уникальных данных
      uniqueInspections.add(inspection);
    }
  }
  return uniqueInspections;
}

String checkInspectionStatus(
  String availableFrom,
  String availableTo,
) {
  DateTime now = DateTime.now();
  DateTime from = DateTime.parse(availableFrom);
  DateTime to = DateTime.parse(availableTo);

  if (now.isBefore(from)) {
    return "Запланировано";
  } else if (now.isAfter(from) && now.isBefore(to)) {
    return "Текущее";
  } else {
    return "Просрочено";
  }
}

dynamic findJsonElementByID(
  List<dynamic> jsonData,
  int id,
) {
  for (var item in jsonData) {
    if (item['id'] == id) {
      return item; // Return the matching element
    }
  }
  return null;
}

bool isJsonInList(
  int searchId,
  List<dynamic> jsonList,
) {
  for (var item in jsonList) {
    if (item['id'] == searchId) {
      return true;
    }
  }
  return false;
}

String? statusToRuss(String? status) {
  if (status == 'workable') {
    return 'Работоспособное';
  } else if (status == 'unworkable') {
    return 'Нерабоспособное';
  } else if (status == 'critical') {
    return 'Предельное';
  } else {
    return null;
  }
}

String getMondayOfCurrentWeek() {
  DateTime now = DateTime.now();
  int currentWeekday = now.weekday;
  DateTime monday =
      now.subtract(Duration(days: currentWeekday - DateTime.monday));
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(monday);
}

String getSundayOfCurrentWeek() {
  DateTime now = DateTime.now();
  int currentWeekday = now.weekday;
  DateTime sunday = now.add(Duration(days: DateTime.sunday - currentWeekday));
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(sunday);
}

List<dynamic> filterByDate(
  List<dynamic>? data,
  DateTime date,
) {
  if (data == null) {
    return [];
  }
  // Преобразуем выбранную дату в строку для сравнения
  String selectedDateString = DateFormat('yyyy-MM-dd').format(date);

  // Фильтруем данные, чтобы выбрать записи на выбранную дату
  List<dynamic> filteredData = data.where((entry) {
    DateTime availableFrom = DateTime.parse(entry['available_from']);
    String availableFromDateString =
        DateFormat('yyyy-MM-dd').format(availableFrom);

    return availableFromDateString == selectedDateString;
  }).toList();

  return filteredData;
}

String getTomorrow() {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(tomorrow);
}

String removeBase64Prefix(dynamic fileJson) {
  // 1. Проверяем, что на вход пришел Map (JSON-объект)
  if (fileJson is! Map<String, dynamic>) {
    // Если это не Map, возможно, это уже просто строка.
    // Попробуем обработать ее, как в старой функции.
    if (fileJson is String) {
      if (fileJson.contains(',')) {
        return fileJson.split(',').last;
      }
      return fileJson; // Вернуть как есть
    }
    return ''; // Если это не Map и не String, вернуть пустоту
  }

  // 2. Это Map. Извлекаем поле 'data'.
  String base64Data = fileJson['data'] as String? ?? '';

  // 3. Удаляем префикс (как в вашей старой функции, но надежнее)
  if (base64Data.contains(',')) {
    return base64Data.split(',').last;
  }

  // 4. Возвращаем чистый Base64-код.
  // 'extension', 'size' и 'title' игнорируются.
  return base64Data;
}

String? statusRequest(String? status) {
  if (status == 'open') {
    return 'Открыта';
  } else if (status == 'contractor_appointed') {
    return 'Подрядчик назначен';
  } else if (status == 'at_performer') {
    return 'У исполнителя';
  } else if (status == 'postponed') {
    return 'Отложена';
  } else if (status == 'contractor_accept') {
    return 'Принят подрядчиком';
  } else if (status == 'in_progress') {
    return 'В работе';
  } else if (status == 'completed') {
    return 'Выполнен';
  } else if (status == 'under_review') {
    return 'На проверке';
  } else if (status == 'rejected') {
    return 'Отклонена';
  } else {
    return 'Закрыта';
  }
}

int? getNextInspectionId(
  List<dynamic> inspections,
  int currentIndex,
) {
  if (currentIndex < inspections.length - 1) {
    return inspections[currentIndex - 1]['id'];
  } else {
    // Если текущий индекс последний, возвращаем null
    return null;
  }
}

double? stringToDouble(String? name) {
  if (name == null) {
    return null;
  } else {
    double num = double.parse(name);
    return num;
  }
}

String? getResponseByIdZamery(
  List<dynamic> jsonData,
  int searchId,
  int equipmentId,
  String formTitle,
) {
  for (var item in jsonData) {
    if (item['id'] == searchId) {
      // Проверяем, соответствует ли ID искомому
      print('Found matching ID: $searchId');
      if (item.containsKey('responses')) {
        for (var response in item['responses']) {
          if (response['regulation_work_info']['equipment'] == equipmentId) {
            for (var formResult in response['form_result']) {
              if (formResult['data']['title'] == formTitle) {
                var currentResponse = formResult['result']['response'];
                print('Current response for $formTitle: $currentResponse');
                return currentResponse; // Возвращаем текущее значение ответа
              }
            }
          }
        }
      }
    }
  }

  // Если не найдено совпадений
  print('No matching data found.');
  return null; // Возвращаем null, если данные не найдены
}

String stringtoBase64(String base64String) {
  // Проверяем, содержит ли строка префикс "data:image/png;base64,"
  if (base64String.startsWith('data:image/png;base64,')) {
    // Убираем префикс и возвращаем только часть с base64
    return base64String.replaceFirst('data:image/png;base64,', '');
  }
  // Если префикса нет, возвращаем оригинальную строку
  return base64String;
}

bool? emptyList(List<dynamic>? list) {
  return list?.isEmpty;
}

List<FilesStruct> combineArraysfiles(
  List<FilesStruct>? array1,
  List<FilesStruct>? array2,
) {
  List<FilesStruct> combinedArray = [];

  if (array1 != null) {
    combinedArray.addAll(array1); // Добавляем первый массив, если не null
  }

  if (array2 != null) {
    combinedArray.addAll(array2); // Добавляем второй массив, если не null
  }

  return combinedArray;
}

List<int> inttolist(int value) {
  return [value];
}

List<int> inttoarray(int number) {
  return [number];
}

List<dynamic> addJsonToList(
  List<dynamic> jsonList,
  double lat,
  double lon,
  String datetime,
  String title,
) {
  jsonList ??= [];

  // Создаем новый JSON на основе входных параметров
  Map<String, dynamic> newJson = {
    'lat': lat,
    'lon': lon,
    'datetime': datetime,
    'title': title,
  };

  // Добавляем новый JSON в список
  jsonList.add(newJson);

  // Возвращаем обновленный список
  return jsonList;
}

String removePTags(String input) {
  return input.replaceAll(RegExp(r'<\/?p>'), '');
}

String yesorno(bool boool) {
  if (boool == true) {
    return "Да";
  } else {
    return "Нет";
  }
}

dynamic returnNull() {
  return null;
}

dynamic addImg(dynamic json) {
  return {...json, "img": null};
}

List<dynamic> jsonToList(dynamic jsonData) {
  return jsonData.toList();
}

String trimString(String input) {
  if (input.length <= 4) {
    return ''; // Если строка слишком короткая, возвращаем пустую строку
  }
  return input.substring(1, input.length - 3);
}

bool containsInt(
  List<int>? intList,
  int searchInt,
) {
  if (intList == null || intList.isEmpty) {
    return false;
  }
  return intList.contains(searchInt);
}

String getFileExtension(String url) {
  Uri uri = Uri.parse(url);
  String path = uri.path;

  if (path.contains('.')) {
    return path.split('.').last;
  }
  return '';
}

String findIndexByText(
  List<dynamic> jsonList,
  String searchText,
) {
// Используем indexWhere для поиска.
  // Он автоматически вернет -1, если ничего не найдено.
  int index = jsonList.indexWhere((item) {
    // Проверяем, что элемент является 'Map' (объектом JSON)
    // и у него есть ключ 'text'
    if (item is Map<String, dynamic> && item.containsKey('text')) {
      // Сравниваем значение по ключу 'text' с искомым текстом
      return item['text'] == searchText;
    }
    // Если это не Map или нет ключа 'text', пропускаем
    return false;
  });

  return "$index";
}

int doubletoint(double a) {
  return a.toInt();
}

dynamic fixFormPayload(dynamic payload) {
  // 1. Проверяем, есть ли вообще список 'form_result'
  if (payload['form_result'] == null || payload['form_result'] is! List) {
    return payload;
  }

  List<dynamic> formResult = payload['form_result'];

  // 2. Проходим по каждому элементу в списке
  for (var item in formResult) {
    if (item is! Map<String, dynamic>) {
      continue; // Пропускаем некорректные данные
    }

    Map<String, dynamic> itemMap = item;
    String? type = itemMap['type'];

    // 3. Используем switch для определения типа и применения нужной структуры 'result'
    switch (type) {
      // Типы с одинаковой структурой result
      case 'radio_defect':
      case 'measurement':
        final defaultResult = {
          "response": null,
          "comment": null,
          "image": null,
          "defect": null
        };
        itemMap['result'] = _createMergedResult(
          itemMap['result'] as Map<String, dynamic>?,
          defaultResult,
        );
        break;

      // Типы с другой структурой result
      case 'radio':
      case 'range':
        final defaultResult = {
          "response": null,
          "comment": null,
          "image": null
        };
        itemMap['result'] = _createMergedResult(
          itemMap['result'] as Map<String, dynamic>?,
          defaultResult,
        );
        break;

      // Простые типы
      case 'date':
      case 'short_text':
        final defaultResult = {"response": null};
        itemMap['result'] = _createMergedResult(
          itemMap['result'] as Map<String, dynamic>?,
          defaultResult,
        );
        break;

      // 4. ОСОБЫЙ СЛУЧАЙ: Чекбоксы
      // У них нет 'result' на верхнем уровне,
      // но он есть у каждого 'checkbox' внутри 'data.checkboxes'
      case 'checkbox':
        if (itemMap['data'] != null &&
            itemMap['data']['checkboxes'] != null &&
            itemMap['data']['checkboxes'] is List) {
          List<dynamic> checkboxes = itemMap['data']['checkboxes'];
          for (var checkbox in checkboxes) {
            if (checkbox is! Map<String, dynamic>) continue;
            Map<String, dynamic> checkboxMap = checkbox;

            final defaultCheckboxResult = {
              // В вашем "правильном" примере у неотмеченного стоит 'null'
              "response": null,
              "comment": null,
              "image": null
            };

            checkboxMap['result'] = _createMergedResult(
              checkboxMap['result'] as Map<String, dynamic>?,
              defaultCheckboxResult,
            );
          }
        }
        break;

      default:
        // Неизвестный тип, ничего не делаем
        break;
    }
  }

  // Возвращаем измененный (исправленный) объект payload
  payload['form_result'] = formResult;
  return payload;
}

/// Вспомогательная функция для "слияния" существующего result с эталонным.
/// Она берет эталонный 'defaultResult' и перезаписывает его значения
/// теми, что уже есть в 'existingResult' (если они есть).
Map<String, dynamic> _createMergedResult(
  Map<String, dynamic>? existingResult,
  Map<String, dynamic> defaultResult,
) {
  // 1. Начинаем с полной "эталонной" структуры (все поля 'null')
  Map<String, dynamic> finalResult = Map.from(defaultResult);

  // 2. Если 'existingResult' не пустой (т.е. мобильное приложение
  //    прислало хотя бы 'response'), мы "накладываем" его поверх
  //    эталонной структуры.
  if (existingResult != null) {
    // .addAll() перезапишет 'response' (с 'null' на 'normal')
    // и оставит 'comment', 'image' и т.д. как 'null'.
    finalResult.addAll(existingResult);
  }

  // 3. Возвращаем полный и корректный 'result'
  return finalResult;
}
