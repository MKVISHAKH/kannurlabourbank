import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/widgets/constants.dart';
import 'package:panipura/widgets/language/language_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Navbar extends StatefulWidget {
  final int? category;
  const Navbar({super.key, required this.category});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = '';
  String brname = '';
  bool isVisible = true;
  String? version;
  @override
  void initState() {
    //checkUserLoggedIn();
    super.initState();

    if (widget.category == emp) {
      isVisible = isVisible;
    } else {
      setState(() {
        isVisible = !isVisible;
      });
    }
    buildversion();
  }
  void buildversion() async {
    final value = await Sharedata.instance.getdeviceinfo();
  
   final devversion=value.appversion;
   final devicever=devversion!.split('+');
   final versionval=devicever[0];

    setState(() {
      version=versionval;
    });
  }

  Future<bool?> popscreen(BuildContext context) async {
    if(widget.category==lab){
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>const Screenlabhome(),
      ),
    );
    return true;
    }else if(widget.category==emp){
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>const ScreenEmployerHome(),
      ),
    );
    return true;
    }else{
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenHome(),
      ),
    );
    return true;
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    // final provider=Provider.of<LocaleProvider>(context);
    // final locale=provider.locale ;
    return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (!didPop){
              if (didPop) return;
               await popscreen(context);
            
            } 
          },
      child: Drawer(
        key: _scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                AppLocalizations.of(context)!.appname,
              ),
              accountEmail:  Text('Version:$version'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/background/logo2 (1).png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover, //fit image in circle
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Appcolors.labelclr,
              ),
            ),
            Visibility(
              visible: isVisible,
              child: ListTile(
                  leading: const Icon(
                    Icons.person_2_outlined,
                    color: Color.fromARGB(255, 101, 47, 248),
                  ),
                  title: Text(AppLocalizations.of(context)!.pro),
                  onTap: () {
                    Navigator.push(
                        _scaffoldKey.currentContext!, Approutes().empProscreen);
                  }),
            ),
            ListTile(
                leading: const Icon(
                  Icons.language_outlined,
                  color: Appcolors.labelclr,
                ),
                title: Text(AppLocalizations.of(context)!.wordlang),
                // subtitle:locale ,
                onTap: () {
                  //  final value = await Sharedata.instance.getlocale();
                  //  final locale=value;
                  //  Locale? locvale;
                  //  if(locale=='ml'){
                  //     locvale=Locale('ml');
                  //  }else{
                  //   locvale=Locale('en');
                  //  }
                  // ignore: use_build_context_synchronously
                  callalertbox(context,widget.category);
                }),
            const Divider(),
            ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Appcolors.labelclr,
                ),
                title: Text(
                  AppLocalizations.of(context)!.tandc,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().commontandc);
                }),
            ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Appcolors.labelclr,
                ),
                title: Text(
                  AppLocalizations.of(context)!.pandp,
                ),
                onTap: () {
                  Navigator.push(context, Approutes().commonpandp);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
