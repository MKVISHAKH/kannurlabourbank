import 'package:intl/intl.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenViewrating extends StatefulWidget {
  final int? usrId;
  final String? token;
  final String? name;
  const ScreenViewrating(
      {super.key,
      required this.usrId,
      required this.token,
      required this.name});

  @override
  State<ScreenViewrating> createState() => _ScreenViewratingState();
}

class _ScreenViewratingState extends State<ScreenViewrating> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double rating = 0;
  int? usrId;
  String? langcode;
  Locale? localecode;
  @override
  void initState() {
    getSkills(context);
    //getskillrate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    Future.delayed(Duration.zero, () {
      var po = context.read<ProfilepicProvider>();
      po.updateProfilepic(widget.usrId, widget.token);
    });
    super.initState();
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  getSkills(BuildContext context) async {
    final value = await Sharedata.instance.getdata();

    usrId = value!.userid;
    if (localecode == Locale('ml')) {
      langcode = langmal;
    } else {
      langcode = langeng;
    }
        if (!context.mounted) return;

    await Labempfn.instance.refreshskillUI(usrId, langcode,context);
  }
  //  getskillrate() async{
  //   final getratereq=Getskillratereq.req(userId: widget.usrId, skillId: widget.skillid);
  //   Labempfn.instance.getrateskill(getratereq);
  // }

  @override
  Widget build(BuildContext context) {
    var inputPro = context.read<ProfilepicProvider>();
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      children: [
        const Screensbackground(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Screenlabhome(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 158, 89, 248),
                    )),
              ),
              centerTitle: true,
              title: Text(AppLocalizations.of(context)!.ratervw,
                  style: L10n.getappbarSize(locale.languageCode)),
              backgroundColor: Colors.white,
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
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: inputPro.imageFile,
                  ),
                  title: Text("${widget.name!.toUpperCase()} ",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 47, 3, 100),
                      )),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.myskill,
                        style: L10n.getappbarSize(locale.languageCode)),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    buildlistaddskill()
                  ],
                ),
              )
            ],
          )),
        ),
      ],
    );
  }

  Widget buildlistaddskill() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSkillListNotifier,
      builder:
          (BuildContext context, List<Getrefskillresplist> newList, Widget? _) {
        return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (ctx, index) {
              final value = newList[index];

              DateFormat dateFormat1 = DateFormat.yMMMMd();
              String jobdt = dateFormat1.format(value.createdAt!);

              final skillid = value.skillId;
              //String skillval = skillid.toString();

              final wrkname = value.occupationname;
              // final userid=_value.userId;
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: ListTile(
                    title: Text(wrkname!, style: kscreenText),
                    subtitle: Text(jobdt,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 47, 3, 100),
                        )),
                    trailing: Text(AppLocalizations.of(context)!.view,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 47, 3, 100),
                        )),
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenReviews(
                            usrId: widget.usrId,
                            skillId: skillid,
                            wrkname: wrkname,
                          ),
                        ),
                      );

                      // final getratereq=Getskillratereq.req(userId: widget.usrId, skillId: skillid);
                      //   Labempfn.instance.getrateskill(getratereq);
                    },
                  ),
                ),
              );
            },
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 5,
                )),
            itemCount: newList.length);
      });
}
