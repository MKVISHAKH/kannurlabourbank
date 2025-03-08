import 'package:panipura/core/hooks/hook.dart';

class Approutes {
  PageTransition splashScreen1 = PageTransition(
    child: const ScreensplashOne(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition splashScreen2 = PageTransition(
    child: const ScreensplashTwo(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition splashScreen3 = PageTransition(
    child: const ScreensplashThree(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition errorscreen = PageTransition(
    child: const ScreenError(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition commontandc = PageTransition(
    child: const ScreenCommonTandC(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition commonpandp = PageTransition(
    child: const ScreenCommonPandP(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  //  PageTransition addSkillScreen=PageTransition(
  // child:const ScreenLabSkill(),
  //  type: PageTransitionType.fade,
  //  alignment: Alignment.center,
  //  curve: Curves.easeInOutBack,
  //  duration:const Duration(microseconds: 500),
  //  );

  PageTransition homeScreen = PageTransition(
    child: ScreenHome(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition labhomeScreen = PageTransition(
    child: const Screenlabhome(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  PageTransition emphomeScreen = PageTransition(
    child: const ScreenEmployerHome(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );

  // PageTransition homeScreendemo = PageTransition(
  //   child: const Screenhome(),
  //   type: PageTransitionType.fade,
  //   alignment: Alignment.center,
  //   curve: Curves.easeInOutBack,
  //   duration: const Duration(microseconds: 500),
  // );

  PageTransition empProscreen = PageTransition(
    child: const ScreenEmpProfile(),
    type: PageTransitionType.fade,
    alignment: Alignment.center,
    curve: Curves.easeInOutBack,
    duration: const Duration(microseconds: 500),
  );
  //  PageTransition forgotpswrdScreen=PageTransition(
  // child:const ScreenForgotpswrd(mobile:),
  //  type: PageTransitionType.fade,
  //  alignment: Alignment.center,
  //  curve: Curves.easeInOutBack,
  //  duration:const Duration(microseconds: 500),
  //  );
}
