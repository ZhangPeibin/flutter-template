.PHONY: bootstrap run-dev run-staging run-prod analyze test clean get hooks

bootstrap:
	@if [ ! -f config/prod.json ]; then \
		cp config/prod.example.json config/prod.json; \
		echo "Created config/prod.json from config/prod.example.json"; \
	else \
		echo "config/prod.json already exists, skipping"; \
	fi

run-dev:
	flutter run --dart-define-from-file=config/dev.json

run-staging:
	flutter run --dart-define-from-file=config/staging.json

run-prod: bootstrap
	flutter run --release --dart-define-from-file=config/prod.json

analyze:
	flutter analyze

test:
	flutter test

clean:
	flutter clean

get:
	flutter pub get

hooks:
	lefthook install
