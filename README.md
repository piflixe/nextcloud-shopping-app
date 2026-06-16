# nextcloud-shopping-app

A simple Flutter-based Android shopping list app that can work with a shared
JSON file selected through Android's system document picker, including Nextcloud
when the Nextcloud app exposes files through the Android document provider.

## Current Features

- Android Flutter app scaffold
- portrait-only app orientation
- light and dark theme via OS setting
- German and English language setting
- local shopping list persistence
- open and last-used item sections
- 3-column item grid
- tap item to move it between open and last-used
- long-press item to edit name, amount, note, and icon
- bottom input field with search-as-you-type suggestions from last-used items
- Android system document picker for opening a shared JSON list
- persistent Android document URI permission for writing changes back to the
  selected JSON file

## JSON Schema

The app writes the list in this shape:

```json
{
  "schemaVersion": 1,
  "updatedAt": "2026-06-16T20:00:00.000Z",
  "items": [
    {
      "id": "milk",
      "name": "Milk",
      "amount": "1 l",
      "note": "Organic",
      "icon": "milk",
      "order": 0,
      "state": "open"
    }
  ]
}
```

`state` is either `open` or `lastUsed`.

## Development

Run the static analyzer:

```powershell
flutter analyze
```

Run tests:

```powershell
flutter test
```

Build a debug APK:

```powershell
flutter build apk --debug
```

The debug APK is written to:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Known Open Points

- Icon handling currently uses Flutter Material pictograms and a keyword-based
  suggestion catalog. Storing custom icon files next to the JSON file is not
  implemented yet.
- AI icon generation/regeneration is not implemented yet.
- The Android document bridge currently opens and writes an existing JSON file.
  Creating a new shared JSON file from inside the app can be added later.
