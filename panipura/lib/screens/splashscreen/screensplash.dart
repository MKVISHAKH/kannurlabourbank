import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panipura/screens/screenhome.dart';
import '../../api/apidata.dart';
//import '../widgets/backgroundimage.dart';
//import '../widgets/stylefamily.dart';

class Screensplash extends StatefulWidget {
  const Screensplash({Key? key}) : super(key: key);

  @override
  State<Screensplash> createState() => _ScreensplashState();
}

class _ScreensplashState extends State<Screensplash> {
  // @override
  // void initState() {
  //   gotoLogin();
  //   super.initState();
  // }
  @override
  void initState() {
    //checkUserLoggedIn();
    getdistrict();
    geteducation();
    getlocalbdytype();
    getgender();
    getlocalbdy();
    getcategory();
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: screenSize.height / 1.4,
              width: screenSize.width,
            ),
          ),
          Positioned(
            top: 100,
            right: 5,
            left: 5,
            child: AnimatedSplashScreen(
              splashIconSize: 200,
              backgroundColor: Colors.white,
              pageTransitionType: PageTransitionType.topToBottom,
              splashTransition: SplashTransition.rotationTransition,
              splash: const CircleAvatar(
                radius: 100,
                backgroundImage:
                    AssetImage("assets/splash/panchayath_logo.png"),
              ),
              nextScreen: ScreenHome(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(
      const Duration(seconds: 8),
    );
    Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ScreenHome(),
      ),
    );
  }

  Future<void> getdistrict() async {
    await Labourdata().district();
  }

  Future<void> geteducation() async {
    await Labourdata().education();
  }

  Future<void> getlocalbdytype() async {
    await Labourdata().localbodytype();
  }

  Future<void> getgender() async {
    await Labourdata().gender();
  }

  Future<void> getlocalbdy() async {
    await Labourdata().localbodies();
  }

  Future<void> getcategory() async {
    await Labourdata().occupations();
  }
  // Future<void> checkUserLoggedIn() async {
  //   final _sharedprefs = await SharedPreferences.getInstance();
  //   final _userLoggedIn = _sharedprefs.getBool(savekeyname);

  //   if (_userLoggedIn == null || _userLoggedIn == false) {
  //     gotoLogin();
  //   } else {
  //     await Future.delayed(
  //       const Duration(seconds: 3),
  //     );
  //     Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (ctx1) => const Screenhome(),
  //       ),
  //     );
  //   }
  // }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.orange);

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
