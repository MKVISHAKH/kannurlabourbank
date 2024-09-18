import 'package:panipura/core/hooks/hook.dart';
import 'package:panipura/l10n/l10n.dart';
import 'package:panipura/model/loginmodel/loginreq/loginreq.dart';
import 'package:panipura/model/loginmodel/loginresp/loginresp.dart';
import 'package:panipura/provider/locale_provider.dart';
import 'package:panipura/screens/forgotpswrd/forgotpswrd.dart';
import 'package:panipura/screens/otpscreen/screenotpvfy.dart';
import '../database/labourdb.dart';
import '../model/dropdownname/namemdl.dart';
import '../widgets/constants.dart';
import 'screenlabour/Screenregister.dart';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            if (!didPop){
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
                                                  fontWeight: FontWeight.bold)),
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
                                      color: Color.fromARGB(255, 101, 47, 248)),
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
                                  buildotp(otpreq);
                                  // Navigator.of(context).push(
                                  //          MaterialPageRoute(
                                  //            builder: (context) => ScreenForgotpswrd(mobile: mobileNo)
                                  //           ),
                                  //         );
                                }

                                //Navigator.push(context,Approutes().forgotpswrdScreen);
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                              child: FormHelper.submitButton(
                                  AppLocalizations.of(context)!.go, () async {
                            if (_formkey1.currentState!.validate()) {
                              //goto otp screen
                              await buildloginUser(context);
                            }
                          },
                                  borderColor:
                                      const Color.fromARGB(255, 158, 89, 248),
                                  btnColor:
                                      const Color.fromARGB(255, 158, 89, 248),
                                  txtColor: Colors.white,
                                  borderRadius: 20)),
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
    final mobileNo = _mobilenocontroller.text;
    final passwrd = _passwordcontroller.text;

    final logreq = Loginreq.create(mobile: mobileNo, password: passwrd);

    if (widget.category == 1) {
      final logresp = await Labourdata().login(logreq);
      if (logresp == null) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (logresp.statusCode == 200) {
        final resultAsjson = jsonDecode(logresp.data);
        buildloginlab(resultAsjson);
      } else if (logresp.statusCode == 404) {
        await showLoginerror(_scaffoldKey.currentContext);
        // await showDialoglogin(_scaffoldKey.currentContext);
      } else {
        await showLoginerror(_scaffoldKey.currentContext);
      }
    } else {
      final logresp = await Labourdata().emplogin(logreq);
      if (logresp == null) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (logresp.statusCode == 200) {
        final resultAsjson = jsonDecode(logresp.data);
        buildloginlab(resultAsjson);
      } else if (logresp.statusCode == 404) {
        await showLoginerror(_scaffoldKey.currentContext);
        // await showDialoglogin(_scaffoldKey.currentContext);
      } else {
        await showLoginerror(_scaffoldKey.currentContext);
      }
    }
  }

  Future buildloginlab(dynamic loginvalue) async {
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
          fontSize: 16.0
        );
        return;
      }
    status = loginval.success;
    if (status == true) {
      /*set data into shared preference */
      // if (widget.category == 1) {
      //   userId = loginval.data!.userId;
      // } else {
      //   userId = loginval.data!.employerId;
      // }
      final userId = widget.category == 1 ? loginval.data!.userId : loginval.data!.employerId;
      //final userId=loginval.data!.userId;
      final token = loginval.data!.token;
      final name = loginval.data!.name;
      final mobile = loginval.data!.mobile;
      final address = loginval.data!.address;
      final place = loginval.data!.place;
      final post = loginval.data!.post;
      final pincode = loginval.data!.pin;

      final genderNameval = await LabourDb.instance
          .getGenderName(loginval.data!.genderId, localecode);

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
      final districtNameval = await LabourDb.instance
          .getDistrictName(loginval.data!.districtId, localecode);

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
      final typeNameval = await LabourDb.instance
          .getLocalbdytypeName(loginval.data!.blockId, localecode);

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

      final localbdyNameval = await LabourDb.instance
          .getLocalbodyName(loginval.data!.localbodyId, localecode);

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

      final eduNameval = await LabourDb.instance
          .getEduName(loginval.data!.educationId, localecode);

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
          Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const Screenlabhome(),
            ),
          );
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: const Color.fromARGB(255, 22, 177, 28),
              fontSize: 16.0);
        } else {
          Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const ScreenEmployerHome(),
            ),
          );
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: const Color.fromARGB(255, 22, 177, 28),
              fontSize: 16.0);
        }
      } else {
        if (category == 1) {
          await showDialogemployer(_scaffoldKey.currentContext);
        } else {
          await showDialoglabour(_scaffoldKey.currentContext);
        }
      }
    } else {
      final pendingreg = loginval.data!.mobileverified;
      final error = loginval.data!.error;
      final catval = widget.category;
      if (pendingreg == 'N') {
        await showOtppending(_scaffoldKey.currentContext, mobileNo, catval);
      } else if (error == 'Unauthorised') {
        Fluttertoast.showToast(
            msg: "Username or Password incorrect",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
                          fontFamily: 'RobotoSerif_28pt-Medium')),
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
                        child: const Center(child: Text('OK'))),
                  ]));

  Future showLoginerror(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text('Server Not reached',
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
                    child: const Center(child: Text('OK'))),
              ]));

  Future showDialoglabour(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text(
                  'Your Are Not Registered Labour.\n Please Register',
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
                    child: const Center(child: Text('OK'))),
              ]));

  Future showDialogemployer(BuildContext? context) async => showDialog(
      context: context!,
      builder: (context) => AlertDialog(
              title: const Text(
                  'Your Are Not Registered Employer.\n Please Register',
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
                    child: const Center(child: Text('OK'))),
              ]));

  Future buildotp(Otprsndreq value) async {
    if (widget.category == 1) {
      final otpreq = await Labourdata().forgotpswrd(value);
      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        if(message==null){
          Fluttertoast.showToast(
            msg:"Enter Valid Mobile Number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        }else{
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(_scaffoldKey.currentContext!).push(
          MaterialPageRoute(
              builder: (context) => ScreenForgotpswrd(
                    mobile: mobileNo,
                    category: widget.category,
                  )),
        );
        }
        
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      final otpreq = await Labourdata().empforgotpswrd(value);
      if (otpreq == null) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (otpreq.statusCode == 200) {
        final resultAsjson = jsonDecode(otpreq.data);

        final otpresp =
            Otpreqresp.fromJson(resultAsjson as Map<String, dynamic>);
        final message = otpresp.success;
        //final error = otpresp.error;
        if(message==null){
          Fluttertoast.showToast(
            msg:"Enter Valid Mobile Number",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        }else{
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(_scaffoldKey.currentContext!).push(
          MaterialPageRoute(
              builder: (context) => ScreenForgotpswrd(
                    mobile: mobileNo,
                    category: widget.category,
                  )),
        );
        }
      } else if (otpreq.statusCode == 404) {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}

// final logresp=await Labourdata().login(logreq);

// if(logresp!.statusCode==200){
//     final _resultAsjson = jsonDecode(logresp.data);

//     final loginval= Loginresp.fromJson(_resultAsjson as Map<String, dynamic>);
//     status=loginval.success;
//     if(status==true){
//       /*set data into shared preference */
//       final userId=loginval.data!.userId;
//       final token=loginval.data!.token;
//       final name=loginval.data!.name;
//       final mobile=loginval.data!.mobile;
//       final address=loginval.data!.address;
//       final place=loginval.data!.place;
//       final post=loginval.data!.post;
//       final pincode=loginval.data!.pin;

//       final genderNameval=await LabourDb.instance.getGenderName(loginval.data!.genderId);

//                  for(var map in genderNameval){
//                             final gender=Namemodel.fromMap(map);
//                             setState(() {
//                               genderName=gender.name;
//                               print(genderName);
//                             });

//                  }
//       final districtNameval=await LabourDb.instance.getDistrictName(loginval.data!.districtId);

//                  for(var map in districtNameval){
//                             final dist=Namemodel.fromMap(map);
//                             setState(() {
//                               districtName=dist.name;
//                               print(districtName);
//                             });

//                  }
//       final typeNameval=await LabourDb.instance.getLocalbdytypeName(loginval.data!.blockId);

//                  for(var map in typeNameval){
//                             final type=Namemodel.fromMap(map);
//                             setState(() {
//                               localtypeName=type.name;
//                               print(localtypeName);
//                             });

//                  }

//       final localbdyNameval=await LabourDb.instance.getLocalbodyName(loginval.data!.localbodyId);

//                  for(var map in localbdyNameval){
//                             final lclbody=Namemodel.fromMap(map);
//                             setState(() {
//                               localbodyName=lclbody.name;
//                               print(localbodyName);
//                             });

//                  }

//       final eduNameval=await LabourDb.instance.getEduName(loginval.data!.educationId);

//                  for(var map in eduNameval){
//                             final edu=Namemodel.fromMap(map);
//                             setState(() {
//                               eduName=edu.name;
//                               print(eduName);
//                             });

//                  }

//       final dob=loginval.data!.dob;
//       final adhaarno=loginval.data!.aadhaar;
//       final category=loginval.data!.category;

//       final sharedval=SharedtokenM.values(
//              userid: userId,
//               token: token,
//                name: name,
//                mobile:mobile,
//                address:address,
//                 place:place,
//                 post:post,
//                 pin:pincode,
//                 gender:genderName,
//                 district:districtName,
//                 block:localtypeName,
//                 localbody:localbodyName,
//                 dob:dob,
//                 aadhaar:adhaarno,
//                 education:eduName,
//                 category:category,
//                 password:passwrd
//                );

//                await Sharedata.instance.setdata(sharedval);
//              /* ************************************* */

//               message=loginval.message;
//               if(category==widget.category){
//                  if(category==1){
//                   // Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                   //                         MaterialPageRoute(
//                   //                           builder: (ctx) =>  ScreenOtpverify(mobileNo: mobileNo,category: widget.category,),
//                   //                         ),
//                   //                       );
//                 Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                                           MaterialPageRoute(
//                                             builder: (ctx) => const Screenlabhome(),
//                                           ),
//                                         );
//                 Fluttertoast.showToast(
//                 msg: "$message",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.white,
//                 textColor:const Color.fromARGB(255, 22, 177, 28),
//                 fontSize: 16.0);
//               }else{
//                 //  Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                 //                           MaterialPageRoute(
//                 //                             builder: (ctx) =>  ScreenOtpverify(mobileNo: mobileNo,category: widget.category,),
//                 //                           ),
//                 //                         );

//                 Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
//                                           MaterialPageRoute(
//                                             builder: (ctx) => const ScreenEmployerHome(),
//                                           ),
//                                         );
//                 Fluttertoast.showToast(
//                 msg: "$message",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.white,
//                 textColor:const Color.fromARGB(255, 22, 177, 28),
//                 fontSize: 16.0);
//               }
//               }else{
//                 if(category==1){
//                   await showDialogemployer(_scaffoldKey.currentContext);

//                 }else{
//                   await showDialoglabour(_scaffoldKey.currentContext);
//                 }
//               }

//     }else{
//       Fluttertoast.showToast(
//         msg: "Username or Password incorrect",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//     }
// }else if(logresp.statusCode==404){

//   Fluttertoast.showToast(
//         msg: "Server not reached",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//         );
//  // await showDialoglogin(_scaffoldKey.currentContext);
// }else{
//   await showDialoglogin(_scaffoldKey.currentContext);
// }
