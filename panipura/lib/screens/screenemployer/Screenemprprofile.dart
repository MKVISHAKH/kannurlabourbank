
import 'package:intl/intl.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/database/labourdb.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/model/dropdownname/namemdl.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/screens/deleteaccount/deleteAccount.dart';
import 'dart:developer';

import 'package:panipura/widgets/constants.dart';

class ScreenEmpProfile extends StatefulWidget {
  const ScreenEmpProfile({super.key});

  @override
  State<ScreenEmpProfile> createState() => _ScreenEmpProfileState();
}

class _ScreenEmpProfileState extends State<ScreenEmpProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? place;
  String? mob;
  String? dob;
  String? sex;
  int? empid;
  String? token;
  //String? edu;
  Locale? localecode;
  Future<bool?> popscreen(BuildContext context) async {
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().emphomeScreen);
    return true;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();      
    });
    
    super.initState();
    getUserdata();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  void getUserdata() async {
    final value = await Sharedata.instance.getdata();
    final nam = value!.name;
    final plac = value.place;
    final mobi = value.mobile;
    final dbirth = value.dob;
    empid=value.userid;
    token=value.token;
    log('$dob');
    DateTime dobdt = DateFormat("yyyy-MM-dd").parse(dbirth!);
    DateFormat dateFormat1 = DateFormat.yMMMMd();
    String birthdt = dateFormat1.format(dobdt);
    log(birthdt);
    //final gender = value.gender;
    String? genderName;
      final genderNameval = await LabourDb.instance
          .getGenderName(value.genderId, localecode);

      for (var map in genderNameval) {
        final gender = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            genderName = gender.nameml;
            log('$genderName');
          } else {
            genderName = gender.name;
            log('$genderName');
          }
        });
      }

    setState(() {
      name = nam;
      place = plac;
      mob = mobi;
      sex = genderName;
      dob = birthdt;

      name = name!.toUpperCase();
      sex = sex!.toUpperCase();
      place = place!.toUpperCase();
      mob = mob!.toUpperCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;

    return Stack(
      children: [
        const Screensbackground(),
        WillPopScope(
          onWillPop: () async {
            final shouldPop = await popscreen(context);
            return shouldPop ?? false;
          },
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(_scaffoldKey.currentContext!,
                            Approutes().emphomeScreen);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Appcolors.fontclr,
                      )),
                ),
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.pro,
                  style: L10n.getappbarSize(locale.languageCode),
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('$name ', style: kscreenText),
                      subtitle: Text('$place'),
                    ),
                    const Divider(),

                    /******Contact info*******/
                    Text(AppLocalizations.of(context)!.contact,
                        style: L10n.getappbarSize(locale.languageCode)),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('$mob ', style: kscreenText),
                      subtitle: const Text('Mobile'),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/background/4392964.png'),
                      ),
                      //trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Color.fromARGB(255, 158, 89, 248))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),

                    /******Basic info*******/
                    Text(AppLocalizations.of(context)!.bsinfo,
                        style: L10n.getappbarSize(locale.languageCode)),
                    const SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      title: Text('$sex ', style: kscreenText),
                      subtitle: const Text('Gender'),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/background/user-icon-vector-9916742.jpg'),
                      ),
                      //trailing: IconButton(onPressed: (){}, icon:const Icon(Icons.edit,color: Color.fromARGB(255, 158, 89, 248))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    ListTile(
                      title: Text('$dob', style: kscreenText),
                      subtitle: const Text('Date of Birth'),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/background/788-7885571_timing-icon-calendar-right-time-icon.png'),
                      ),
                    ),
                    const Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context)!.deleteac, style: kscreenText),
              subtitle: const Text('Delete your Account'),
              onTap: (){
                  Navigator.of(_scaffoldKey.currentContext!).push(
                      MaterialPageRoute(
                        builder: (ctx) => ScreenDeleteAccount(usrId: empid,token:token,category: emp,)
                      ),
                    );
              },
            ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
