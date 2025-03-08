import 'package:panipura/core/hooks/hook.dart';

class LoadingProvider with ChangeNotifier {
  bool isloading = false;
  bool get isLoading => isloading;

  void toggleLoading() {
    isloading = !isloading;
    notifyListeners();
  }

  void reset() {
    isloading = false;
    notifyListeners();
  }
}
