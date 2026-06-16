# Toolchain Prerequisites

This project is intended to be developed as a Flutter-based Android app.
The following tools should be installed before implementation starts.

## Required Tools

- **Git**
  - Used for version control.
  - Verify with:
    ```powershell
    git --version
    ```

- **Flutter SDK**
  - Provides the Flutter framework, Dart SDK, command-line tools, build tools, and test runner.
  - Can be installed on Windows via Chocolatey:
    ```powershell
    choco install flutter
    ```
  - Verify with:
    ```powershell
    flutter --version
    ```

- **Android Studio**
  - Provides the Android SDK, Android emulator, device manager, platform tools, and build tooling needed for Android apps.
  - During setup, install at least:
    - Android SDK
    - Android SDK Platform
    - Android SDK Platform-Tools
    - Android SDK Build-Tools
    - Android Emulator

- **VS Code or Android Studio**
  - Either editor can be used for development.
  - VS Code is lightweight and beginner-friendly for Flutter projects.
  - Android Studio is useful for Android SDK management, emulator setup, and native Android debugging.

## Recommended Editor Extensions

For VS Code:

- **Flutter**
  - Identifier: `dart-code.flutter`
  - Provides Flutter project support, debugging, widget tools, and command integration.

- **Dart**
  - Identifier: `dart-code.dart`
  - Provides Dart language support. It is usually installed automatically with the Flutter extension.

- **Error Lens** optional
  - Shows warnings and errors directly in the editor.

For Android Studio:

- **Flutter plugin**
- **Dart plugin**
- **Error Lens** optional, if available in the installed setup

## Recommended Test Environment

- **Android Emulator**
  - Useful for fast development and UI testing.
  - Can be created and started from Android Studio Device Manager.

- **Physical Android smartphone**
  - Strongly recommended for testing:
    - touch behavior
    - system file picker behavior
    - Nextcloud app integration
    - real screen sizes and high-resolution displays

- **Nextcloud app on the test device**
  - Needed to test shared shopping-list files through the Android system file picker or document provider.

- **Test Nextcloud account or test folder**
  - Use a dedicated test list file and icon folder to avoid damaging real shopping-list data during development.

## Health Check

After installing Flutter and Android Studio, run:

```powershell
flutter doctor
```

This checks whether Flutter can find the Android SDK, Android toolchain, connected devices, and editor integrations.
Any reported issues should be fixed before starting implementation.

Useful follow-up checks:

```powershell
flutter doctor -v
flutter devices
```

## Notes For This Project

- The first target platform is Android.
- Only portrait orientation is required.
- The app should support light and dark mode according to the operating system setting.
- Multi-language support should be planned from the beginning.
- Nextcloud integration will likely rely on Android file/document access first, with WebDAV as a possible later option.
- Because the project is GPL licensed, dependencies should be checked for license compatibility before they are added.
