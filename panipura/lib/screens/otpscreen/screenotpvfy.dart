import 'dart:developer';
import 'package:panipura/core/hooks/hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/widgets/constants.dart';

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
                          style: kScreenText),
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
                            buildotpresend(otpreq);
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
                              buildotpvrf(otpreq);
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
                          )),
                    ),
                  ],
                )),
          ),
        ));
  }

  Future buildotpresend(Otprsndreq value) async {
    if (widget.category == 1) {
      /*labour resend otp */

      final otpreq = await Labourdata().otpresend(value);

      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      /*------------------------------ */
    } else {
      /*employer resend otp */

      final otpreq = await Labourdata().empotpresend(value);
      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        Fluttertoast.showToast(
            msg: message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      /*------------------------------ */
    }
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

  Future buildotpvrf(Otpvrfyreq value) async {
    if (widget.category == 1) {
      /*----labour otp verify---- */

      final otpreq = await Labourdata().otpvrfy(value);

      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        final errorval = otpresp.error;
        Fluttertoast.showToast(
            msg: message ?? errorval!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        await showDialogsuccess(_scaffoldKey.currentContext, widget.category);
        // buildcommonotpvrfy(_resultAsjson);
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      /*--------------------------------- */
    } else {
      /*----employer otp verify----*/

      final otpreq = await Labourdata().empotpvrfy(value);
      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);
        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        final error = otpresp.error;
        Fluttertoast.showToast(
            msg: message ?? error!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        await showDialogsuccess(_scaffoldKey.currentContext, widget.category);
        // buildcommonotpvrfy(_resultAsjson);
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went rong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  Future showDialogsuccess(BuildContext? context, int? catrslt) async =>
      showDialog(
          context: context!,
          builder: (context) => AlertDialog(
                  title: const Text("Registration completed",
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 129, 6),
                          fontFamily: 'RobotoSerif_28pt-Medium')),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          log('$catrslt');
                          if (catrslt == 1) {
                            if(widget.pending==otppending){
                               Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenLogin(category: catrslt)
                              ),
                            );
                            }else if(widget.pending==otpvrfy){
                                 Navigator.pushReplacement(
                                context, Approutes().labhomeScreen);
                            }
                           
                          } else {
                            if(widget.pending==otppending){
                               Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenLogin(category: catrslt)
                              ),
                            );
                            }else if(widget.pending==otpvrfy){
                                 Navigator.pushReplacement(
                                context, Approutes().emphomeScreen);
                            }
                            
                          }
                        },
                        child: const Center(child: Text('OK'))),
                  ]));
}

// class BuildTimer extends GetView<TimerController>{
//   const BuildTimer({Key?key}):super(key:key);
//   @override
//   Widget build(BuildContext context){
//     return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("This otp will expired in ",style:TextStyle(
//                           fontFamily: 'Oswald',
//                           fontSize: 18,
//                           color: Appcolors.magenta,
//                           fontWeight: FontWeight.bold
//                         ),
//                         ),
//                   Obx(() => Center(child: Text(controller.time.value,style:const TextStyle(
//                     fontSize: 18,
//                     color: Colors.red,
//                   )),))

//                 ],
//               );

//   }
// }

// Row buildTimer() {
//     return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("This otp will expired in ",style:TextStyle(
//                             fontFamily: 'Oswald',
//                             fontSize: 18,
//                             color: Color.fromARGB(255, 114, 188, 248),
//                             fontWeight: FontWeight.bold
//                           ),
//                           ),
//                     TweenAnimationBuilder(
//                       tween: Tween(begin:60,end:0),
//                        duration:const Duration(minutes:3),
//                         builder: (context,value,child)=>Text("00:${value.toInt()}",
//                         style:const TextStyle(color: Colors.red),
//                         ),
//                         onEnd: (){},
//                         ),

//                   ],
//                 );
//   }

// child:FormHelper.submitButton(
//                         "Verify",
//                       (){

//                         if(widget.category==1){
//                          Navigator.pushReplacement(context,Approutes().labhomeScreen);
//                         }else{
//                          Navigator.pushReplacement(context,Approutes().emphomeScreen);

//                         }
//                       },
//                       borderColor: const Color.fromARGB(255, 158, 89, 248),
//                       btnColor: const Color.fromARGB(255, 158, 89, 248),
//                       txtColor: Colors.white,
//                       borderRadius: 20
//                       )

// final otpreq= await Labourdata().otpvrfy(value);
//     if(otpreq!.statusCode==200){
//               final _resultAsjson = jsonDecode(otpreq.data);

//              final otpresp= Otpreqresp.fromJson(_resultAsjson as Map<String, dynamic>);
//              final message=otpresp.success;
//       Fluttertoast.showToast(
//             msg: message!,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
//       await showDialogsuccess(_scaffoldKey.currentContext,widget.category);

// }
// else if(otpreq.statusCode==404){
//           Fluttertoast.showToast(
//             msg: "something went rong",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
// }
// return null;

// final otpreq= await Labourdata().otpresend(value);
// if(otpreq!.statusCode==200){
//               final _resultAsjson = jsonDecode(otpreq.data);

//              final otpresp= Otpreqresp.fromJson(_resultAsjson as Map<String, dynamic>);
//              final message=otpresp.success;
//       Fluttertoast.showToast(
//             msg: message!,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );

// }
// else if(otpreq.statusCode==404){
//           Fluttertoast.showToast(
//             msg: "something went rong",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0
//             );
// }
// return null;
