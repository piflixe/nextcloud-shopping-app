# nextcloud-shopping-app

A Flutter-based Android shopping list app for simple shared lists. The app keeps
one JSON file per shopping list and can link each list to a folder exposed
through Android's system document picker, for example by Nextcloud, Google
Drive, Dropbox, or another Android document provider.

The app is currently built and tested as an Android app. The main branch is
`main`.

## Current Features

- Flutter Android app with portrait-only orientation.
- German and English UI with language selection in settings.
- Light and dark theme following the Android system setting.
- Multiple named shopping lists.
- One local JSON file per list in the app's private Android storage.
- Optional shared storage folder per list through Android's Storage Access
  Framework.
- Automatic shared JSON handling:
  - if `<list name>.json` exists in the selected folder, it is loaded and used
    as the active list;
  - if it does not exist, the current local list is written into that folder.
- Persistent Android URI permissions for later writes to the linked JSON file.
- Nextcloud-compatible fallback for providers that do not support direct file
  creation through `DocumentsContract.createDocument`.
- Open and last-used item sections.
- Three square item tiles per row.
- Warm red tiles for open items and green/turquoise tiles for last-used items.
- Tap an item to move it between open and last-used.
- Long-press an item to edit name, amount, note, and icon.
- Bottom input field for adding items.
- Search-as-you-type suggestions from the last-used section.
- Expanded built-in pictogram catalog with keyword-based icon assignment.
- Larger tile pictograms and dynamic text fitting for longer item names.
- Custom drawn vector pictograms for common groceries such as milk, juice, rice,
  flour, bread, fruit, and vegetables.
- Deterministic generated fallback icons with selectable variants for unmatched
  items.

## App Workflow

Use the list title in the app bar to:

- switch between lists;
- create a new list;
- rename the active list.

Use the folder icon in the app bar to choose the storage folder for the active
list. This is the intended setup for shared folders in Nextcloud, Google Drive,
Dropbox, or similar apps.

By default, lists are local only. The status strip below the app bar shows the
local JSON file name until a shared folder has been linked. After linking, it
shows the linked storage location.

## Shared Folder Behavior

Each list is stored as a separate JSON file. The file name is derived from the
list name:

```text
Ottokar Shopping.json
```

When a shared folder is selected:

1. The app looks for a JSON file with the active list name.
2. If the file exists, the app reads it and replaces the local copy of that
   list with the shared content.
3. If the file does not exist, the app writes the current local list into the
   selected folder.
4. Later item changes are saved locally and written back to the linked JSON.

When using Nextcloud, Android may show an additional "create document" flow if
the Nextcloud document provider refuses direct file creation. Confirm the
suggested file name in the same folder. The app then searches the selected
folder again and stores the resulting document URI.

Renaming a linked list creates or switches to the JSON file matching the new
list name. Old shared JSON files are not deleted automatically.

## JSON Schema

The app writes each list in this shape:

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

The app also keeps a private local manifest with list names, the active list,
local file names, and optional linked-folder metadata. That manifest is not part
of the shared JSON list format.

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

Install the debug APK on a connected Android phone:

```powershell
adb install -r build\app\outputs\flutter-apk\app-debug.apk
```

If `adb` is not in `PATH`, use the Android SDK path directly:

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" install -r build\app\outputs\flutter-apk\app-debug.apk
```

## Current Validation

The current implementation has been checked with:

- `flutter analyze`
- `flutter test`
- `flutter build apk --debug`
- installation on a Moto G84 5G through USB debugging

## Known Open Points

- True AI image generation/regeneration is not implemented yet; it will require
  an AI service or local image-generation backend.
- Custom icon files are not stored next to the shared JSON yet. Current custom
  pictograms are app-native vector drawings, plus deterministic generated
  fallback variants.
- Conflict handling is simple last-write-wins behavior. There is no merge UI for
  simultaneous edits from multiple users yet.
