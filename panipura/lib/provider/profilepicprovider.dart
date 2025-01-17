import 'package:panipura/core/hooks/hook.dart';

class ProfilepicProvider extends ChangeNotifier {
  NetworkImage? _imageFile;

  void updateProfilepic(int? usrid, String? token) {
    if (_imageFile == null) {
      _imageFile = Labourdata().getImage(usrid, token);
      notifyListeners();
    } else {
      _imageFile!.evict();
      _imageFile = Labourdata().getImage(usrid, token);
      notifyListeners();
    }
  }

  NetworkImage? get imageFile => _imageFile;
}
