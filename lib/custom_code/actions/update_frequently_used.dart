// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> updateFrequentlyUsed(EquipmentStruct selectedEquipment) async {
  // 1. Получаем текущий список
  List<EquipmentStruct> quickList =
      FFAppState().frequentlyUsedEquipment.toList();

  // 2. Удаляем этот элемент, если он уже есть (чтобы переместить его наверх)
  quickList.removeWhere((item) => item.id == selectedEquipment.id);

  // 3. Добавляем новый элемент в начало списка
  quickList.insert(0, selectedEquipment);

  // 4. Ограничиваем список, например, 5-ю последними элементами
  int maxItems = 5;
  if (quickList.length > maxItems) {
    quickList = quickList.sublist(0, maxItems);
  }

  // 5. Сохраняем обновленный список в AppState
  FFAppState().frequentlyUsedEquipment = quickList;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
