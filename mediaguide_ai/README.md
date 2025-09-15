# MediGuide AI – Your Personal AI Health Coach

This is a Flutter skeleton app implementing the core UX and extension points for:
- AI-powered symptom checker and health coach
- Medicine scanner + explainer (image OCR → AI explanation)
- Smartwatch integrations (HealthKit, Google Fit/Samsung Health, Zepp)
- Daily dashboards, weekly reports, and charts

The code is structured for quick iteration with Riverpod and service stubs so you can plug in real APIs later.

## Getting Started

1) Install Flutter and set up iOS/Android tooling.
2) Create platform folders (since this repo only includes the `lib/` skeleton):

```
cd mediaguide_ai
flutter create .
```

3) Fetch packages and run:

```
flutter pub get
flutter run
```

## Project Layout

- `lib/main.dart` – App entry using `ProviderScope`.
- `lib/src/app.dart` – MaterialApp theme + root navigation.
- `lib/src/navigation/root_nav.dart` – Bottom navigation with 5 tabs.
- `lib/src/screens/` – Feature screens:
  - `dashboard_screen.dart` – Vitals + mini chart.
  - `symptom_checker_screen.dart` – Text-based health advisor.
  - `medicine_scanner_screen.dart` – Pick image → OCR → explain.
  - `coach_screen.dart` – Chat-like wellness coach.
  - `reports_screen.dart` – Weekly summaries list.
- `lib/src/models/health_models.dart` – `DaySummary` model.
- `lib/src/state/health_providers.dart` – Riverpod providers + dummy data.
- `lib/src/services/` – API/service stubs:
  - `health_service.dart` – Abstract contract; replace dummy impl with real integrations.
  - `ai_service.dart` – Plug your LLM backend here.
  - `ocr_service.dart` – Replace with ML Kit or server-side OCR.

## Roadmap to Production

- AI
  - Move LLM calls to your backend for key security and PHI handling.
  - Add conversation memory and citations. Log prompts safely.

- OCR
  - Integrate Google ML Kit Text Recognition or a server OCR (Tesseract, Vision API).
  - Preprocess images (crop, contrast) for better extraction.

- Health Data Integrations
  - iOS: HealthKit (heart rate, steps, sleep). Add entitlements and permissions.
  - Android: Google Fit and/or Samsung Health SDK. Handle OAuth/consents.
  - Amazfit: Zepp OS/Zepp Health APIs where available.
  - Model a `HealthService` per platform and use conditional imports.

- Privacy & Compliance
  - Store only minimal health data; encrypt at-rest and in-transit.
  - Provide clear disclaimers; not a substitute for professional care.
  - Add account + data deletion flows, audit logging, consent screens.

- UX
  - Replace placeholder charts with richer views.
  - Add reminders, goals, and notifications (hydration, meds, activity).

## Environment & Secrets

Never embed API keys in the app. Use environment-configured backend endpoints.
For local dev, you can inject a base URL via `--dart-define` and read it in `AIService`.

```
flutter run --dart-define=API_BASE_URL=https://your-backend
```

## Notes

This skeleton compiles without native integrations. When you add HealthKit/Google Fit/Zepp or ML Kit, follow their platform setup guides and test each permission path. Charts and data are currently mocked via `DummyHealthService`.
