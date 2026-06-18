import 'package:flutter/widgets.dart';

class AppStrings {
  const AppStrings(this.locale);

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('de')];

  static const LocalizationsDelegate<AppStrings> delegate =
      _AppStringsDelegate();

  static AppStrings of(BuildContext context) {
    return Localizations.of<AppStrings>(context, AppStrings)!;
  }

  bool get _isGerman => locale.languageCode == 'de';

  String get appTitle => _isGerman ? 'Einkaufsliste' : 'Shopping list';

  String get lists => _isGerman ? 'Listen' : 'Lists';

  String get newList => _isGerman ? 'Neue Liste' : 'New list';

  String get renameList => _isGerman ? 'Liste umbenennen' : 'Rename list';

  String get listName => _isGerman ? 'Listenname' : 'List name';

  String get chooseFolder =>
      _isGerman ? 'Speicherordner wählen' : 'Choose storage folder';

  String get chooseFolderHint => _isGerman
      ? 'Legt fest, wo die JSON dieser Liste geteilt wird.'
      : 'Choose where this list JSON is shared.';

  String get localJson => _isGerman ? 'Lokale JSON' : 'Local JSON';

  String get linkedStorage =>
      _isGerman ? 'Verknüpfter Speicherort' : 'Linked storage';

  String get storage => _isGerman ? 'Speicher' : 'Storage';

  String get openItems => _isGerman ? 'Offen' : 'Open';

  String get lastUsed => _isGerman ? 'Zuletzt genutzt' : 'Last used';

  String get addItemHint =>
      _isGerman ? 'Artikel hinzufügen' : 'Add shopping item';

  String get openJson => _isGerman ? 'JSON öffnen' : 'Open JSON';

  String get reload => _isGerman ? 'Aus Datei neu laden' : 'Reload from file';

  String get reloadHint => _isGerman
      ? 'Ersetzt die lokale Liste durch den Stand der verknüpften JSON.'
      : 'Replace the local list with the linked JSON content.';

  String get unlink => _isGerman ? 'Speicherort trennen' : 'Unlink storage';

  String get unlinkHint => _isGerman
      ? 'Die Liste bleibt lokal erhalten, wird aber nicht mehr synchronisiert.'
      : 'The list stays local but is no longer synced.';

  String get syncNow => _isGerman ? 'Jetzt synchronisieren' : 'Sync now';

  String get syncNowHint => _isGerman
      ? 'Schreibt ausstehende Änderungen sofort in die verknüpfte JSON.'
      : 'Write pending changes to the linked JSON now.';

  String get synced => _isGerman ? 'Synchronisiert' : 'Synced';

  String get syncing => _isGerman ? 'Synchronisiere ...' : 'Syncing ...';

  String get syncPending =>
      _isGerman ? 'Änderungen warten auf Auto-Sync' : 'Changes pending sync';

  String get syncError => _isGerman ? 'Sync fehlgeschlagen' : 'Sync failed';

  String get autoSync => _isGerman ? 'Auto-Sync' : 'Auto sync';

  String get autoSyncHint => _isGerman
      ? 'Synchronisiert nach Änderungen automatisch nach einer kurzen Pause.'
      : 'Automatically sync after changes once editing pauses.';

  String get syncDelay => _isGerman ? 'Sync-Pause' : 'Sync delay';

  String syncDelayValue(int seconds) {
    return _isGerman
        ? '$seconds Sekunden nach der letzten Änderung'
        : '$seconds seconds after the last change';
  }

  String get settings => _isGerman ? 'Einstellungen' : 'Settings';

  String get language => _isGerman ? 'Sprache' : 'Language';

  String get systemLanguage => _isGerman ? 'Systemsprache' : 'System language';

  String get german => _isGerman ? 'Deutsch' : 'German';

  String get english => _isGerman ? 'Englisch' : 'English';

  String get noOpenItems =>
      _isGerman ? 'Alles erledigt' : 'Nothing left to buy';

  String get noLastUsedItems => _isGerman
      ? 'Noch keine zuletzt genutzten Artikel'
      : 'No recent items yet';

  String get editItem => _isGerman ? 'Artikel bearbeiten' : 'Edit item';

  String get itemName => _isGerman ? 'Name' : 'Name';

  String get amount => _isGerman ? 'Menge' : 'Amount';

  String get note => _isGerman ? 'Zusatzinfo' : 'Additional info';

  String get icon => _isGerman ? 'Icon' : 'Icon';

  String get iconSearchHint => _isGerman ? 'Icon suchen' : 'Search icons';

  String get save => _isGerman ? 'Speichern' : 'Save';

  String get cancel => _isGerman ? 'Abbrechen' : 'Cancel';

  String get delete => _isGerman ? 'Löschen' : 'Delete';

  String get linkedFile => _isGerman ? 'Verknüpfte Datei' : 'Linked file';

  String get localOnly => _isGerman ? 'Lokale Liste' : 'Local list';

  String get localOnlyHint => _isGerman
      ? 'Keine verknüpfte Datei. Änderungen bleiben auf diesem Gerät.'
      : 'No linked file. Changes stay on this device.';

  String get syncHint => _isGerman
      ? 'Änderungen werden lokal gespeichert und bei verknüpftem Speicherort synchronisiert.'
      : 'Changes are saved locally and synced when storage is linked.';

  String get unsupportedPicker => _isGerman
      ? 'Der System-Dateizugriff ist aktuell nur auf Android verfügbar.'
      : 'System document access is currently available on Android only.';

  String get chooseSuggestion =>
      _isGerman ? 'Aus zuletzt genutzten Artikeln' : 'From last used items';

  String get itemDetails => _isGerman ? 'Details' : 'Details';

  String get search => _isGerman ? 'Suche' : 'Search';

  String get searchHint => _isGerman ? 'Liste durchsuchen' : 'Search the list';

  String get noSearchResults =>
      _isGerman ? 'Keine Treffer' : 'No matching items';
}

class _AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const _AppStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppStrings.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<AppStrings> load(Locale locale) async {
    final languageCode = isSupported(locale) ? locale.languageCode : 'en';
    return AppStrings(Locale(languageCode));
  }

  @override
  bool shouldReload(_AppStringsDelegate old) => false;
}
