import 'package:panipura/core/hooks/hook.dart';

class FrgtpswrdProvider extends ChangeNotifier {
  TextEditingController pswrdController = TextEditingController();
  TextEditingController cnfrmController = TextEditingController();

  TextEditingController get pswordController => pswrdController;
  TextEditingController get cnformController => cnfrmController;

  bool _isVisible = true;
  bool get isVisible => _isVisible;
  void setVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void initialize(BuildContext context) {
    pswrdController.addListener(() {
      if (pswrdController.text.isNotEmpty) {
        if (pswrdController.text.contains(' ')) {
          showSnackBar(context, text: "Remove Space from New password field");
        }
      }
    });
    cnfrmController.addListener(() {
      if (cnfrmController.text.isNotEmpty) {
        if (cnfrmController.text.contains(' ')) {
          showSnackBar(context,
              text: "Remove Space from confirm password field");
        }
      }
    });
  }

  void reset() {
    pswrdController.clear();
    cnfrmController.clear();
    notifyListeners();
  }
}
