# MediGuide AI – Personal AI Health Coach (Flutter)

MediGuide AI is a Flutter application scaffold that demonstrates a cohesive UX for:
- AI-powered symptom checking and wellness coaching
- Medication label/photo OCR with AI explanations
- Health data dashboard and weekly summaries (mocked), ready for HealthKit/Google Fit/Samsung Health/Zepp integrations

It uses Riverpod for state, simple service contracts for integrations, and clean screen/navigation patterns so you can plug in real backends quickly.

## Quick Start

Prerequisites:
- Flutter 3.10+ with iOS/Android toolchains set up
- Xcode (iOS/macOS), Android Studio + SDKs (Android), or Desktop/Web targets as needed

Install and run:
```
flutter pub get
flutter run
```

Platform tips:
- iOS: open `ios/Runner.xcworkspace` in Xcode for signing and device deployment.
- Android: ensure an emulator/device is connected; `flutter doctor` is clean.
- Web: `flutter run -d chrome` (ensure `web/` is present; this repo includes it).
- Desktop: enable platform with `flutter config --enable-<platform>-desktop` then run.

## Features
- Symptom checker with AI responses (stubbed; replace with your backend LLM)
- Medication scanner: pick/capture an image → OCR (stubbed) → AI explanation
- Dashboard with vitals and a small heart-rate chart (mock data)
- Reports list with weekly summaries (mock data)
- Deep link handling for routes like `mediaguide://scan` (platform config required)

## Project Structure
- `lib/main.dart` – App entry with Riverpod `ProviderScope`.
- `lib/src/app.dart` – App theme, routes, and deep link bootstrap.
- `lib/src/navigation/root_nav.dart` – Bottom navigation across 5 tabs.
- `lib/src/screens/dashboard_screen.dart` – Vitals + mini `fl_chart` line chart.
- `lib/src/screens/symptom_checker_screen.dart` – Text prompt → AI advice.
- `lib/src/screens/medicine_scanner_screen.dart` – `image_picker` + OCR stub + AI explanation.
- `lib/src/screens/coach_screen.dart` – Lightweight coach chat with running history.
- `lib/src/screens/reports_screen.dart` – Weekly summaries list.
- `lib/src/models/health_models.dart` – `DaySummary` model.
- `lib/src/state/health_providers.dart` – Riverpod providers + `DummyHealthService` mock data.
- `lib/src/services/health_service.dart` – Contract for health data integrations.
- `lib/src/services/ai_service.dart` – AI calls placeholder; wire your backend here.
- `lib/src/services/ocr_service.dart` – OCR placeholder; replace with ML Kit/server OCR.
- `lib/src/services/deep_link_service.dart` – Deep link parsing and navigation.

Key dependencies (see `pubspec.yaml`): `flutter_riverpod`, `image_picker`, `fl_chart`, `uni_links`, `shared_preferences`, `http`, `intl`, `url_launcher`.

## Configuration

Environment values:
- Inject your backend base URL at runtime, e.g.:
  `flutter run --dart-define=API_BASE_URL=https://your-backend`
- Read the value inside your `AIService` implementation and forward calls via your API. Avoid calling LLMs directly from the client.

Deep links:
- The code understands custom scheme paths like `mediaguide://scan` → `/scan`.
- Configure platforms to register the custom scheme:
  - Android: add an `intent-filter` in `android/app/src/main/AndroidManifest.xml` for your scheme/host.
  - iOS: add a URL Type in `ios/Runner/Info.plist` with your scheme (e.g., `mediaguide`).

Permissions:
- Camera/Photos for the scanner screen.
  - Android: add `<uses-permission android:name="android.permission.CAMERA" />` and storage/photo permissions per SDK level.
  - iOS: add `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` in `ios/Runner/Info.plist`.

## Development
- Format/lint: `flutter format .` and `dart analyze` (uses `flutter_lints`).
- Run tests: `flutter test` (sample widget test included).
- Hot reload: `flutter run` and save changes.

## Production Roadmap
- AI
  - Proxy LLM calls through your backend; secure secrets and handle PHI.
  - Add conversation memory, citations, safety filters, and logging.
- OCR
  - Integrate Google ML Kit Text Recognition or a server OCR (Vision API/Tesseract).
  - Add basic preprocessing (crop, contrast) for better accuracy.
- Health Data
  - iOS: HealthKit (heart rate, steps, sleep). Add entitlements/permissions.
  - Android: Google Fit and/or Samsung Health SDK; handle OAuth and consents.
  - Consider platform-specific `HealthService` implementations via conditional imports.
- Privacy & Compliance
  - Minimize data, encrypt at-rest/in-transit, clear disclaimers.
  - Add account/data deletion, audit logs, and consent flows.
- UX
  - Replace placeholder charts and mocks; add reminders, goals, notifications.

## Disclaimer
MediGuide AI is not a medical device and does not provide medical advice. For emergencies or urgent concerns, contact a healthcare professional immediately.
