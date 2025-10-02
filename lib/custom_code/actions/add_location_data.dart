// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';

Future<List<double>> addLocationData() async {
  // Проверяем, если список равен null, инициализируем его пустым списком

  try {
    // Запрашиваем разрешение
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Служба геолокации отключена.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Геолокация не разрешена пользователем.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Геолокация заблокирована. Разрешение недоступно.');
    }

    // Получаем текущие координаты
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Генерируем datetime

    // Создаем новый JSON с координатами

    // Добавляем новый JSON в список

    return [position.latitude, position.longitude];
  } catch (e) {
    print('Ошибка: $e');
    return []; // Возвращаем текущий список, если произошла ошибка
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
