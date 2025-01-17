import 'package:panipura/core/hooks/hook.dart';

import 'dart:developer';

class ScreensplashThree extends StatefulWidget {
  const ScreensplashThree({super.key});

  @override
  State<ScreensplashThree> createState() => _ScreensplashThreeState();
}

class _ScreensplashThreeState extends State<ScreensplashThree> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Stack(key: _scaffoldKey, children: [
      const Backgroundsplash(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 300),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage("assets/splash/panchayath_logo.png"),
                    ),
                    //Text("Loading")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().homeScreen);
    getdeviceinform();
  }

  Future<void> checkUserLoggedIn() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(savekeyname);

    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin();
    } else {
      final value = await Sharedata.instance.getdata();
      if (value!.category == 1) {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (ctx1) => const Screenlabhome(),
          ),
        );
      } else if (value.category == 2) {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
          MaterialPageRoute(
            builder: (ctx1) => const ScreenEmployerHome(),
          ),
        );
      } else {
        gotoLogin();
      }
    }
  }

  Future<void> getdeviceinform() async {
    try {
      /*************deviceinfo*****************/
      final device = await DeviceInformation.getdeviceinfo();
      log(device);
      final deviceos = await DeviceInformation.getOSdetails();
      log(deviceos);
      final devicescreen = await DeviceInformation.getScreenResolution();
      log(devicescreen);
      final deviceversion = await DeviceInformation.getDeviceVersion();
      log(deviceversion);
      final packagename = await Appinfo.getpackageName();
      log(packagename);
      final appversion = await Appinfo.getappVersion();
      log(appversion);
      /*****************************************/

      final shareddevice = Deviceinfo(
          phone: device,
          phoneos: deviceos,
          screenresolution: devicescreen,
          osversion: deviceversion,
          packagename: packagename,
          appversion: appversion);
      await Sharedata.instance.setdeviceinfo(shareddevice);
    } catch (e) {
      //showSnackBar(_scaffoldKey.currentContext!, text: 'Connection Time Out');
      Navigator.pushReplacement(
          _scaffoldKey.currentContext!, Approutes().homeScreen);
    }
  }
}
