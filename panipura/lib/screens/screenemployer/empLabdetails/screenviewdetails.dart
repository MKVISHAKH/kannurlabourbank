import 'package:intl/intl.dart';
import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class Screenviewprofile extends StatefulWidget {
  const Screenviewprofile(
      {super.key,
      required this.isSearchnull,
      required this.userid,
      required this.name,
      required this.occupationid,
      required this.mobile,
      required this.localecode});
  final bool? isSearchnull;
  final int? userid;
  final String? name;
  final int? occupationid;
  final String? mobile;
  final String? localecode;
  @override
  State<Screenviewprofile> createState() => _ScreenviewprofileState();
}

class _ScreenviewprofileState extends State<Screenviewprofile> {
  String? labname;
  bool isempty = true;
  bool? isSkillnull;

  String? gendername;
  String? distname;
  String? localtype;
  String? localbdyname;
  String? eduname;
  String? demandinfo;
  String? langcode;
  Locale? localecode;
  String? ref1;
  String? ref2;
  String? mob1;
  String? mob2;
  int? empid;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      var po = context.read<CallProvider>();
      po.reset();
    });
    labname = widget.name!.toUpperCase();
    Labempfn.instance.refreshskillUI(widget.userid, widget.localecode, context,widget.occupationid);
    Labempfn.instance.viewprofile(widget.userid, context);
  }

  Future callalertbox(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text(
                    '${AppLocalizations.of(context)!.docall} $labname ?',
                    style: const TextStyle(
                        color: Appcolors.labelclr, fontSize: 18))),
            content: buildTandC(),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.cancel,
                    style: const TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 89, 248),
                ),
                onPressed: () async {
                  var pro = context.read<CallProvider>();
                  final value = pro.isAccepted;
                  if (value == true) {
                    await FlutterPhoneDirectCaller.callNumber(widget.mobile!);

                    final labid = widget.userid;
                    final value = await Sharedata.instance.getdata();

                    final empid = value!.userid;
                    DateTime now = DateTime.now();

                    String formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                    final usrmob = widget.mobile;
                    final logreq = Contactlog(
                        userId: labid,
                        employerId: empid,
                        contactTime: formattedDate,
                        usrMob: usrmob);
                    // ignore: use_build_context_synchronously
                    buildcontactlog(logreq, context);
                  } else {
                    showSnackBar(context,
                        text: "Please accept our privacy and policy");
                  }
                },
                child: Text(AppLocalizations.of(context)!.call,
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ));
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            ScreenFilteredLab(isSearchnull: widget.isSearchnull),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Stack(
      key: _scaffoldKey,
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
                            builder: (context) => ScreenFilteredLab(
                                isSearchnull: widget.isSearchnull),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 158, 89, 248),
                      )),
                ),
                centerTitle: true,
                title: Text(AppLocalizations.of(context)!.det,
                    style: L10n.getappbarSize(locale.languageCode)),
                backgroundColor: Colors.white,
                actions: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                          onTap: () {
                            var po = context.read<CallProvider>();
                            po.reset();

                            callalertbox(context);
                          },
                          child: const Icon(Icons.call,
                              color: Color.fromARGB(255, 158, 89, 248)))),
                  //  Icon(Icons.call,color:Color.fromARGB(255, 158, 89, 248))
                ],
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
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 0.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(AppLocalizations.of(context)!.personalinfo,
                            style: L10n.getappbarSize(locale.languageCode)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        child: buildCrntDet(),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              var po = context.read<CallProvider>();
                              po.reset();

                              callalertbox(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 158, 89, 248),
                                fixedSize: const Size(180, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(AppLocalizations.of(context)!.makecall,
                                    style: L10n.getbuttonstyle(
                                        locale.languageCode)),
                                const Icon(Icons.call)
                              ],
                            )),
                      ),
                      /* ************* */
                      Expanded(child: buildviewskills()),
                      // TextButton(onPressed: (){
                      //   buildviewskills();
                      //   // getskillsdet(widget.userid);
                      // }, child:const Text('Skill Details:',style:kbodyfont))
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCrntDet() {
    return ValueListenableBuilder(
        valueListenable: Labempfn.instance.viewProfileListNotifier,
        builder:
            (BuildContext context, List<ViewprofileInfo> newList, Widget? _) {
          // getname(newList);

          if (newList.isNotEmpty) {
            isempty = true;
            isempty = !isempty;
          }
          return isempty
              ? const CircularProgressIndicator()
              : Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(0.4),
                    2: FlexColumnWidth(4),
                  },
                  border: null,
                  children: [
                    //getname(),

                    buildRow([
                      AppLocalizations.of(context)!.nameemp,
                      ':',
                      newList.single.name ?? ''
                    ]),
                    buildRow([
                      AppLocalizations.of(context)!.genderemp,
                      ':',
                      newList.single.gendername ?? ''
                    ]),
                    // buildRow([
                    //   AppLocalizations.of(context)!.addressemp,
                    //   ':',
                    //   newList.single.address as String
                    // ]),
                    buildRow([
                      AppLocalizations.of(context)!.placeemp,
                      ':',
                      newList.single.place ?? ''
                    ]),
                    // buildRow([
                    //   AppLocalizations.of(context)!.postemp,
                    //   ':',
                    //   newList.single.post as String
                    // ]),
                    // buildRow(['Pin',':',newList.single.pin as String]),
                    // buildRow(['Date of Birth',':',newList.single.dob as String]),
                    // buildRow(['MobileNO',':',newList.single.mobile as String]),
                    // buildRow([
                    //   AppLocalizations.of(context)!.educat,
                    //   ':',
                    //   newList.single.eduname as String
                    // ]),
                    buildRow([
                      AppLocalizations.of(context)!.districtemp,
                      ':',
                      newList.single.disname ?? ''
                    ]),
                    // buildRow([
                    //   AppLocalizations.of(context)!.localtypename,
                    //   ':',
                    //   newList.single.localtypename??''
                    // ]),
                    buildRow([
                      AppLocalizations.of(context)!.localnameemp,
                      ':',
                      '${newList.single.localname!.toUpperCase()} ${newList.single.localtypename ?? ''}'
                    ]),
                  ],
                );
        });
  }

  Widget buildTandC() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenCallPandP(
                isSearchnull: widget.isSearchnull,
                userid: widget.userid,
                name: widget.name,
                occupationid: widget.occupationid,
                mobile: widget.mobile,
                localecode: widget.localecode,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(
                  unselectedWidgetColor:
                      const Color.fromARGB(255, 101, 47, 248)),
              child: Consumer<CallProvider>(
                builder: (context, check, _) => Checkbox(
                    value: check.isAccepted,
                    checkColor: const Color.fromARGB(255, 101, 47, 248),
                    activeColor: Colors.white,
                    onChanged: (value) {
                      log('$value');
                      check.setAccepted(value!);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenCallPandP(
                            isSearchnull: widget.isSearchnull,
                            userid: widget.userid,
                            name: widget.name,
                            occupationid: widget.occupationid,
                            mobile: widget.mobile,
                            localecode: widget.localecode,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.acptpp,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //buildCrntDet.dispose();
  }

  TableRow buildRow(List<String> cells) => TableRow(
        children: cells.map((cell) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              cell,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      );

  //  Future getskillsdet(int? userId)async{
  //     isSkillnull=await Labempfn.instance.refresh(userId) ;
  //     if(isSkillnull==true){
  //       buildviewskills();
  //     }

  //  }
  Widget buildviewskills() => ValueListenableBuilder(
      valueListenable: Labempfn.instance.getSkillListNotifier,
      builder:
          (BuildContext context, List<Getrefskillresplist> newList, Widget? _) {
        // getname(newList);
        return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (ctx, index) {
              final val = newList[index];
              final wages = val.wages;
              final per = val.wPeriod;

              if (val.references.isEmpty) {
                mob1 = '';
                mob2 = '';
                ref1 = '';
                ref2 = '';
              } else {
                if (val.references.length == 2) {
                  ref1 = val.references[0].name!;
                  mob1 = val.references[0].mobile!;
                  ref2 = val.references[1].name!;
                  mob2 = val.references[1].mobile!;
                } else {
                  ref1 = val.references[0].name!;
                  mob1 = val.references[0].mobile!;
                  // _referenceperson2controller.text = '';
                  // _mobileno2controller.text = '';
                }
              }

              final demandval = val.additionalInfo;
              if (demandval == null) {
                demandinfo = 'No demands';
              }

              //demandinfo=demandval.toString();
              //  }
              else {
                demandinfo = val.additionalInfo.toString();
              }
              String wageval = wages.toString();

              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 101, 47, 248))),
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: 275,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(5.3),
                              1: FlexColumnWidth(0.3),
                              2: FlexColumnWidth(4),
                            },
                            border: null,
                            children: [
                              //getname(),

                              buildRow1([
                                AppLocalizations.of(context)!.skill,
                                ':',
                                val.occupationname!
                              ]),
                              buildRow1([
                                AppLocalizations.of(context)!.expemp,
                                ':',
                                '${val.experience as String} ${AppLocalizations.of(context)!.year}'
                              ]),
                              buildRow1([
                                AppLocalizations.of(context)!.remunaration,
                                ':',
                                '(₹) $wageval'
                              ]),
                              buildRow1(['Per (Hour/Day)', ':', '(₹) $per']),
                              buildRow1([
                                AppLocalizations.of(context)!.other,
                                ':',
                                demandinfo as String
                              ]),
                              val.references.isNotEmpty
                                  ? val.references.length == 2
                                      ? buildRow1([
                                          AppLocalizations.of(context)!
                                              .reference1,
                                          ':',
                                          ref1 ?? ''
                                        ])
                                      : buildRow1([
                                          AppLocalizations.of(context)!
                                              .reference1,
                                          ':',
                                          ref1 ?? ''
                                        ])
                                  : buildRow1([' ', ' ', ' ']),
                              val.references.isNotEmpty
                                  ? val.references.length == 2
                                      ? buildRow1([
                                          AppLocalizations.of(context)!.mob,
                                          ':',
                                          mob1 ?? ''
                                        ])
                                      : buildRow1([
                                          AppLocalizations.of(context)!.mob,
                                          ':',
                                          mob1 ?? ''
                                        ])
                                  : buildRow1([' ', ' ', ' ']),
                              val.references.isNotEmpty
                                  ? val.references.length == 2
                                      ? buildRow1([
                                          AppLocalizations.of(context)!
                                              .reference2,
                                          ':',
                                          ref2 ?? ''
                                        ])
                                      : buildRow1([' ', ' ', ' '])
                                  : buildRow1([' ', ' ', ' ']),
                              val.references.isNotEmpty
                                  ? val.references.length == 2
                                      ? buildRow1([
                                          AppLocalizations.of(context)!.mob,
                                          ':',
                                          mob2 ?? ''
                                        ])
                                      : buildRow1([' ', ' ', ' '])
                                  : buildRow1([' ', ' ', ' ']),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () async {
                            final value = await Sharedata.instance.getdata();
                            empid = value!.userid;
                            if (!context.mounted) return;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ScreenLabRating(
                                  isSearchnull: widget.isSearchnull,
                                  userid: widget.userid,
                                  name: widget.name,
                                  occupationid: widget.occupationid,
                                  mobile: widget.mobile,
                                  wrkname: val.occupationname,
                                  skillid: val.skillId,
                                  empid: empid,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.ratervw,
                            style: const TextStyle(
                                color: Appcolors.labelclr, fontSize: 16),
                          )),
                    ],
                  ));
            },
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 5,
                )),
            itemCount: newList.length);
      });

  TableRow buildRow1(List<String> cells) => TableRow(
        children: cells.map((cell) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              cell,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      );

  Future buildcontactlog(Contactlog value, BuildContext context) async {
    final contactresp = await Labourdata().contactlog(value);
    if (contactresp == null) {
      log('$contactresp');
    } else if (contactresp.statusCode == 200) {
      final resultAsjson = jsonDecode(contactresp.data);
      final logval =
          Contactlogresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = logval.success;
      final message = logval.message;
      if (status == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Screenviewprofile(
              isSearchnull: widget.isSearchnull,
              userid: widget.userid,
              name: widget.name,
              occupationid: widget.occupationid,
              mobile: widget.mobile,
              localecode: widget.localecode,
            ),
          ),
        );
        log('$message');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Screenviewprofile(
              isSearchnull: widget.isSearchnull,
              userid: widget.userid,
              name: widget.name,
              occupationid: widget.occupationid,
              mobile: widget.mobile,
              localecode: widget.localecode,
            ),
          ),
        );
        log('$message');
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Screenviewprofile(
            isSearchnull: widget.isSearchnull,
            userid: widget.userid,
            name: widget.name,
            occupationid: widget.occupationid,
            mobile: widget.mobile,
            localecode: widget.localecode,
          ),
        ),
      );
      log('${contactresp.statusCode}');
    }
  }
}
