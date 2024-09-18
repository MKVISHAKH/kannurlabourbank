import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('ml');
  void getlocale() async {
    final value = await Sharedata.instance.getlocale();
    final loc = value;
    if (loc == 'ml') {
      _locale = Locale('ml');
      notifyListeners();
    } else {
      _locale = Locale('en');
      notifyListeners();
    }
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
   // clearLocale();
   
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('');
    notifyListeners();
  }
}
