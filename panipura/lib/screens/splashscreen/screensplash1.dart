import 'dart:io';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/widgets/background/backgroundimage.dart';
import 'package:sqflite/sqflite.dart';
import '../../core/hooks/hook.dart';
import 'dart:developer';
//import '../widgets/backgroundimage.dart';
//import '../widgets/stylefamily.dart';

class ScreensplashOne extends StatefulWidget {
  const ScreensplashOne({Key? key}) : super(key: key);

  @override
  State<ScreensplashOne> createState() => _ScreensplashOneState();
}

class _ScreensplashOneState extends State<ScreensplashOne> {
  // @override
  // void initState() {
  //   gotoLogin();
  //   super.initState();
  // }
  String dbname = '';
  @override
  void initState() {
    // checkUserLoggedIn();
    dwnlddatabase();
    // getdistrict();
    // geteducation();
    // getlocalbdytype();
    // getgender();
    // getlocalbdy();
    // getcategory();
    //gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    return Stack(
      key: _scaffoldKey,
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 350),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          backgroundColor: Colors.white,
                          strokeWidth: 4.0,
                        ),
                      ),
                      //Text("Loading")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().splashScreen3);
  }

  Future<void> dwnlddatabase() async {
    dbname = 'masters.db';
    try {
      final file = await Labourdata().dwonloaddb(dbname);
      /***************language****************/

      final value = await Sharedata.instance.getlocale();
      final loc = value;
      String locale = ' ';

      if (loc.isEmpty) {
        locale = 'ml';
      } else {
        locale = loc;
      }

      await Sharedata.instance.setlocale(locale);
      final provider = Provider.of<LocaleProvider>(_scaffoldKey.currentContext!,
          listen: false);
      provider.getlocale();

      /*****************************************/

      if (file == null) {
        showSnackBar(_scaffoldKey.currentContext!,
            text: 'Something Went Wrong');
        Navigator.pushReplacement(
            _scaffoldKey.currentContext!, Approutes().errorscreen);
      } else if (file.statusCode! > 200) {
        showSnackBar(_scaffoldKey.currentContext!,
            text: 'Something Went Wrong');
        Navigator.pushReplacement(
            _scaffoldKey.currentContext!, Approutes().errorscreen);
      } else {
        gotoLogin();
        //Navigator.pushReplacement(_scaffoldKey.currentContext!,Approutes().errorscreen);
        final appStorage = await getDatabasesPath();
        final fileval = File('$appStorage/$dbname');
        final raf = fileval.openSync(mode: FileMode.write);
        raf.writeFromSync(file.data);
        await raf.close();
        String dbpath = fileval.path;
        log(dbpath);
      }
    } catch (e) {
      showSnackBar(_scaffoldKey.currentContext!, text: 'Connection Time Out');
      Navigator.pushReplacement(
          _scaffoldKey.currentContext!, Approutes().errorscreen);
    }
  }

  // Future<void> getdistrict() async {
  //   await Labourdata().district();
  // }

  // Future<void> geteducation() async {
  //   await Labourdata().education();
  // }

  // Future<void> getlocalbdytype() async {
  //   await Labourdata().localbodytype();
  // }

  // Future<void> getgender() async {
  //   await Labourdata().gender();
  // }

  // Future<void> getlocalbdy() async {
  //   await Labourdata().localbodies();
  // }

  //  Future<void> getcategory() async {
  //   await Labourdata().occupations();
  // }
}
