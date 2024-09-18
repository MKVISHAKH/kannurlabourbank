import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final all = [
     Locale('en'),
     Locale('ml'),
    // const Locale('hi'),
  ];

  static String getLang(String code, BuildContext ctx) {
    switch (code) {
      case 'en':
        return 'ENGLISH';
      case 'ml':
      default:
        return AppLocalizations.of(ctx)!.mal;
    }
  }

  static double getFontSize(String code) {
    switch (code) {
      case 'en':
        return 16;
      case 'ml':
      default:
        return 12;
    }
  }

  static double getHeadFontSize(String code) {
    switch (code) {
      case 'en':
        return 24;
      case 'ml':
      default:
        return 20;
    }
  }

  static TextStyle getappbarSize(String code) {
    switch (code) {
      case 'en':
        return const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 18,
            color: Appcolors.fontclr,
            fontWeight: FontWeight.bold
            //fontWeight: FontWeight.bold
            );
      case 'ml':
      default:
        return const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 16,
            color: Appcolors.fontclr,
            fontWeight: FontWeight.bold
            //fontWeight: FontWeight.bold
            );
    }
  }

  static double getsignupFontSize(String code) {
    switch (code) {
      case 'en':
        return 45;
      case 'ml':
      default:
        return 35;
    }
  }

  static double getbuttonFontSize(String code) {
    switch (code) {
      case 'en':
        return 16;
      case 'ml':
      default:
        return 14;
    }
  }

  static TextStyle getbuttonstyle(String code) {
    switch (code) {
      case 'en':
        return const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 25,
            color: Appcolors.white,
            fontWeight: FontWeight.bold
            //fontWeight: FontWeight.bold
            );
      case 'ml':
      default:
        return const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 18,
            color: Appcolors.white,
            fontWeight: FontWeight.bold
            //fontWeight: FontWeight.bold
            );
    }
  }
}
