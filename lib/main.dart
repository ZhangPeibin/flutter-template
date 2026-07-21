import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/i18n/app_locale_controller.dart';
import 'core/providers/app_config_provider.dart';
import 'core/providers/key_value_storage_provider.dart';
import 'core/startup/app_install_guard.dart';
import 'core/startup/startup_logger.dart';
import 'core/storage/flutter_secure_storage_adapter.dart';
import 'core/storage/shared_preferences_key_value_storage.dart';
import 'i18n/strings.g.dart';

Future<void> main() async {
  StartupLogger.mark('main() entered');
  WidgetsFlutterBinding.ensureInitialized();
  StartupLogger.mark('WidgetsFlutterBinding initialized');

  final config = AppConfig.fromEnvironment();
  final prefs = await SharedPreferences.getInstance();
  final keyValueStorage = SharedPreferencesKeyValueStorage(prefs);
  final savedLocale = await loadSavedAppLocale(keyValueStorage);
  await LocaleSettings.setLocale(savedLocale);
  StartupLogger.mark('Locale initialized: ${savedLocale.languageCode}');

  // iOS Keychain can survive app deletion. Clear secure storage on a fresh
  // install (no SharedPreferences marker) so users are not still "signed in".
  // Skip on Android to avoid blocking the first frame on Keystore I/O.
  final secureStorage = FlutterSecureStorageAdapter();
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    StartupLogger.mark('AppInstallGuard start');
    await AppInstallGuard(
      keyValueStorage: keyValueStorage,
      secureStorage: secureStorage,
    ).ensureCurrentInstall();
    StartupLogger.mark('AppInstallGuard finished');
  } else {
    StartupLogger.mark('AppInstallGuard skipped on $defaultTargetPlatform');
  }

  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(config),
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const TemplateApp(),
      ),
    ),
  );
  StartupLogger.mark('runApp() returned');
}
