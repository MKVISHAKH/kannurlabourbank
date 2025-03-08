import 'package:intl/intl.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class ScreenLabRating extends StatefulWidget {
  const ScreenLabRating(
      {super.key,
      required this.isSearchnull,
      required this.userid,
      required this.name,
      required this.occupationid,
      required this.mobile,
      required this.wrkname,
      required this.skillid,
      required this.empid});
  final bool? isSearchnull;
  final int? userid;
  final int? skillid;
  final String? name;
  final int? occupationid;
  final String? mobile;
  final String? wrkname;
  final int? empid;

  @override
  State<ScreenLabRating> createState() => _ScreenLabRatingState();
}

class _ScreenLabRatingState extends State<ScreenLabRating> {
  String? username;
  String? wrkname;
  double rating = 0;
  bool? isSearchnullval;
  String? nameval;
  int? occupationId;
  String? mobileno;
  int? usrId;
  //String? wrkname;
  final _commentcontroller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? langcode;
  Locale? localecode;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    username = widget.name!.toUpperCase();
    wrkname = widget.wrkname!.toUpperCase();
    isSearchnullval = widget.isSearchnull;
    nameval = widget.name;
    usrId = widget.userid;
    print(usrId);
    occupationId = widget.occupationid;
    mobileno = widget.mobile;
    getskillrate(context);
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  getskillrate(BuildContext context) async {
    final getratereq =
        Getskillratereq.req(userId: widget.userid, skillId: widget.skillid);

    await Labempfn.instance.refreshRateUI(
        getratereq, context); // Labempfn.instance.getrateskill(getratereq);
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Screenviewprofile(
          isSearchnull: widget.isSearchnull,
          userid: widget.userid,
          name: widget.name,
          occupationid: widget.occupationid,
          mobile: widget.mobile,
          localecode: langcode,
        ),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      children: [
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
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70),
                child: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: IconButton(
                        onPressed: () {
                          if (localecode == Locale('ml')) {
                            langcode = langmal;
                          } else {
                            langcode = langeng;
                          }
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Screenviewprofile(
                                isSearchnull: widget.isSearchnull,
                                userid: widget.userid,
                                name: widget.name,
                                occupationid: widget.occupationid,
                                mobile: widget.mobile,
                                localecode: langcode,
                              ),
                            ),
                          );
                          // Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color.fromARGB(255, 158, 89, 248),
                        )),
                  ),
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.addratervw,
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
                child: Container(
                  color: const Color(0xfff3f3f3),
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: ListView(
                    children: [
                      Container(
                          width: double.infinity,
                          //height: 180,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Text(
                                    "${AppLocalizations.of(context)!.nameemp} : $username",
                                    style: kbodyfont),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Text(
                                    "${AppLocalizations.of(context)!.wrk}   : $wrkname",
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
                                        color: const Color.fromARGB(
                                            255, 158, 89, 248),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ValueListenableBuilder(
                                            valueListenable: Labempfn.instance
                                                .gettotalrateListNotifier,
                                            builder: (BuildContext context,
                                                String? value, _) {
                                              return Text(
                                                value ?? '0',
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    showratingpopup(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 158, 89, 248),
                                      fixedSize: const Size(160, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .ratemywrk,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                        const Icon(Icons.star,
                                            color: Colors.white, size: 15)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildskillrate(),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget buildrating() {
    return RatingBar.builder(
        minRating: 1,
        itemSize: 46,
        // unratedColor: Color(Colors.),
        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color.fromARGB(255, 101, 47, 248),
            ),
        updateOnDrag: true,
        onRatingUpdate: (rating) => setState(() {
              this.rating = rating;
              log('$rating');
            }));
  }

  Widget buildskillrate() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSkillrateListNotifier,
      builder:
          (BuildContext context, List<Getskillratelist> newList, Widget? _) {
        return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (ctx, index) {
              final value = newList[index];

              final rating = value.rating;
              int? usrid = value.employerId;
              print(usrid);
              String? comment = value.comments;
              comment ??= '';
              String? empname = value.employerName;
              empname ??= '';
              int? rateId = value.ratingId;
              String? jobdt = value.createdAt;
              jobdt ??= '';
              DateTime ratedate = DateTime.parse(jobdt);
              String formattedDate = DateFormat.yMMMd().format(ratedate);

              return Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius:
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
                                      color: Appcolors.fontclr,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(formattedDate,
                                    style: const TextStyle(
                                      color: Appcolors.fontclr,
                                    )),
                              ]),
                            ),

                            trailing: usrid == widget.empid
                                ? IconButton(
                                    onPressed: () async {
                                      warningBox(context, rateId);
                                    },
                                    icon: const Icon(Icons.delete,
                                        size: 30,
                                        color:
                                            Color.fromARGB(255, 158, 89, 248)),
                                  )
                                : const SizedBox.shrink(),
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
  Future showratingpopup(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          final provider = Provider.of<LocaleProvider>(context);
          final locale = provider.locale;
          return SimpleDialog(
            //key:_scaffoldKey,
            title: Center(
              child: Text(
                AppLocalizations.of(context)!.ratemywrk,
                style: const TextStyle(color: Appcolors.labelclr),
              ),
            ),
            children: [
              Column(
                children: [
                  buildrating(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: TextFormField(
                        controller: _commentcontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 200,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          fillColor: Colors.white,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 89, 248),
                              width: 1,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 158, 89, 248),
                                width: 1,
                              )),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 89, 248),
                              width: 1,
                            ),
                          ),
                          labelText: AppLocalizations.of(context)!.addrvw,
                          labelStyle: L10n.getappbarSize(locale.languageCode),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                child: Center(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 158, 89, 248),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text(AppLocalizations.of(context)!.cancel,
                              style: const TextStyle(color: Colors.white))),
                      //const SizedBox(width: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 158, 89, 248),
                          ),
                          onPressed: () async {
                            final value = await Sharedata.instance.getdata();
                            final empId = value!.userid;
                            final comments = _commentcontroller.text;
                            final ratingreq = Ratingreqmdl.req(
                                employerId: empId,
                                userId: widget.userid,
                                rating: rating,
                                skillId: widget.skillid,
                                comments: comments);
                            if (!context.mounted) return;

                            buildrateskill(ratingreq, context);
                            //Labempfn.instance.rateskill(ratingreq,isSearchnullval,nameval,occupationId,mobileno,wrkname,context);
                          },
                          child: Text(AppLocalizations.of(context)!.sub,
                              style: const TextStyle(color: Colors.white)))
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }

  Future buildrateskill(Ratingreqmdl value, BuildContext context) async {
    final rateskillrslt = await Labourdata().rateskill(value);
    if (rateskillrslt == null) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
    } else if (rateskillrslt.statusCode == 200) {
      final resultAsjson = jsonDecode(rateskillrslt.data);

      final registerval =
          Rateskillresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = registerval.success;
      final data = registerval.data;
      if (status == true && data != null) {
        final message = registerval.message;
        final getratereq =
            Getskillratereq.req(userId: widget.userid, skillId: widget.skillid);
        if (!context.mounted) return;

        Labempfn.instance.refreshRateUI(getratereq, context);

        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ScreenLabRating(
              isSearchnull: isSearchnullval,
              userid: widget.userid,
              name: nameval,
              occupationid: occupationId,
              mobile: mobileno,
              wrkname: wrkname,
              skillid: widget.skillid,
              empid: widget.empid,
            ),
          ),
        );
      } else {
        final message = registerval.message;
        if (!context.mounted) return;

        await showDialogError(context, message);
      }
    } else if (rateskillrslt.statusCode == 500) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Sever Not Reachable");

      // showLoginerror(context, 3);
    } else if (rateskillrslt.statusCode == 408) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Connection time out");

      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future showDialogfail(BuildContext? context) async => showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text("something went wrong",
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (!context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenLabRating(
                            isSearchnull: isSearchnullval,
                            userid: widget.userid,
                            name: nameval,
                            occupationid: occupationId,
                            mobile: mobileno,
                            wrkname: wrkname,
                            skillid: widget.skillid,
                            empid: widget.empid,
                          ),
                        ),
                      );
                    },
                    child: const Center(child: Text('OK'))),
              ]));

  Future showDialogError(BuildContext? context, String? message) async =>
      showDialog(
          barrierDismissible: false,
          context: context!,
          builder: (context) => AlertDialog(title: Text(message!), actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenLabRating(
                              isSearchnull: isSearchnullval,
                              userid: widget.userid,
                              name: nameval,
                              occupationid: occupationId,
                              mobile: mobileno,
                              wrkname: wrkname,
                              skillid: widget.skillid,
                              empid: widget.empid,
                            ),
                          ),
                        ),
                    child: const Center(child: Text('OK'))),
              ]));

  Future warningBox(BuildContext context, int? value) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text(AppLocalizations.of(context)!.delskill,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 101, 47, 248)))),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.no,
                    style: const TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () async {
                  builddeleteskill(context, value);
                },
                child: Text(AppLocalizations.of(context)!.yes,
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ));

  Future builddeleteskill(BuildContext context, int? value) async {
    final deleteresp = await Labourdata().delrate(value);

    log('$deleteresp');
    if (deleteresp == null) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
    } else if (deleteresp.statusCode == 200) {
      final resultAsjson = jsonDecode(deleteresp.data);
      final searchval =
          Deleteresp.fromJson(resultAsjson as Map<String, dynamic>);
      final message = searchval.message;
      final status = searchval.success;
      if (status == true) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message);
        final getratereq =
            Getskillratereq.req(userId: widget.userid, skillId: widget.skillid);
        await Labempfn.instance.refreshRateUI(getratereq, context);
        if (!context.mounted) return;

        Labempfn.instance.refreshRateUI(getratereq, context);
        if (!context.mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ScreenLabRating(
              isSearchnull: isSearchnullval,
              userid: widget.userid,
              name: nameval,
              occupationid: occupationId,
              mobile: mobileno,
              wrkname: wrkname,
              skillid: widget.skillid,
              empid: widget.empid,
            ),
          ),
        );
      } else {
        if (!context.mounted) return;
        CommonFun.instance
            .showApierror(context, message ?? "something went wrong");

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenLabRating(
              isSearchnull: isSearchnullval,
              userid: widget.userid,
              name: nameval,
              occupationid: occupationId,
              mobile: mobileno,
              wrkname: wrkname,
              skillid: widget.skillid,
              empid: widget.empid,
            ),
          ),
        );
      }
    } else if (deleteresp.statusCode == 500) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Sever Not Reachable");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScreenLabRating(
            isSearchnull: isSearchnullval,
            userid: widget.userid,
            name: nameval,
            occupationid: occupationId,
            mobile: mobileno,
            wrkname: wrkname,
            skillid: widget.skillid,
            empid: widget.empid,
          ),
        ),
      );
      // showLoginerror(context, 3);
    } else if (deleteresp.statusCode == 408) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Connection time out");
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScreenLabRating(
            isSearchnull: isSearchnullval,
            userid: widget.userid,
            name: nameval,
            occupationid: occupationId,
            mobile: mobileno,
            wrkname: wrkname,
            skillid: widget.skillid,
            empid: widget.empid,
          ),
        ),
      );
      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScreenLabRating(
            isSearchnull: isSearchnullval,
            userid: widget.userid,
            name: nameval,
            occupationid: occupationId,
            mobile: mobileno,
            wrkname: wrkname,
            skillid: widget.skillid,
            empid: widget.empid,
          ),
        ),
      );
    }
  }
}
