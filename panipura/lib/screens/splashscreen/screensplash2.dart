import 'package:flutter/material.dart';
import 'package:panipura/core/routes/approutes.dart';

class ScreensplashTwo extends StatefulWidget {
  const ScreensplashTwo({super.key});

  @override
  State<ScreensplashTwo> createState() => _ScreensplashTwoState();
}

class _ScreensplashTwoState extends State<ScreensplashTwo> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(
      const Duration(seconds: 4),
    );
    Navigator.pushReplacement(
        _scaffoldKey1.currentContext!, Approutes().splashScreen3);
  }

  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      key: _scaffoldKey1,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.transparent, Color.fromARGB(255, 248, 153, 185)],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.softLight,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/splash/1686027410997.JPEG',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
