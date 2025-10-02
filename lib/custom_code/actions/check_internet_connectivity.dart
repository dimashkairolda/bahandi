// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkInternetConnectivity() async {
  ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();

  // Проверяем, есть ли подключение к интернету
  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
