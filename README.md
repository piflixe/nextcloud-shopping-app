# nextcloud-shopping-app

A simple Flutter-based Android shopping list app that can work with local
shopping-list JSON files or sync one list per JSON file into a folder selected
through Android's system document picker. This includes Nextcloud, Google Drive,
Dropbox, and similar apps when they expose folders through Android's document
provider.

## Current Features

- Android Flutter app scaffold
- portrait-only app orientation
- light and dark theme via OS setting
- German and English language setting
- multiple named shopping lists
- one local JSON file per list in the app's private storage
- open and last-used item sections
- 3-column item grid
- tap item to move it between open and last-used
- long-press item to edit name, amount, note, and icon
- bottom input field with search-as-you-type suggestions from last-used items
- expanded built-in pictogram catalog with keyword-based icon assignment
- ad-hoc generated fallback icons with selectable variants for unmatched items
- Android system folder picker for linking the active list to a shared folder
- automatic shared JSON handling: if `<list name>.json` exists in the selected
  folder, it is loaded; otherwise the current local list is written there
- persistent Android document URI permission for writing changes back to the
  linked JSON file

## List Storage

Each list is stored as a separate JSON file. By default, lists are local only and
are written into the app's private Android data directory. The app keeps a small
manifest with list names, the active list, and optional linked folder metadata.

Use the list title in the app bar to switch lists, create a new list, or rename
the active list. Use the folder icon to choose a storage folder for the active
list. The linked JSON file uses the list name, for example:

```text
Groceries.json
```

When the selected folder already contains that file, the app loads it and uses it
as the current list. When the file does not exist, the app creates it from the
current local list.

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

- Icon handling currently uses Flutter Material pictograms plus deterministic
  generated fallback variants. Storing custom icon files next to the JSON file
  is not implemented yet.
- True AI image generation/regeneration is not implemented yet; it will require
  an AI service or local image-generation backend.
