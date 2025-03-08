import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class Screenlabhome extends StatefulWidget {
  const Screenlabhome({super.key});

  @override
  State<Screenlabhome> createState() => _ScreenlabhomeState();
}

class _ScreenlabhomeState extends State<Screenlabhome> {
  String? name;
  int? usrID;
  String? token;
  String? gender;
  int? genderId;
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    final value = await Sharedata.instance.getdata();

    final username = value!.name;
    token = value.token;
    usrID = value.userid;
    gender = value.gender;
    genderId = value.genderId;

    setState(() {
      if (genderId == 1) {
        name = "Mr. $username";

        name = name!.toUpperCase();
      } else {
        name = "Ms. $username";
        name = name!.toUpperCase();
      }
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await warningBox(context);
        }
        log('BackButton pressed!');
      },
      //     WillPopScope(
      // onWillPop: () async {
      //   log('BackButton pressed!');
      //   final shouldPop = await warningBox(context);
      //   return shouldPop ?? false;
      // },
      child: Stack(
        children: [
          const Screensbackground(),
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            drawer: const Navbar(
              category: lab,
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                iconTheme: const IconThemeData(color: Appcolors.magenta),
                actions: [
                  IconButton(
                      onPressed: () {
                        warningBox(context);
                      },
                      icon: const Icon(Icons.exit_to_app,
                          color: Appcolors.fontclr))
                ],
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.labdet,
                  style: L10n.getappbarSize(locale.languageCode),
                  textScaler: TextScaler.noScaling
                ),
                backgroundColor: Appcolors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
              ),
            ),
            extendBodyBehindAppBar: true,
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: const Color(0xfff3f3f3),
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Text(
                                      "${AppLocalizations.of(context)!.wel}, $name,",
                                      style: kbodyfont,
                                      textScaler: TextScaler.noScaling),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Gridlabview(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signout(BuildContext ctx) async {
    // final sharedprefs = await SharedPreferences.getInstance();
    await Sharedata.instance.cleardata();
    // await sharedprefs.clear();
    Navigator.of(_scaffoldKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => ScreenHome()), (route) => false);
  }

  Future warningBox(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text(AppLocalizations.of(context)!.signout,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)),
                        textScaler: TextScaler.noScaling)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.no,
                    style: const TextStyle(color: Colors.white),
                    textScaler: TextScaler.noScaling),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => signout(context),
                child: Text(AppLocalizations.of(context)!.yes,
                    style: const TextStyle(color: Colors.white),
                    textScaler: TextScaler.noScaling),
              ),
            ],
          ));
}
