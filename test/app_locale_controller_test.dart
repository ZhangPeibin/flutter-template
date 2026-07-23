import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/i18n/app_locale_controller.dart';
import 'package:flutter_template/core/providers/key_value_storage_provider.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('persists locale changes to key-value storage', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    await LocaleSettings.setLocale(AppLocale.en);
    await container.read(appLocaleControllerProvider.future);

    await container
        .read(appLocaleControllerProvider.notifier)
        .setLocale(AppLocale.zh);

    expect(prefs.getString(appLocaleStorageKey), AppLocale.zh.languageCode);
    expect(LocaleSettings.currentLocale, AppLocale.zh);
  });
}
