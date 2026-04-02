import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateCheckResult {
  const AppUpdateCheckResult({
    required this.mustUpdate,
    required this.storeUrl,
    required this.currentVersion,
    required this.minVersion,
    required this.forceUpdateEnabled,
  });

  final bool mustUpdate;
  final String? storeUrl;
  final String currentVersion;
  final String minVersion;
  final bool forceUpdateEnabled;
}

class AppUpdateChecker {
  static const _minVersionKey = 'min_app_version';
  static const _forceUpdateKey = 'force_update';
  static const _androidStoreUrlKey = 'android_store_url';
  static const _iosStoreUrlKey = 'ios_store_url';

  static Future<AppUpdateCheckResult> evaluate() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 15),
        minimumFetchInterval:
            kDebugMode ? Duration.zero : const Duration(hours: 1),
      ),
    );
    await remoteConfig.setDefaults(const {
      _minVersionKey: '0.0.0',
      _forceUpdateKey: false,
      _androidStoreUrlKey: '',
      _iosStoreUrlKey: '',
    });

    try {
      await remoteConfig.fetchAndActivate();
    } catch (_) {
      // Use cached/default values if fetch fails.
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;
    final minVersion = remoteConfig.getString(_minVersionKey).trim();
    final forceUpdateEnabled = remoteConfig.getBool(_forceUpdateKey);
    final storeUrl = _resolveStoreUrl(remoteConfig);
    final mustUpdate = forceUpdateEnabled &&
        _isVersionLower(currentVersion, minVersion) &&
        (storeUrl?.isNotEmpty ?? false);

    if (kDebugMode) {
      print(
        '[AppUpdateChecker] currentVersion=$currentVersion, '
        'minVersion=$minVersion, forceUpdateEnabled=$forceUpdateEnabled, '
        'storeUrl=$storeUrl, mustUpdate=$mustUpdate, '
        'lastFetchStatus=${remoteConfig.lastFetchStatus}, '
        'lastFetchTime=${remoteConfig.lastFetchTime}',
      );
    }

    return AppUpdateCheckResult(
      mustUpdate: mustUpdate,
      storeUrl: storeUrl,
      currentVersion: currentVersion,
      minVersion: minVersion,
      forceUpdateEnabled: forceUpdateEnabled,
    );
  }

  static Future<bool> canOpenStoreUrl(String? url) async {
    if (url == null || url.trim().isEmpty) {
      return false;
    }
    try {
      final directStoreUri = _buildDirectStoreUri(url);
      if (directStoreUri != null && await canLaunchUrl(directStoreUri)) {
        return true;
      }
      return await canLaunchUrl(Uri.parse(url));
    } catch (_) {
      return false;
    }
  }

  static Future<bool> openStoreUrl(String? url) async {
    if (url == null || url.trim().isEmpty) {
      return false;
    }
    try {
      final directStoreUri = _buildDirectStoreUri(url);
      if (directStoreUri != null && await canLaunchUrl(directStoreUri)) {
        return await launchUrl(
          directStoreUri,
          mode: LaunchMode.externalApplication,
        );
      }

      return await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }

  static String? _resolveStoreUrl(FirebaseRemoteConfig remoteConfig) {
    if (kIsWeb) {
      return null;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return remoteConfig.getString(_androidStoreUrlKey).trim();
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return remoteConfig.getString(_iosStoreUrlKey).trim();
    }
    return null;
  }

  static Uri? _buildDirectStoreUri(String url) {
    final parsedUrl = Uri.tryParse(url);
    if (parsedUrl == null || kIsWeb) {
      return null;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final packageId = parsedUrl.queryParameters['id'];
      if (packageId != null && packageId.isNotEmpty) {
        return Uri.parse('market://details?id=$packageId');
      }
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return parsedUrl;
    }

    return null;
  }

  static bool _isVersionLower(String current, String minimum) {
    final currentParts = _parseVersion(current);
    final minimumParts = _parseVersion(minimum);
    final length =
        currentParts.length > minimumParts.length ? currentParts.length : minimumParts.length;
    for (var i = 0; i < length; i++) {
      final currentPart = i < currentParts.length ? currentParts[i] : 0;
      final minimumPart = i < minimumParts.length ? minimumParts[i] : 0;
      if (currentPart < minimumPart) {
        return true;
      }
      if (currentPart > minimumPart) {
        return false;
      }
    }
    return false;
  }

  static List<int> _parseVersion(String version) {
    return version
        .split('.')
        .map((part) => int.tryParse(part.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0)
        .toList();
  }
}
