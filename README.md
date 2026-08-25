# GetDockPay

A Flutter application for GetDockPay LLC.

## Prerequisites

Install Flutter by following the official guide: https://docs.flutter.dev/get-started/install

Verify your installation:

```bash
flutter doctor
```

Ensure all checks pass (especially Xcode/Android Studio and connected devices).

## Environment Variables

Create a `.env` file in the project root (use `.env.example` as a template):

| Variable | Description |
|---|---|
| `REVENUECAT_API_KEY_IOS` | RevenueCat public API key for iOS |
| `REVENUECAT_API_KEY_ANDROID` | RevenueCat public API key for Android |
| `REVENUECAT_API_KEY_TEST` | RevenueCat test API key |
| `SERVER_BASE_URL` | Production server base URL |
| `SERVER_BASE_URL_DEV` | Development server base URL |

The app will fail to start if any required variable is missing.

## Run the App

```bash
flutter pub get
```

**iOS:**

```bash
flutter run -d <ios-device-id>
```

**Android:**

```bash
flutter run -d <android-device-id>
```

List available devices with `flutter devices`.

## Build a Release

**iOS:**

```bash
flutter build ios --release
```

Then archive and upload via Xcode.

**Android:**

```bash
flutter build apk --release
```

The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.
