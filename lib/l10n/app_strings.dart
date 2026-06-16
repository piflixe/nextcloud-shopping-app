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

  String get openItems => _isGerman ? 'Offen' : 'Open';

  String get lastUsed => _isGerman ? 'Zuletzt genutzt' : 'Last used';

  String get addItemHint =>
      _isGerman ? 'Artikel hinzufügen' : 'Add shopping item';

  String get openJson => _isGerman ? 'JSON öffnen' : 'Open JSON';

  String get reload => _isGerman ? 'Neu laden' : 'Reload';

  String get unlink => _isGerman ? 'Trennen' : 'Unlink';

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

  String get save => _isGerman ? 'Speichern' : 'Save';

  String get cancel => _isGerman ? 'Abbrechen' : 'Cancel';

  String get delete => _isGerman ? 'Löschen' : 'Delete';

  String get linkedFile => _isGerman ? 'Verknüpfte Datei' : 'Linked file';

  String get localOnly =>
      _isGerman ? 'Lokale Liste, keine Datei verknüpft' : 'Local list only';

  String get syncHint => _isGerman
      ? 'Änderungen werden lokal gespeichert und bei verknüpfter Datei synchronisiert.'
      : 'Changes are saved locally and synced when a document is linked.';

  String get unsupportedPicker => _isGerman
      ? 'Der System-Dateizugriff ist aktuell nur auf Android verfügbar.'
      : 'System document access is currently available on Android only.';

  String get chooseSuggestion =>
      _isGerman ? 'Aus zuletzt genutzten Artikeln' : 'From last used items';

  String get itemDetails => _isGerman ? 'Details' : 'Details';
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
