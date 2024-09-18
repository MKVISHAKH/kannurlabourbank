import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/widgets/constants.dart';

callalertbox(BuildContext context,int? catg) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: Center(child: Text(AppLocalizations.of(context)!.wordlang)),
          content: buildLang(context,catg),
        ));
        final _scaffoldKey = GlobalKey<ScaffoldState>();
Widget buildLang(BuildContext context,int? category) {
  final provider = Provider.of<LocaleProvider>(context);
  final locale = provider.locale;

  return Row(
    key:_scaffoldKey,
    children: [
      Text(
        AppLocalizations.of(context)!.selectlang,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: L10n.getFontSize(locale.languageCode)),
      ),
      DropdownButtonHideUnderline(
          child: DropdownButton(
        value: locale,
        // icon:Container(width:12),
        items: L10n.all.map(
          (locale) {
            final lang = L10n.getLang(locale.languageCode, context);
            return DropdownMenuItem(
              value: locale,
              child: Center(
                child: Text(lang,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              onTap: () async {
                
                if(category==hom){
                  final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                String? langval = ' ';
                if (locale == Locale('ml')) {
                  langval = 'ml';
                } else {
                  langval = 'en';
                }
                await Sharedata.instance.setlocale(langval);
                provider.setLocale(locale);
                  Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) =>  ScreenHome(),

                            ),
                          );

                }else if(category==emp){
                  final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                String? langval = ' ';
                if (locale == Locale('ml')) {
                  langval = 'ml';
                } else {
                  langval = 'en';
                }
                await Sharedata.instance.setlocale(langval);
                provider.setLocale(locale);

                  Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) =>const  ScreenEmployerHome(),

                            ),
                          );
                }else if(category==lab){
                  final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                String? langval = ' ';
                if (locale == Locale('ml')) {
                  langval = 'ml';
                } else {
                  langval = 'en';
                }
                await Sharedata.instance.setlocale(langval);
                provider.setLocale(locale);

                  Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) =>const  Screenlabhome(),

                            ),
                          );
                }else{
                  final provider =
                    Provider.of<LocaleProvider>(context, listen: false);
                String? langval = ' ';
                if (locale == Locale('ml')) {
                  langval = 'ml';
                } else {
                  langval = 'en';
                }
                await Sharedata.instance.setlocale(langval);
                provider.setLocale(locale);
                  Navigator.pop(_scaffoldKey.currentContext!);
                }
                
                
              },
            );
          },
        ).toList(),
        onChanged: (_) {},
      )),
    ],
  );
}
