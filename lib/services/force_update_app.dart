import 'package:Etry/services/app_update_checker.dart';
import 'package:flutter/material.dart';

class ForceUpdateApp extends StatelessWidget {
  const ForceUpdateApp({
    super.key,
    required this.storeUrl,
  });

  final String? storeUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2151F5)),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.system_update_rounded,
                    size: 72.0,
                    color: const Color(0xFF2151F5),
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    'Доступна новая версия приложения',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Для продолжения работы обновите приложение до последней версии.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await AppUpdateChecker.openStoreUrl(storeUrl);
                      },
                      child: const Text('Обновить'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
