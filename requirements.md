# Requirements

## General Requirements

The application shall be installable on current Android smartphones.

Flutter is the selected implementation framework. It is suitable for Android
development, beginner-friendly enough for this project, and works well with the
installed Android Studio and Flutter toolchain.

The application shall be open source under the GPL license. Software packages
with the same or similarly open licenses are preferred to preserve the open
source character of the app.

The app shall support multiple languages via user settings. German and English
are currently required.

The app shall provide dark and light themes according to the user's Android OS
setting.

The app is intended for current high-resolution smartphone screens.

Only upright/portrait orientation is required.

The app should be usable on a physical Android phone through USB debugging and
on an Android emulator during development.

## Core Purpose

The app shall provide a simple shared shopping list experience similar to Bring,
but without recipes, advertisements, tracking-heavy features, or unnecessary
complexity.

The app shall allow several users to share the same shopping list by sharing the
underlying JSON file through an existing file-sharing service such as Nextcloud,
Google Drive, Dropbox, or another Android document provider.

The app shall use Android's standard Storage Access Framework/document picker
instead of implementing provider-specific account login flows.

## List Storage and Synchronization

The app shall support multiple separate shopping lists.

Each shopping list shall be represented by one separate JSON file.

Every list shall have a user-editable list name.

The JSON file name shall be derived from the list name, for example
`Ottokar Shopping.json`.

By default, lists shall be local-only lists stored in the app's private Android
data directory.

The app shall keep local list metadata such as available lists, active list, and
optional linked storage information in a private app manifest.

For every list, the user shall be able to choose a storage folder from the
settings screen.

When a storage folder is selected, the app shall search that folder for the JSON
file matching the active list name.

If the matching JSON file already exists in the selected folder, the app shall
load it and use it as the new content of the active list.

If the matching JSON file does not exist in the selected folder, the app shall
create it there using the current local content of the active list.

After a list has been linked to a shared JSON file, changes shall be saved
locally and written back to that linked JSON file.

Local saving and shared-file syncing shall be separate operations. Item changes
shall be written to local app storage immediately.

For linked lists, the app shall provide auto sync after a configurable quiet
period following the last change.

The default auto-sync quiet period should be 60 seconds.

The user shall be able to enable or disable auto sync in settings.

The user shall be able to adjust the auto-sync delay in settings.

The app should attempt to flush pending sync changes when Android pauses the app,
for example when the user switches apps or the display turns off.

The app shall provide a manual "sync now" action for linked lists.

The app shall provide a "reload from file" action for linked lists, replacing
the local list content with the shared JSON content.

The app shall request and persist Android URI permissions where supported, so it
can continue writing to linked shared files after the initial selection.

The app shall handle Android document providers that cannot create a file
directly inside a selected folder. In that case, it may open Android's create
document flow with a suggested JSON file name and then resolve the created file
inside the selected folder.

The app shall tolerate Nextcloud-specific Storage Access Framework behavior,
including tree URIs that cannot be queried directly.

Renaming a linked list shall make the app use a JSON file matching the new list
name. Old shared JSON files shall not be deleted automatically.

## JSON List Format

The shared JSON file shall contain the actual shopping list items and display
information for those items.

The JSON file shall include:

- schema version;
- update timestamp;
- item ID;
- item name;
- amount;
- store name, persisted in the `note` field for compatibility with existing
  shared JSON files;
- icon key or icon reference;
- ordering information;
- item state.

The item state shall distinguish at least:

- `open`;
- `lastUsed`.

The app should keep the shared JSON schema simple enough to be readable and
repairable by hand if necessary.

## Shopping List UI

The main screen shall show the active list name in the app bar.

The main screen shall not reserve a full-width status row for storage status, so
more vertical space remains available for list items.

The main screen shall show only a compact online/offline/sync-state icon next to
the active list name.

Tapping the active list name shall open list management with at least:

- switch list;
- create new list;
- rename active list.

The app bar shall provide a search icon for full-text list search.

The folder/storage action shall be placed in the settings screen, not directly
on the main list screen.

The settings icon shall open a separate settings screen, not an overlay dialog.

The settings screen shall provide at least:

- storage status;
- choose storage folder;
- manual sync now;
- reload from linked file;
- unlink storage;
- auto-sync enabled/disabled setting;
- auto-sync delay setting;
- language selection.

The screen shall show open items first.

Within the open and last-used sections, items shall be grouped by the store
assigned to the item.

Items without a store shall be shown in a dedicated unnamed/default store
section.

Open items shall use a warm red color.

