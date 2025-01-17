import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';
import 'dart:developer';

class ScreenForgotpswrd extends StatefulWidget {
  final String? mobile;
  final int? category;
  const ScreenForgotpswrd(
      {super.key, required this.mobile, required this.category});

  @override
  State<ScreenForgotpswrd> createState() => _ScreenForgotpswrdState();
}

bool passtoggle = true;
bool cnfrmpasstoggle = true;
bool isVisible = true;
Timer? _timer;
int remainingsec = 0;
final time = '00:0-'.obs;
int start = 180;
bool wait = false;
String type = 'FORGOT_PASSWORD';
String? otppin;

class _ScreenForgotpswrdState extends State<ScreenForgotpswrd> {
  OtpFieldController otpController = OtpFieldController();
  final _formkey2 = GlobalKey<FormState>();
  @override
  void initState() {
    starttimer(start);
    super.initState();
    Future.delayed(Duration.zero, () {
      var po = context.read<FrgtpswrdProvider>();
      po.reset();
      po.initialize(context);
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenLogin(category: widget.category),
      ),
    );
    return true;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var inputPro = context.read<FrgtpswrdProvider>();
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
      },
      child: Stack(
        children: [
          const Screensbackground(),
          Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Appcolors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear_outlined,
                    size: size.height * 0.03,
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Appcolors.magenta,
                  opacity: 0.75,
                ),
              ),
              body: SafeArea(
                  child: Center(
                child: Container(
                  height: size.height,
                  width: size.width,
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Image.asset(
                          'assets/forgotpswrd/6195696pswd.png',
                          height: size.height * 0.25,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.forgot,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: size.height * 0.025,
                              color: Appcolors.magenta,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Form(
                                key: _formkey2,
                                child: FormTextInput(
                                  controller: inputPro.pswrdController,
                                  hint: 'Enter new Password',
                                  label: AppLocalizations.of(context)!.newpswrd,
                                  keyboard: TextInputType.text,
                                  ispassword: true,
                                  isforgot: true,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              FormTextInput(
                                controller: inputPro.cnfrmController,
                                hint: 'Re enter your Password',
                                label: AppLocalizations.of(context)!.cnfrmpswrd,
                                keyboard: TextInputType.text,
                                ispassword: true,
                                isforgot: true,
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Text(
                                AppLocalizations.of(context)!.otpsnd,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Appcolors.magenta,
                                ),
                              ),
                              Text(
                                "+91-${widget.mobile}",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Appcolors.magenta,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              buildotpform(size),
                              SizedBox(
                                height: size.height * 0.012,
                              ),
                              buildtimer(),
                              TextButton(
                                onPressed: () {
                                  if (wait == true) {
                                    starttimer(180);
                                    setState(() {
                                      wait = false;
                                    });
                                    final otpreq = Otprsndreq.req(
                                        mobile: widget.mobile, type: type);
                                    buildotpresend(otpreq,context);
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.rsndotp,
                                  style: const TextStyle(
                                    fontFamily: 'Oswald',
                                    fontSize: 18,
                                    color: Appcolors.magenta,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (inputPro.pswrdController.text.isEmpty) {
                                      showSnackBar(context,
                                          text: "Enter your New Password");
                                    } else if (inputPro.pswrdController.text
                                        .contains(' ')) {
                                      showSnackBar(context,
                                          text:
                                              "Remove space from New Password");
                                    } else if (inputPro
                                            .pswrdController.text.length <
                                        8) {
                                      showSnackBar(context,
                                          text:
                                              "Password Length should be more than 8 characters");
                                    } else if (inputPro
                                        .cnfrmController.text.isEmpty) {
                                      showSnackBar(context,
                                          text: " Re Enter your New Password");
                                    } else if (inputPro.pswrdController.text !=
                                        inputPro.cnfrmController.text) {
                                      showSnackBar(context,
                                          text: "Password mismatch");
                                    } else if (otppin == null) {
                                      showSnackBar(context,
                                          text: "Please enter otp");
                                      //  Fluttertoast.showToast(
                                      //  msg: "please enter otp",
                                      //  toastLength: Toast.LENGTH_SHORT,
                                      //  gravity: ToastGravity.CENTER,
                                      //  timeInSecForIosWeb: 1,
                                      //  backgroundColor: Colors.green,
                                      //  textColor: Colors.white,
                                      //  fontSize: 16.0
                                      //  );
                                    } else {
                                      final otpreq = Rstpswrdvrfy.req(
                                          password:
                                              inputPro.cnfrmController.text,
                                          otp: otppin);
                                      buildotpvrf(otpreq,context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 158, 89, 248),
                                      fixedSize: const Size(200, 60),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text(
                                    AppLocalizations.of(context)!.reset,
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: L10n.getFontSize(
                                            locale.languageCode),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
        ],
      ),
    );
  }

  Widget buildotpform(Size size) {
    return OTPTextField(
      controller: otpController,
      length: 6,
      width: size.width - 34,
      fieldWidth: 55,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.white,
        borderColor: Appcolors.magenta,
        focusBorderColor: Appcolors.magenta,
        enabledBorderColor: Appcolors.magenta,
      ),
      style: const TextStyle(
        fontSize: 17,
        color: Colors.black,
      ),
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

  Future buildotpresend(Otprsndreq value,BuildContext context) async {
    if (widget.category == 1) {
      /*labour resend otp */

      final otpreq = await Labourdata().otpresend(value);

      if (otpreq == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      }  else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, message);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }

      /*------------------------------ */
    } else {
      /*employer resend otp */

      final otpreq = await Labourdata().empotpresend(value);
      if (otpreq == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, message);
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }

      /*------------------------------ */
    }
  }

  Future buildotpvrf(Rstpswrdvrfy value,BuildContext context) async {
    if (widget.category == 1) {
      final otpreq = await Labourdata().forgotpswrdvrfy(value);
      if (otpreq == null) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, message);
        await showDialogsuccess(context);
      }else if (otpreq.statusCode == 404) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } else {
      final otpreq = await Labourdata().empforgotpswrdvrfy(value);
      if (otpreq == null) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, message);
        await showDialogsuccess(context);
      }else if (otpreq.statusCode == 404) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (otpreq.statusCode == 500) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (otpreq.statusCode == 408) {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return ;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
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
      ),
      Obx(() => Center(
            child: Text(time.value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                )),
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

  Future showDialogsuccess(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.pswrdchange,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 2, 129, 6),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ScreenLogin(
                            category: widget.category,
                          ),
                        ),
                      );
                    },
                    child: const Center(child: Text('OK'))),
              ]));
}
