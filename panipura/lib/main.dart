import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const savekeyname = '_userLoggedIn';
const savelocalekey = '_userLocaleIn';
const savedeviceinfo = '_userDeviceIn';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  LabourDb.instance.initializedatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<EventProvider>(
              create: (context) => EventProvider()),
          ChangeNotifierProvider<SignupProvider>(
              create: (context) => SignupProvider()),
          ChangeNotifierProvider<FrgtpswrdProvider>(
              create: (context) => FrgtpswrdProvider()),
          ChangeNotifierProvider<CallProvider>(
              create: (context) => CallProvider()),
          ChangeNotifierProvider<ProfilepicProvider>(
              create: (context) => ProfilepicProvider()),
          ChangeNotifierProvider<LoadingProvider>(
              create: (context) => LoadingProvider()),
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(),
            builder: (context, child) {
              final provider = Provider.of<LocaleProvider>(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler:TextScaler.noScaling),
                child: MaterialApp(
                  title: 'LABOUR BANK',
                  themeMode: ThemeMode.system,
                  theme: MyTheme.lightTheme,
                  darkTheme: MyTheme.darkTheme,
                  locale: provider.locale,
                  supportedLocales: L10n.all,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  home: const ScreensplashOne(),
                ),
              );
            },
          ),
        ],
      );
}
