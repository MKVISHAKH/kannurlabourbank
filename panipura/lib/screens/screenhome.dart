import 'package:flutter/services.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/widgets/navbar.dart';
import '../widgets/constants.dart';
import 'dart:developer';
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.exitapp,
                style:
                    const TextStyle(color: Color.fromARGB(255, 101, 47, 248))),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.of(context)!.no,
                    style: const TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => 
                // SystemNavigator.pop(),
                Navigator.pop(context, true),
                child: Text(AppLocalizations.of(context)!.yes,
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ));
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      key: _scaffoldKey,
      children: [
        const Screensbackground(),
        // WillPopScope(
        //   onWillPop: () async {
        //     log('BackButton pressed!');
        //     final shouldPop = await showWarning(context);
        //     return shouldPop ?? false;
        //   },
        PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            log('BackButton pressed!');
            if (!didPop){
              //final nav=Navigator.of(context);
              if (didPop) return;
              final result= await showWarning(context);
              print(result);
              if (result != null && result) {
              SystemNavigator.pop();  // This will properly exit the app
            }
            } 
            
            // if (shouldPop != null && shouldPop) {
            //   Navigator.of(_scaffoldKey.currentContext!).pop();
            // }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: const Navbar(
              category: 3,
            ),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: Container(
                padding: const EdgeInsets.only(right: 55),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.appname,
                    style:const TextStyle(color:Colors.white)
                  ),
                ),
              ),
              backgroundColor:Appcolors.labelclr,
              // flexibleSpace: const Appbarimage(),
            ),
            //drawerScrimColor: Colors.blue,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Screensbackground(),
                    // SizedBox(height: 50,),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/splash/panchayath_logo.png"),
                        fit: BoxFit.fill,
                      )

                          //child:const Center(child: AssetImage("assets/splash/panchayath_logo.png"),
                          ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading1,
                            style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontSize:
                                    L10n.getHeadFontSize(locale.languageCode),
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 252, 32, 32))),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading2,
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  L10n.getHeadFontSize(locale.languageCode),
                              color: const Color.fromARGB(255, 47, 3, 100),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading3,
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  L10n.getHeadFontSize(locale.languageCode),
                              color: const Color.fromARGB(255, 47, 3, 100),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading4,
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  L10n.getHeadFontSize(locale.languageCode),
                              color: const Color.fromARGB(255, 47, 3, 100),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading5,
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  L10n.getHeadFontSize(locale.languageCode),
                              color: const Color.fromARGB(255, 47, 3, 100),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(AppLocalizations.of(context)!.homeheading6,
                            style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  L10n.getHeadFontSize(locale.languageCode),
                              color: const Color.fromARGB(255, 47, 3, 100),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.subhead1,
                          style: kscreenText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const ScreenLogin(
                                category: lab,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 3.0,
                            color: Appcolors.labelclr,
                          ),
                          backgroundColor: Appcolors.magenta,
                          fixedSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.buttonlabour,
                                textAlign: TextAlign.center,
                                style: kButtonText)),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.subhead2,
                          style: kscreenText,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const ScreenLogin(
                                category: emp,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 3.0,
                            color: Appcolors.labelclr,
                          ),
                          backgroundColor: Appcolors.magenta,
                          fixedSize: const Size(200, 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Center(
                            child: Text(
                                AppLocalizations.of(context)!.buttonemployer,
                                textAlign: TextAlign.center,
                                style: kButtonText)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
