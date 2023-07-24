class AppLocalizations {
  late Map<String, dynamic> _localizedStrings;
  static AppLocalizations instance = AppLocalizations();

  void load(Map<String, dynamic> jsonMap) {
    _localizedStrings = jsonMap;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}