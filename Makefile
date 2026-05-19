.PHONY: run-dev run-staging run-prod analyze test clean get

run-dev:
	flutter run --dart-define-from-file=config/dev.json

run-staging:
	flutter run --dart-define-from-file=config/staging.json

run-prod:
	flutter run --release --dart-define-from-file=config/prod.json

analyze:
	flutter analyze

test:
	flutter test

clean:
	flutter clean

get:
	flutter pub get