Items in the last-used section shall use a green or turquoise color.

Items shall be displayed in a grid with three items per row.

Item tiles shall be square so more items fit vertically.

Tile pictograms shall be large enough to fill the tile clearly.

Item text shall be large and readable.

Item text shall dynamically shrink where necessary so longer item names fit
inside the tile without overlapping other content.

Item text shall support wrapping where useful before shrinking too aggressively.

Tapping an open item shall move it to the last-used section.

Tapping an item in the last-used section shall move it back to the open section.

Long-pressing an item shall open a dialog for editing at least:

- item name;
- amount;
- store;
- icon.

The store field shall offer autocomplete or quick selection from stores already
used in the active list.

The user shall be able to move individual item tiles on the screen to change
the list order.

Reordering shall not rely on long-press because long-press is reserved for item
editing. A visible drag handle or similarly clear interaction shall be used.

Dropping an item into a different store section shall automatically update that
item's store field to the destination store.

Newly added open items should receive a sensible default order based on a common
supermarket route or product category order.

The bottom of the screen shall provide a text field for adding new items.

While typing, suggestions shall appear in a search-as-you-type manner using
items from the last-used section.

Selecting a suggestion shall reactivate that item.

The list shall be searchable/filterable via full-text search.

The full-text search should search at least item name, amount, store, and icon
key.

## Icons and Pictograms

For each item, the app shall assign a simple pictogram automatically where
possible.

The app shall include enough pictograms for common shopping-list items.

Milk, juice, water, oil, and similar liquids should use suitable bottle or carton
pictograms.

Rice, flour, sugar, cereal, and similar dry goods should use suitable package,
bag, grain, or pile pictograms.

Fruit and vegetables should use specific pictograms where possible rather than a
single generic plant pictogram. Examples include apple, banana, orange, lemon,
pear, grapes, strawberry, watermelon, carrot, cucumber, pepper, potato, onion,
broccoli, mushroom, garlic, corn, tomato, and lettuce.

The icon assignment shall avoid overly broad substring matches that produce
wrong icons, for example matching `Reis` as `Ei`.

The icon assignment shall handle common German inflections, plural forms, and
umlauts so examples such as `Äpfel`, `Tomaten`, `Möhren`, and `Zahnbürsten`
match their intended pictograms.

The user shall be able to choose a different icon in the edit dialog.

The manual icon picker in the edit dialog shall be searchable.

The manual icon picker search shall respect the selected app language where
possible, including German search terms for German UI settings.

The pictogram catalog shall include distinguishable icons for at least lemon,
pretzel sticks, feta, mozzarella, cream cheese, cola, mate, toothpaste, and
toothbrush.

If no catalog pictogram is found, the app shall provide generated fallback icon
variants in a consistent style.

Pictograms should be large within the square item tiles.

Pictograms should be simple, readable, and slightly playful. They should include
enough visual detail to distinguish common groceries without becoming visually
busy.

Future versions should support true AI-generated icons, regeneration, and user
selection from multiple generated options.

Future versions should support storing custom generated icon files next to the
shared JSON file and referencing them from the JSON.

## Development and Toolchain Requirements

The project shall be buildable with Flutter and Android Studio on Windows.

The development setup should include:

- Flutter SDK;
- Dart SDK as provided by Flutter;
- Android Studio;
- Android SDK platform tools;
- Git;
- a Flutter/Dart IDE extension for VS Code or Android Studio.

The app shall be testable with:

- `flutter analyze`;
- `flutter test`;
- `flutter build apk --debug`;
- `flutter build apk --release`;
- installation through `adb install -r` on a connected Android phone.

The app shall keep a documented toolchain setup in `toolchain_prerequisits.md`.

The app shall provide a lightweight developer release process suitable for
GitHub-hosted Android apps.

Developer releases shall include:

- an incremented `pubspec.yaml` version and Android version code;
- release notes in `CHANGELOG.md`;
- an installable release APK generated by `flutter build apk --release`;
- a documented release process;
- a GitHub Actions workflow that validates the app and publishes APK artifacts
  for version tags.

Release APKs shall not be committed directly to Git. They should be distributed
through GitHub Releases or local build output.

The current developer release may be signed with the debug key for sideloading.
A production keystore is required before store publication.

## Non-Goals for the Current Prototype

The app does not need provider-specific Nextcloud login screens.

The app does not need recipes, meal planning, advertisements, or product
recommendations.

The app does not need landscape layout support.

Conflict resolution between multiple simultaneous editors is not required for
the current prototype. A simple last-write-wins sync behavior is acceptable for
now.
