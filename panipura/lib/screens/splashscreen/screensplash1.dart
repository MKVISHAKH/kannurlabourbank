import 'dart:io';
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
    dwnlddatabase(context);
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

  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
        if (!context.mounted) return;

    Navigator.pushReplacement(
        context, Approutes().splashScreen3);
  }

  Future<void> dwnlddatabase(BuildContext context) async {
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
        if (!context.mounted) return;
      final provider = Provider.of<LocaleProvider>(context,
          listen: false);
      provider.getlocale();

      /*****************************************/

      if (file == null) {
        if (!context.mounted) return;

        showSnackBar(context,
            text: 'Something Went Wrong');
        Navigator.pushReplacement(
            context, Approutes().errorscreen);
      } else if (file.statusCode! > 200) {
        if (!context.mounted) return;

        showSnackBar(context,
            text: 'Something Went Wrong');
        Navigator.pushReplacement(
            context, Approutes().errorscreen);
      } else {
        gotoLogin(context);
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
        if (!context.mounted) return;
      showSnackBar(context, text: 'Connection Time Out');
      Navigator.pushReplacement(
          context, Approutes().errorscreen);
    }
  }


}
