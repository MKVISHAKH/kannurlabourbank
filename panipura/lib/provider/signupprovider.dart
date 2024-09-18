import 'package:panipura/core/hooks/hook.dart';

class SignupProvider extends ChangeNotifier {
  bool _isAccepted = false;
  bool get isAccepted => _isAccepted;
  void setAccepted(bool value) {
    _isAccepted = value;
    notifyListeners();
  }

  void reset() {
    _isAccepted = false;
    notifyListeners();
  }
}
