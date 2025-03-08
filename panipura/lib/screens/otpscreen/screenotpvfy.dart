import 'dart:developer';
import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';

class Screenotpvfy extends StatefulWidget {
  final String? mobileNo;
  final int? category;
  final String? otpHash;
  final int? pending;
  const Screenotpvfy(
      {super.key,
      required this.mobileNo,
      required this.category,
      required this.pending,
      this.otpHash});

  @override
  State<Screenotpvfy> createState() => _ScreenotpvfyState();
}

Timer? _timer;
int remainingsec = 0;
final time = '00:0-'.obs;
int start = 180;
bool wait = false;
String type = 'REGISTRATION';
String? otppin;

class _ScreenotpvfyState extends State<Screenotpvfy> {
  OtpFieldController otpController = OtpFieldController();
  @override
  void initState() {
    //checkUserLoggedIn();
    starttimer(start);
    super.initState();
    // setState(() {
    //   wait=false;
    // });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.put(TimerController());
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Appcolors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.008,
                    ),
                    Row(
                      children: [
                        SizedBox(width: size.width * 0.02),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            iconSize: size.height * 0.04,
                            icon: const Icon(Icons.clear_outlined),
                            color: Appcolors.labelclr),
                        const Spacer(),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: size.width,
                        height: size.height * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/background/e9b33ec8595630e5a2cfaa14eb6784b6.jpg',
                              //'assets/backgroundimg/indian rupees.jpg',
                            ),

                            fit: BoxFit.contain,
                            //colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Center(
                      child: Text(AppLocalizations.of(context)!.otpvrfy,
                          style: kScreenText,
                  textScaler: TextScaler.noScaling,
                          ),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Text(
                      AppLocalizations.of(context)!.otpsnd,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                  textScaler: TextScaler.noScaling,

                    ),
                    Text(
                      "+91-${widget.mobileNo}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Appcolors.magenta,
                      ),
                  textScaler: TextScaler.noScaling,

                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    buildotpform(size),
                    // OtpForm(),
                    SizedBox(
                      height: size.height * 0.012,
                    ),
                    buildtimer(),
                    //const BuildTimer(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (wait == true) {
                            starttimer(180);
                            setState(() {
                              wait = false;
                            });
                            final otpreq = Otprsndreq.req(
                                mobile: widget.mobileNo, type: type);
                            buildotpresend(otpreq, context);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.rsndotp,
                          style: const TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 18,
                            color: Appcolors.magenta,
                          ),
                  textScaler: TextScaler.noScaling,

                        ),
                      ),
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: size.height * 0.075,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (otppin == null) {
                              Fluttertoast.showToast(
                                  msg: AppLocalizations.of(context)!.enterotp,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              final otpreq = Otpvrfyreq.req(
                                  mobile: widget.mobileNo,
                                  otp: otppin,
                                  type: type);
                              buildotpvrf(otpreq, context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 158, 89, 248),
                              fixedSize: const Size(250, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            AppLocalizations.of(context)!.vrfybtn,
                            style: L10n.getbuttonstyle(locale.languageCode),
                  textScaler: TextScaler.noScaling,

                          )),
                    ),
                  ],
                )),
          ),
        ));
  }

  Future buildotpresend(Otprsndreq value, BuildContext context) async {
    if (widget.category == 1) {
      /*labour resend otp */

      final otpreq = await Labourdata().otpresend(value);

      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }

      /*------------------------------ */
    } else {
      /*employer resend otp */

      final otpreq = await Labourdata().empotpresend(value);
      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }

      /*------------------------------ */
    }
  }

  Widget buildotpform(Size size) {
    return OTPTextField(
      controller: otpController,
      length: 6,
      width: size.width - 34,
      fieldWidth: 50,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Appcolors.magenta,
        focusBorderColor: Appcolors.magenta,
        enabledBorderColor: Appcolors.magenta,
      ),
      style: const TextStyle(fontSize: 17),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      // onCompleted: (pin) {
      //   //print(otpController);
      //   print("Completed: " + pin);
      // },
      onChanged: (String? pin) {
        if (pin?.length == 6) {
          //print(pin);
          otppin = pin;
          log('$otppin');
          // final otpreq=Otpvrfyreq.req(
          //   mobile: widget.mobileNo, otp: pin, type: type);
          // buildotpvrf(otpreq);
        }
      },
    );
  }

  Future buildotpvrf(Otpvrfyreq value, BuildContext context) async {
    if (widget.category == 1) {
      /*----labour otp verify---- */

      final otpreq = await Labourdata().otpvrfy(value);

      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        final errorval = otpresp.error;
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message ?? errorval!);
        await showDialogsuccess(context, widget.category);
        // buildcommonotpvrfy(_resultAsjson);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
      /*--------------------------------- */
    } else {
      /*----employer otp verify----*/

      final otpreq = await Labourdata().empotpvrfy(value);
      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        final error = otpresp.error;
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, message ?? error!);
        await showDialogsuccess(context, widget.category);
        // buildcommonotpvrfy(_resultAsjson);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }

      /*--------------------------------- */
    }
  }

  Widget buildtimer() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        AppLocalizations.of(context)!.expired,
        style: const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 18,
            color: Appcolors.magenta,
            fontWeight: FontWeight.bold),
                  textScaler: TextScaler.noScaling,

      ),
      Obx(() => Center(
            child: Text(time.value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
                  textScaler: TextScaler.noScaling,
                ),
          ))
    ]);
  }

  starttimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingsec = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingsec == 0) {
        timer.cancel();
        // wait=false;
        wait = true;
      } else {
        int minutes = remainingsec ~/ 60;
        int seconds = (remainingsec % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingsec--;
      }
    });
  }

  Future showDialogsuccess(BuildContext? context, int? catrslt) async =>
      showDialog(
          context: context!,
          builder: (context) => AlertDialog(
                  title: const Text("Registration completed",
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 129, 6),
                          fontFamily: 'RobotoSerif_28pt-Medium'),
                  textScaler: TextScaler.noScaling,
                          ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          log('$catrslt');
                          if (catrslt == 1) {
                            if (widget.pending == otppending) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        ScreenLogin(category: catrslt)),
                              );
                            } else if (widget.pending == otpvrfy) {
                              Navigator.pushReplacement(
                                  context, Approutes().labhomeScreen);
                            }
                          } else {
                            if (widget.pending == otppending) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        ScreenLogin(category: catrslt)),
                              );
                            } else if (widget.pending == otpvrfy) {
                              Navigator.pushReplacement(
                                  context, Approutes().emphomeScreen);
                            }
                          }
                        },
                        child: const Center(child: Text('OK',
                  textScaler: TextScaler.noScaling,
                        ))),
                  ]));
}
