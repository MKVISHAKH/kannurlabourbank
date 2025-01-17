import 'package:panipura/core/hooks/hook.dart';

import 'dart:developer';

class Sharedata {
  //---singleton-----
  Sharedata._internal();
  static Sharedata instance = Sharedata._internal();
  Sharedata factory() {
    return instance;
  }
  //----end singleton

  Future<void> setdata(SharedtokenM value) async {
    if (value.token == null) {
      return;
    }
    if (value.name == null) {
      return;
    }
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savekeyname, true);
    await sharedprefes.setString('TOKEN', value.token!);
    await sharedprefes.setString('NAME', value.name!);
    await sharedprefes.setString('MOBILE', value.mobile!);
    await sharedprefes.setString('ADDRESS', value.address!);
    await sharedprefes.setString('PLACE', value.place!);
    await sharedprefes.setString('POST', value.post!);
    await sharedprefes.setString('PIN', value.pin!);
    await sharedprefes.setString('GENDER', value.gender ?? '');
    await sharedprefes.setInt('GENDERID', value.genderId ?? 0);
    await sharedprefes.setString('DISTRICT', value.district ?? '');
    await sharedprefes.setInt('DISTRICTID', value.distId ?? 0);
    await sharedprefes.setString('TYPE', value.block ?? '');
    await sharedprefes.setInt('TYPEID', value.blockId ?? 0);
    await sharedprefes.setString('LOCALBODY', value.localbody ?? '');
    await sharedprefes.setInt('LOCALBODYID', value.localbodyId ?? 0);
    await sharedprefes.setString('DOB', value.dob!);
    // if(value.aadhaar==null){
    //   value.aadhaar=='';
    // }
    await sharedprefes.setString('AADHAAR', value.aadhaar!);
    await sharedprefes.setInt('CATEGORY', value.category!);
    if (value.category == lab) {
      await sharedprefes.setString('EDUCATION', value.education ?? '');
      await sharedprefes.setInt('EDUCATIONID', value.educationId ?? 0);
    }
    await sharedprefes.setString('PASSWORD', value.password!);
    await sharedprefes.setInt('USERID', value.userid!);
  }

  Future<SharedtokenM?> getdata() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('MOBILE');
    log('$checkValue');
    final token = sharedprefs.getString('TOKEN') ?? '';

    final name = sharedprefs.getString('NAME') ?? '';

    final mobile = sharedprefs.getString('MOBILE') ?? '';

    final address = sharedprefs.getString('ADDRESS') ?? '';

    final place = sharedprefs.getString('PLACE') ?? '';

    final post = sharedprefs.getString('POST') ?? '';

    final pin = sharedprefs.getString('PIN') ?? '';

    final gender = sharedprefs.getString('GENDER') ?? '';

    final genderId = sharedprefs.getInt('GENDERID') ?? 0;

    final district = sharedprefs.getString('DISTRICT') ?? '';

    final distId = sharedprefs.getInt('DISTRICTID') ?? 0;

    final type = sharedprefs.getString('TYPE') ?? '';

    final typeid = sharedprefs.getInt('TYPEID') ?? 0;

    final localbody = sharedprefs.getString('LOCALBODY') ?? '';

    final localbodyid = sharedprefs.getInt('LOCALBODYID') ?? 0;

    final dob = sharedprefs.getString('DOB') ?? '';

    final aadhaar = sharedprefs.getString('AADHAAR') ?? '';

    final category = sharedprefs.getInt('CATEGORY') ?? 0;

    final education = sharedprefs.getString('EDUCATION') ?? '';

    final educationid = sharedprefs.getInt('EDUCATIONID') ?? 0;

    final password = sharedprefs.getString('PASSWORD') ?? '';

    final userid = sharedprefs.getInt('USERID') ?? 0;

    final valshared = SharedtokenM.values(
        token: token,
        userid: userid,
        name: name,
        mobile: mobile,
        address: address,
        place: place,
        post: post,
        pin: pin,
        gender: gender,
        genderId: genderId,
        district: district,
        distId: distId,
        block: type,
        blockId: typeid,
        localbody: localbody,
        localbodyId: localbodyid,
        dob: dob,
        aadhaar: aadhaar,
        education: education,
        educationId: educationid,
        category: category,
        password: password);
    return valshared;
  }

  Future<void> cleardata() async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.remove('TOKEN');
    await sharedprefes.remove('NAME');
    await sharedprefes.remove('MOBILE');
    await sharedprefes.remove('ADDRESS');
    await sharedprefes.remove('PLACE');
    await sharedprefes.remove('POST');
    await sharedprefes.remove('PIN');
    await sharedprefes.remove('GENDER');
    await sharedprefes.remove('GENDERID');
    await sharedprefes.remove('DISTRICT');
    await sharedprefes.remove('DISTRICTID');
    await sharedprefes.remove('TYPE');
    await sharedprefes.remove('TYPEID');
    await sharedprefes.remove('LOCALBODY');
    await sharedprefes.remove('LOCALBODYID');
    await sharedprefes.remove('DOB');
    await sharedprefes.remove('AADHAAR');
    await sharedprefes.remove('CATEGORY');
    await sharedprefes.remove('EDUCATION');
    await sharedprefes.remove('EDUCATIONID');
    await sharedprefes.remove('PASSWORD');
    await sharedprefes.remove('USERID');
  }

  Future<void> setlocale(String locale) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savelocalekey, true);
    await sharedprefes.setString('LOCALE', locale);
  }

  Future<String> getlocale() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('LOCALE');
    log('$checkValue');
    final locale = sharedprefs.getString('LOCALE') ?? '';
    log('$checkValue');
    return locale;
  }

  Future<void> setdeviceinfo(Deviceinfo value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savedeviceinfo, true);
    await sharedprefes.setString('DEVICE', value.phone ?? '');
    await sharedprefes.setString('DEVICEOS', value.phoneos ?? '');
    await sharedprefes.setString(
        'SCREENRESOLUTION', value.screenresolution ?? '');
    await sharedprefes.setString('DEVICEVERSION', value.osversion ?? '');
    await sharedprefes.setString('PACKAGENAME', value.packagename ?? '');
    await sharedprefes.setString('APPVERSION', value.appversion ?? '');
  }

  Future<Deviceinfo> getdeviceinfo() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('DEVICE');
    log('$checkValue');
    final device = sharedprefs.getString('DEVICE') ?? '';
    final deviceos = sharedprefs.getString('DEVICEOS') ?? '';
    final screenres = sharedprefs.getString('SCREENRESOLUTION') ?? '';
    final deviceversion = sharedprefs.getString('DEVICEVERSION') ?? '';
    final packagename = sharedprefs.getString('PACKAGENAME') ?? '';
    final appversion = sharedprefs.getString('APPVERSION') ?? '';

    final infoshared = Deviceinfo(
        phone: device,
        phoneos: deviceos,
        screenresolution: screenres,
        osversion: deviceversion,
        packagename: packagename,
        appversion: appversion);

    return infoshared;
  }
}
