# Release Process

This project uses a lightweight GitHub-style developer release process.

## Versioning

The app version is defined in `pubspec.yaml`:

```yaml
version: 1.0.1+2
```

The part before `+` is the Android `versionName`. The number after `+` is the
Android `versionCode` and must increase for every installable update.

## Local Release Build

Run validation before creating a release APK:

```powershell
flutter analyze
flutter test
flutter build apk --release
```

The installable APK is generated at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

For a named local artifact:

```powershell
Copy-Item build\app\outputs\flutter-apk\app-release.apk .\dist\nextcloud-shopping-app-v1.0.1.apk
```

`dist/` is intentionally ignored by Git. Release APKs should be attached to
GitHub Releases instead of committed to the repository.

## GitHub Release

1. Update `pubspec.yaml`.
2. Update `CHANGELOG.md`.
3. Commit the changes.
4. Create and push a version tag:

```powershell
git tag v1.0.1
git push origin main v1.0.1
```

The GitHub Actions workflow builds the release APK and attaches it to the GitHub
Release for tags matching `v*`.

## Signing Status

The current release build is a developer/testing APK. The Android `release`
build type still uses the debug signing key so that local release builds are
installable without a private production keystore.

Before store publication, configure a real release keystore and keep signing
secrets out of Git.
