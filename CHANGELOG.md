# Changelog

## 1.1.0 - 2026-06-22

Feature release focused on better item organization, icon matching, and manual
ordering.

### Added

- Store field in the item edit dialog, replacing the previous generic
  additional-info label.
- Store autocomplete based on stores already used in the active list.
- Store-based list sections for open and last-used items.
- Drag handle on item tiles for quick manual reordering without interfering
  with long-press editing.
- Automatic store reassignment when an item is dragged into another store
  section.
- Supermarket-style default ordering for newly added open items.
- Localized icon picker search terms for German and English.
- More flexible icon assignment for common German inflections and plurals, for
  example `Äpfel`, `Tomaten`, `Möhren`, and `Zahnbürsten`.
- New drawn pictograms for cola, mate, feta, mozzarella, cream cheese,
  pretzel sticks, toothpaste, and toothbrushes.

### Changed

- Improved the lemon pictogram so it is easier to recognize.
- Increased tile pictogram size while keeping tile and text sizes unchanged.
- Switched icon matching to a scored lookup so precise matches win over broad
  substring matches.
- The shared JSON key `note` is now used by the app as the store field for
  compatibility with existing lists.

## 1.0.1 - 2026-06-19

Developer APK release for shared JSON shopping lists.

### Added

- Multiple named shopping lists with one JSON file per list.
- Folder-based linking through Android's Storage Access Framework.
- Nextcloud-compatible fallback behavior for shared-folder creation.
- Dedicated settings screen for storage, language, and sync configuration.
- Debounced auto sync after a configurable quiet period.
- Manual sync, reload from linked file, and unlink actions.
- App lifecycle flush for pending sync changes when the app is paused.
- Full-text list search from the app bar.
- Searchable manual icon picker in the item edit dialog.
- Expanded app-native pictogram catalog and generated fallback variants.

### Changed

- Removed the full-width storage status row from the list screen.
- Moved folder/storage actions into settings.
- Replaced the status row with a compact sync-state icon next to the list name.
- Increased item pictogram and tile text sizes.
- Improved tile text wrapping and fitting for longer item names.

### Notes

- This is a developer/testing release APK. It is installable directly on Android
  devices that allow APK sideloading.
- The Android release build currently uses the debug signing key. A production
  keystore should be configured before publishing to stores.
