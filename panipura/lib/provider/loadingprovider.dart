
import 'package:panipura/core/hooks/hook.dart';

class LoadingProvider with ChangeNotifier {
  bool _isloading = false;
  bool get isLoading => _isloading;

  void toggelLoading() {
    _isloading = !_isloading;
    notifyListeners();
  }
}
