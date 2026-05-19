enum AppEnvironment {
  dev,
  staging,
  prod;

  static AppEnvironment parse(String value) {
    return switch (value) {
      'staging' => AppEnvironment.staging,
      'prod' => AppEnvironment.prod,
      _ => AppEnvironment.dev,
    };
  }
}

class AppConfig {
  const AppConfig({
    required this.appName,
    required this.environment,
    required this.apiBaseUrl,
  });

  AppConfig.fromEnvironment()
    : this(
        appName: const String.fromEnvironment(
          'APP_NAME',
          defaultValue: 'Flutter Template',
        ),
        environment: AppEnvironment.parse(
          const String.fromEnvironment('APP_ENV', defaultValue: 'dev'),
        ),
        apiBaseUrl: const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.example.com',
        ),
      );

  final String appName;
  final AppEnvironment environment;
  final String apiBaseUrl;

  bool get isProduction => environment == AppEnvironment.prod;
}
