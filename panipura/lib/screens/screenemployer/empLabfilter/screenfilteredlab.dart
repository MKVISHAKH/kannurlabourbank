import 'dart:developer';

import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenFilteredLab extends StatefulWidget {
  const ScreenFilteredLab({super.key, required this.isSearchnull});
  final bool? isSearchnull;
  @override
  State<ScreenFilteredLab> createState() => _ScreenFilteredLabState();
}

class _ScreenFilteredLabState extends State<ScreenFilteredLab> {
  String? langcode;
  Locale? localecode;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ScreenEmployerHome(),
      ),
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(children: [
      const Screensbackground(),
      PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (!didPop) {
            if (didPop) return;
            await popscreen(context);
          }
          log('BackButton pressed!');
        },
        child: Scaffold(
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
                          builder: (context) => const ScreenEmployerHome(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Appcolors.magenta,
                    )),
              ),
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.filtlab,
                style: L10n.getappbarSize(locale.languageCode),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
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
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.result,
                      style: L10n.getappbarSize(locale.languageCode)),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  widget.isSearchnull == true
                      ? Expanded(child: buildlabsearchlist())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    Text("No data Found ",
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget buildlabsearchlist() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSearchListNotifier,
      builder: (BuildContext context, List<Searchlablist> newList, Widget? _) {
        return ListView.separated(
            shrinkWrap: true,
            // padding:const EdgeInsets.all(8.0),
            itemBuilder: (ctx, index) {
              final val = newList[index];

              final name = val.name!.toUpperCase();

              final place = val.place!.toUpperCase();
              final mobile = val.mobile;
              final userid = val.userId;
              final occupationid = val.occupationId;
              final ratingval = val.rating;
              //final sklid=val.skillId;
              //final occupationid=_value.occupationId;
              // final wrkname=_value.occupationname;

              //final Future<String?> wrkname=getskillname(occupationid);

              // return Slidable(
              //   key:Key(skillval),
              //   startActionPane:ActionPane(
              //     motion: const ScrollMotion(),
              //      children: [
              //       SlidableAction(
              //         onPressed: (ctx){
              //           Navigator.of(context).pushReplacement(
              //                  MaterialPageRoute(
              //                    builder: (context) => Screenviewprofile(
              //                     isSearchnull: widget.isSearchnull,
              //                     userid: userid,
              //                     name:name,
              //                     occupationid:occupationid
              //                     ),
              //                   ),
              //                 );
              //         },
              //         borderRadius: BorderRadius.circular(10),
              //         backgroundColor: const Color.fromARGB(255, 158, 89, 248),
              //         foregroundColor: Colors.white,
              //         icon:Icons.article_outlined,
              //         label:'Details'

              //         ),

              //      ]
              //      ),
              //      child:
              return Card(
                  // shape:
                  //     RoundedRectangleBorder(
                  //         //borderRadius: BorderRadius.circular(10.0),
                  //         side:const BorderSide(color: Color.fromARGB(255, 158, 89, 248),)),

                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/background/business-briefcase-icon-digital-purple-vector-26516778.jpg'),
                      ),
                      title: Text("$name \n$place",
                          style: const TextStyle(
                              color: Appcolors.fontclr, fontSize: 14)),
                      subtitle: Align(
                        alignment: const Alignment(-1.0, -0.8),
                        child: Row(
                          children: [
                            Text("${AppLocalizations.of(context)!.rate} :",
                                style: const TextStyle(
                                  color: Appcolors.fontclr,
                                )),
                            //const Icon(Icons.star,color:Color.fromARGB(255, 47, 3, 100),size:15),
                            Container(
                              height: 25,
                              width: 60,
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
                                          "$ratingval ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
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
                      ),
                      //  minVerticalPadding: 10,
                      trailing: const Icon(
                        Icons.arrow_forward,
                        color: Color.fromARGB(255, 158, 89, 248),
                      ),
                      onTap: () {
                        if (localecode == Locale('ml')) {
                          langcode = langmal;
                        } else {
                          langcode = langeng;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Screenviewprofile(
                              isSearchnull: widget.isSearchnull,
                              userid: userid,
                              name: name,
                              occupationid: occupationid,
                              mobile: mobile,
                              localecode: langcode,
                            ),
                          ),
                        );
                      }),
                ),
              ));

              //  elevation: 0,
              //       child:
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //      Padding(
              //        padding: const EdgeInsets.all(10.0),
              //        child: Container(
              //         width:MediaQuery.of(context).size.width,
              //         height: 80,
              //         decoration:const BoxDecoration(color:Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         ),
              //             child:Text(" $name \n $place \n Contact No: $mobile \n Rating:",style: kfilteredlist,),
              //        ),
              //      ),

              //   ],
              // )
            },
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 0,
                )),
            itemCount: newList.length);
      });
}
