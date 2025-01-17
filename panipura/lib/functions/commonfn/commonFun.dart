import 'package:panipura/core/hooks/hook.dart';

class CommonFun {
  CommonFun._internal();
  static CommonFun instance = CommonFun._internal();
  CommonFun factory() {
    return instance;
  }

  Future showApierror(BuildContext? context, String? msg) async {
    //print('hi');

    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 15.0);
  }
}
