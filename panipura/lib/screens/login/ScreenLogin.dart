import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:panipura/screens/forgotpswrd/forgotpswrd.dart';

class ScreenLogin extends StatefulWidget {
  final int? category;
  const ScreenLogin({super.key, required this.category});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String? mobileNo;
  final _mobilenocontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool passtoggle = true;
  bool? status;
  String? message;
  String? genderName;
  String? districtName;
  String? localtypeName;
  String? localbodyName;
  String? eduName;
  String category = '';
  String type = 'FORGOT_PASSWORD';
  int? userId;
  Locale? localecode;

  final _formkey1 = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    //checkUserLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializedata();
    });
    super.initState();
    final cat = widget.category;
    if (cat == 1) {
      setState(() {
        category = "LABOUR";
      });
    } else {
      setState(() {
        category = "EMPLOYER";
      });
    }
    log('$cat');
  }

  void initializedata() {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    localecode = provider.locale;
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScreenHome(),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).platformBrightness==Brightness.light;
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          //if (didPop) return;
          await popscreen(context);
        }
      },
      child: Stack(
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
                        Navigator.pushReplacement(_scaffoldKey.currentContext!,
                            Approutes().homeScreen);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Appcolors.fontclr,
                      )),
                ),
                centerTitle: true,
                title: Text(
                  category == "LABOUR"
                      ? AppLocalizations.of(context)!.buttonlabour
                      : AppLocalizations.of(context)!.buttonemployer,
                  style: L10n.getappbarSize(locale.languageCode),
                  textScaler: TextScaler.noScaling,
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 160,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/background/istockphoto-1246021208-612x612.jpg',
                              //'assets/backgroundimg/indian rupees.jpg',
                            ),

                            fit: BoxFit.contain,
                            //colorFilter: ColorFilter.mode(Colors.white12, BlendMode.darken),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.loginwith,
                        style: kBodyText,
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.noScaling,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.entermobile,
                        style: const TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        textScaler: TextScaler.noScaling,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formkey1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 18, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Container(
                                        height: 50,
                                        width: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 3, 30),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 158, 89, 248),
                                            )),
                                        child: const Center(
                                          child: Text("+91",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 101, 47, 248),
                                                  fontWeight: FontWeight.bold),
                                                  textScaler: TextScaler.noScaling,),
                                        ))),
                                Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                    maxLines: 1,
                                    maxLength: 10,
                                    controller: _mobilenocontroller,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.black),
                                    // style:kBodyText,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 20),
                                      labelText:
                                          AppLocalizations.of(context)!.mobile,
                                      labelStyle: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 101, 47, 248)),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 158, 89, 248),
                                            width: 1),
                                      ),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 89, 248),
                                        width: 1,
                                      )),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 89, 248),
                                        width: 1,
                                      )),
                                    ),
                                    onChanged: (String value) {
                                      if (value.length == 10) {
                                        mobileNo = value;
                                      }
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter mobile Number";
                                      } else if (value.length < 10 ||
                                          value.length > 10) {
                                        return "Enter valid Mobile number";
                                      } else if (value.contains(".") ||
                                          value.contains(",") ||
                                          value.contains("-") ||
                                          value.contains(" ")) {
                                        return "Enter valid Mobile number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 25.0),
                              child: TextFormField(
                                // maxLines: 1,
                                // maxLength: 10,
                                controller: _passwordcontroller,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: Colors.black),
                                //style:kBodyText,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  fillColor: Colors.white,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 89, 248),
                                        width: 1),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 158, 89, 248),
                                    width: 1,
                                  )),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 158, 89, 248),
                                    width: 1,
                                  )),
                                  labelText:
                                      AppLocalizations.of(context)!.passwrd,
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 101, 47, 248),),
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(Icons.lock,
                                        color:
                                            Color.fromARGB(255, 101, 47, 248)),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        passtoggle = !passtoggle;
                                      });
                                    },
                                    child: Icon(
                                      passtoggle
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color.fromARGB(
                                          255, 101, 47, 248),
                                    ),
                                  ),
                                ),
                                obscureText: passtoggle,
                                textInputAction: TextInputAction.done,

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  } else if (_passwordcontroller.text.length <
                                      8) {
                                    return "Please Enter more than 8 characters";
                                  } else if (_passwordcontroller.text
                                      .contains(' ')) {
                                    return "Remove space from password";
                                  }
                                  return null;
                                },

                                // onChanged: (String value){
                                //   if(value.length>9){
                                //     mobileNo=value;
                                //   }
                                // },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight / 1.1,
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.forgot,
                                style: const TextStyle(
                                  fontFamily: 'Oswald',
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 101, 47, 248),
                                ),
                                textScaler: TextScaler.noScaling,
                              ),
                              onPressed: () {
                                if (mobileNo == null) {
                                  showSnackBar(context,
                                      text: "Enter Mobile Number");
                                } else if (mobileNo!.contains(".") ||
                                    mobileNo!.contains(",") ||
                                    mobileNo!.contains("-") ||
                                    mobileNo!.contains(" ")) {
                                  showSnackBar(context,
                                      text: "Enter Valid MobileNo");
                                } else {
                                  final otpreq =
                                      Otprsndreq.req(mobile: mobileNo);
                                  buildotp(otpreq, context);
                                }

                                //Navigator.push(context,Approutes().forgotpswrdScreen);
                              },
                            ),
                          ),
                        const SizedBox(height: 10),
                        Consumer<LoadingProvider>(
                        builder: (context, loadingProvider, child) {
                        return loadingProvider.isLoading
                              ? const Center(
                              child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 101, 47, 248),
                              ),
                              ),
                            )
                            : const SizedBox.shrink();
                            }),
                          const SizedBox(height: 10),
                          // Center(
                          //     child: FormHelper.submitButton(
                          //         AppLocalizations.of(context)!.go, () async {
                          //   if (_formkey1.currentState!.validate()) {
                          //     //goto otp screen
                          //     await buildloginUser(context);
                          //   }
                          // },
                          //         borderColor:
                          //             const Color.fromARGB(255, 158, 89, 248),
                          //         btnColor:
                          //             const Color.fromARGB(255, 158, 89, 248),
                          //         txtColor: Colors.white,
                          //         borderRadius: 20)),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async{
                           if (_formkey1.currentState!.validate()) {
                                //goto otp screen
                                await buildloginUser(context);
                              }
                          },
                          style: ElevatedButton.styleFrom(
                            // side: const BorderSide(
                            //   width: 3.0,
                            //   color: Appcolors.labelclr,
                            // ),
                            backgroundColor: Appcolors.magenta,
                            fixedSize: const Size(150, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!.go,
                                  textAlign: TextAlign.center,
                                  style: kButtonText,
                                  textScaler: TextScaler.noScaling,)),
                        ),
                      ),
                     const SizedBox(height: 10,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.noaccount,
                                    style: const TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 101, 47, 248),
                                    ),
                                    textScaler: TextScaler.noScaling,
                                  ),
                                ),
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.signup,
                                    style: const TextStyle(
                                      fontFamily: 'Oswald',
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 101, 47, 248),
                                    ),
                                    textScaler: TextScaler.noScaling,
                                  ),
                                  onPressed: () {
                                    if (widget.category == lab) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ScreenRegister(
                                            category: widget.category,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ScreenRegister(
                                            category: widget.category,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mobilenocontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  Future buildloginUser(BuildContext context) async {
    final loadingProvider=context.read<LoadingProvider>();
    loadingProvider.toggleLoading();
    final mobileNo = _mobilenocontroller.text;
    final passwrd = _passwordcontroller.text;

    final logreq = Loginreq.create(mobile: mobileNo, password: passwrd);
    loadingProvider.toggleLoading();
    
    if (widget.category == 1) {
      final logresp = await Labourdata().login(logreq);
      if (logresp == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (logresp.statusCode == 200) {
        final resultAsjson = jsonDecode(logresp.data);
        if (!context.mounted) return;
        buildloginlab(resultAsjson, context);
      } else if (logresp.statusCode == 404) {
        await showLoginerror(_scaffoldKey.currentContext);
        // await showDialoglogin(_scaffoldKey.currentContext);
      } else if (logresp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (logresp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } else {
      final logresp = await Labourdata().emplogin(logreq);
      if (logresp == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (logresp.statusCode == 200) {
        final resultAsjson = jsonDecode(logresp.data);
        if (!context.mounted) return;
        buildloginlab(resultAsjson, context);
      } else if (logresp.statusCode == 404) {
        if (!context.mounted) return;

        await showLoginerror(context);
        // await showDialoglogin(_scaffoldKey.currentContext);
      } else if (logresp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (logresp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    }
  }

  Future buildloginlab(dynamic loginvalue, BuildContext context) async {
    final mobileNo = _mobilenocontroller.text;
    final passwrd = _passwordcontroller.text;
    final loginval = Loginresp.fromJson(loginvalue as Map<String, dynamic>);
    if (loginval.data == null) {
      Fluttertoast.showToast(
          msg: "Login data is missing",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    status = loginval.success;
    if (status == true) {
      final userId = widget.category == 1
          ? loginval.data!.userId
          : loginval.data!.employerId;
      //final userId=loginval.data!.userId;
      final token = loginval.data!.token;
      final name = loginval.data!.name;
      final mobile = loginval.data!.mobile;
      final address = loginval.data!.address;
      final place = loginval.data!.place;
      final post = loginval.data!.post;
      final pincode = loginval.data!.pin;

      final genderNameval = await LabourDb.instance
          .getGenderName(loginval.data!.genderId, localecode, context);

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
      if (!context.mounted) return;

      final districtNameval = await LabourDb.instance
          .getDistrictName(loginval.data!.districtId, localecode, context);

      for (var map in districtNameval) {
        final dist = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            districtName = dist.nameml;
            log('$districtName');
          } else {
            districtName = dist.name;
            log('$districtName');
          }
        });
      }
      if (!context.mounted) return;

      final typeNameval = await LabourDb.instance
          .getLocalbdytypeName(loginval.data!.blockId, localecode, context);

      for (var map in typeNameval) {
        final type = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            localtypeName = type.nameml;
            log('$localtypeName');
          } else {
            localtypeName = type.name;
            log('$localtypeName');
          }
        });
      }
      if (!context.mounted) return;

      final localbdyNameval = await LabourDb.instance.getLocalbodyName(
          loginval.data!.districtId,
          loginval.data!.blockId,
          loginval.data!.localbodyId,
          localecode,
          context);

      for (var map in localbdyNameval) {
        final lclbody = Namemodel.fromMap(map);
        setState(() {
          if (localecode == Locale('ml')) {
            localbodyName = lclbody.nameml;
            log('$localbodyName');
          } else {
            localbodyName = lclbody.name;
            log('$localbodyName');
          }
        });
      }
      if (loginval.data!.educationId == null) {
        eduName = '';
      } else {
        if (!context.mounted) return;
        final eduNameval = await LabourDb.instance
            .getEduName(loginval.data!.educationId, localecode, context);

        for (var map in eduNameval) {
          final edu = Namemodel.fromMap(map);
          setState(() {
            if (localecode == Locale('ml')) {
              eduName = edu.nameml;
              log('$eduName');
            } else {
              eduName = edu.name;
              log('$eduName');
            }
          });
        }
      }

      final dob = loginval.data!.dob;
      final adhaarno = loginval.data!.aadhaar;
      final category = loginval.data!.category;

      final sharedval = SharedtokenM.values(
          userid: userId,
          token: token,
          name: name,
          mobile: mobile,
          address: address,
          place: place,
          post: post,
          pin: pincode,
          gender: genderName,
          genderId: loginval.data!.genderId,
          district: districtName,
          distId: loginval.data!.districtId,
          block: localtypeName,
          blockId: loginval.data!.blockId,
          localbody: localbodyName,
          localbodyId: loginval.data!.localbodyId,
          dob: dob,
          aadhaar: adhaarno,
          education: eduName,
          educationId: loginval.data!.educationId,
          category: category,
          password: passwrd);

      await Sharedata.instance.setdata(sharedval);
      /* ************************************* */

      message = loginval.message;
      if (category == widget.category) {
        if (category == 1) {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const Screenlabhome(),
            ),
          );

          CommonFun.instance.showApierror(context, message);
        } else {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const ScreenEmployerHome(),
            ),
          );

          //if (!context.mounted) return ;
          CommonFun.instance.showApierror(context, message);
        }
      } else {
        if (category == 1) {
          if (!context.mounted) return;

          await showDialogemployer(context);
        } else {
          if (!context.mounted) return;

          await showDialoglabour(context);
        }
      }
    } else {
      final pendingreg = loginval.data!.mobileverified;
      final error = loginval.data!.error;
      final catval = widget.category;
      if (pendingreg == 'N') {
        await showOtppending(context, mobileNo, catval);
      } else if (error == 'Unauthorised') {
        if (!context.mounted) return;
        CommonFun.instance
            .showApierror(context, "Username or Password incorrect");
        // showSnackBar(context, text: "Username or Password incorrect");
      }
    }
  }

  Future showOtppending(
          BuildContext? context, String? mobile, int? catrslt) async =>
      showDialog(
          context: context!,
          builder: (context) => AlertDialog(
                  title: const Text("Please verify OTP ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 2, 129, 6),
                          fontFamily: 'RobotoSerif_28pt-Medium'),
                          textScaler: TextScaler.noScaling,),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          log('$catrslt');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => Screenotpvfy(
                                mobileNo: mobile,
                                category: catrslt,
                                pending: otppending,
                              ),
                            ),
                          );
                        },
                        child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
                  ]));

  Future showLoginerror(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text('No Data Found',textScaler: TextScaler.noScaling,
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenLogin(
                              category: widget.category,
                            ),
                          ),
                        ),
                    child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
              ]));

  Future showDialoglabour(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text(
                  'Your Are Not Registered Labour.\n Please Register',textScaler: TextScaler.noScaling,
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenLogin(
                              category: widget.category,
                            ),
                          ),
                        ),
                    child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
              ]));

  Future showDialogemployer(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text(
                  'Your Are Not Registered Employer.\n Please Register',textScaler: TextScaler.noScaling,
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 26, 10),
                      fontFamily: 'RobotoSerif_28pt-Medium')),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ScreenLogin(
                              category: widget.category,
                            ),
                          ),
                        ),
                    child: const Center(child: Text('OK',textScaler: TextScaler.noScaling,))),
              ]));

  Future buildotp(Otprsndreq value, BuildContext context) async {
    if (widget.category == 1) {
      final otpreq = await Labourdata().forgotpswrd(value);
      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if (message == null) {
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "Enter Valid Mobile Number");
        } else {
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, message);
          //if (!context.mounted) return;
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ScreenForgotpswrd(
                      mobile: mobileNo,
                      category: widget.category,
                    )),
          );
        }
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
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
    } else {
      final otpreq = await Labourdata().empforgotpswrd(value);
      if (otpreq == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        //final error = otpresp.error;
        if (message == null) {
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "Enter Valid Mobile Number");
        } else {
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, message);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ScreenForgotpswrd(
                      mobile: mobileNo,
                      category: widget.category,
                    )),
          );
        }
      } else if (otpreq.statusCode == 404) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
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
    }
  }
}
