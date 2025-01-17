import 'package:intl/intl.dart';
import 'package:panipura/l10n/l10n.dart';
import '../../core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenReviews extends StatefulWidget {
  final int? usrId;
  final int? skillId;
  final String? wrkname;
  const ScreenReviews(
      {super.key,
      required this.usrId,
      required this.skillId,
      required this.wrkname});

  @override
  State<ScreenReviews> createState() => _ScreenReviewsState();
}

class _ScreenReviewsState extends State<ScreenReviews> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getskillrate(context);
  }

  getskillrate(BuildContext context) async {
    final getratereq =
        Getskillratereq.req(userId: widget.usrId, skillId: widget.skillId);
    Labempfn.instance.refreshRateUI(getratereq,context);
  }

  @override
  Widget build(BuildContext context) {
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
                      //  Navigator.of(context).pushReplacement(
                      //        MaterialPageRoute(
                      //          builder: (context) =>const Screenlabhome(),
                      //         ),
                      //       );
                      Navigator.pop(context);
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
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15),
                          child: Text(
                              "${AppLocalizations.of(context)!.skill}   : ${widget.wrkname}",
                              style: kbodyfont),
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 15.0),
                              child: Text(
                                  "${AppLocalizations.of(context)!.ratervw} :",
                                  style: kbodyfont),
                            ),
                            Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 158, 89, 248),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: Labempfn
                                          .instance.gettotalrateListNotifier,
                                      builder: (BuildContext context,
                                          String? value, _) {
                                        return Text(
                                          "$value",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        );
                                      }),
                                  //Text("4.4",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  const Icon(Icons.star,
                                      color: Colors.white, size: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  )),

              buildskillrate(),

              //buildlistaddskill()
            ],
          )),
        ),
      ],
    );
  }

  Widget buildskillrate() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSkillrateListNotifier,
      builder:
          (BuildContext context, List<Getskillratelist> newList, Widget? _) {
        return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (ctx, index) {
              final value = newList[index];

              // DateFormat dateFormat1=DateFormat.yMMMMd();
              // String jobdt=dateFormat1.format(_value.createdAt!);

              // final skillid=_value.skillId;

              final rating = value.rating;
              String? comment = value.comments;
              comment ??= '';
              String? empname = value.employerName;
              empname ??= '';

              String? jobdt = value.createdAt;
              jobdt ??= '';
              DateTime ratedate = DateTime.parse(jobdt);
              String formattedDate = DateFormat.yMMMd().format(ratedate);
              // DateFormat dateFormat1=DateFormat.yMMMMd();
              //formattedDate ??='';

              return Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  //borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: ListView(children: [
                    Column(
                      children: [
                        Card(
                          elevation: 2,
                          child: ListTile(
                            //dense: true,
                            leading: Container(
                              height: 25,
                              width: 40,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 158, 89, 248),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$rating",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  const Icon(Icons.star,
                                      color: Colors.white, size: 15),
                                ],
                              ),
                            ),
                            title: Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                comment,
                                style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 47, 3, 100),
                                  //fontWeight: FontWeight.bold)
                                ),
                                //  maxLines: 2,
                                //  overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            subtitle: Align(
                              alignment: const Alignment(-1.0, -0.8),
                              child: Row(children: [
                                Text(empname,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 47, 3, 100),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(formattedDate,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 47, 3, 100),
                                    )),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            },
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 5,
                )),
            itemCount: newList.length);
      });
}
