import 'package:panipura/core/hooks/hook.dart';

import 'dart:developer';

abstract class Labourfn {
  Future<List<Getrefskillresplist>> getskillfn(
      BuildContext context, int? userId, String? langcode,int? occupationId);
  Future getsearchdata(Searchlabourmdl value, BuildContext context);
  Future viewprofile(int? value, BuildContext context);
}

class Labempfn implements Labourfn {
  int? rate;
  Labempfn._internal();
  static Labempfn instance = Labempfn._internal();
  factory Labempfn() {
    return instance;
  }

  ValueNotifier<List<Getrefskillresplist>> getSkillListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<Searchlablist>> getSearchListNotifier = ValueNotifier([]);
  ValueNotifier<List<ViewprofileInfo>> viewProfileListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<Getskillratelist>> getSkillrateListNotifier =
      ValueNotifier([]);
  ValueNotifier<String?> gettotalrateListNotifier = ValueNotifier('');
  bool isskillnull = true;
  bool isSearchnull = true;

  // Future<bool?> refresh(int? userId) async{
  //   final _list=await getskillfn(userId);
  //   print(_list);
  //   if(_list==null){

  //     isskillnull=false;

  //     return Future.value(isskillnull);

  //   }else{

  //   _list.sort(
  //     (first,second)=>second.updatedAt!.compareTo(first.createdAt!)
  //   );
  //   getSkillListNotifier.value.clear();
  //   getSkillListNotifier.value.addAll(_list);
  //   getSkillListNotifier.notifyListeners();

  //   // viewProfileListNotifier.value.clear();
  //   // viewProfileListNotifier.notifyListeners();
  //    isskillnull=isskillnull;
  //     return Future.value(isskillnull);
  //   }
  // }

  Future<void> refreshskillUI(
      int? userId, String? langcode, BuildContext context,int? occupationId) async {
    final list = await getskillfn(context, userId, langcode,occupationId);
    getSkillListNotifier.value.clear();
    log('$list');
    if(occupationId==0){
      list.sort((first, second) => second.updatedAt!.compareTo(first.createdAt!));
    //getSkillListNotifier.value.clear();
    getSkillListNotifier.value.addAll(list);
    getSkillListNotifier.notifyListeners();
    }else{
      getSkillListNotifier.value.addAll(list);
    getSkillListNotifier.notifyListeners();
    }
    
  }

  Future<void> refreshRateUI(
      Getskillratereq value, BuildContext context) async {
    final list = await getrateskill(value, context);
    getSkillrateListNotifier.value.clear();
    log('$list');
    list.sort((first, second) => second.updatedAt!.compareTo(first.createdAt!));
    getSkillrateListNotifier.value.addAll(list);
    getSkillrateListNotifier.notifyListeners();
  }

  @override
  Future<List<Getrefskillresplist>> getskillfn(
      BuildContext context, int? userId, String? langcode,int? occupationId) async {
    final skillslistreq = Getskillreq.req(userId: userId, locale: langcode,occupationId: occupationId);
    final skillslistresp = await Labourdata().getskill(skillslistreq);
    if (skillslistresp == null) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Something went wrong");
    } else if (skillslistresp.statusCode == 200) {
      final resultAsjson = jsonDecode(skillslistresp.data);

      final skillsval = Skillsvw.fromJson(resultAsjson as Map<String, dynamic>);
      final status = skillsval.success;
      if (status == true) {
        final listskill = skillsval.data;
        if (listskill == [] || listskill == null) {
          // isskillnull=!isskillnull;
          // return Future.value(isskillnull);
          Fluttertoast.showToast(
              msg: "No skill added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          return listskill;
        }
      } else {
        if (skillsval.message == 'skill view failed') {
          Fluttertoast.showToast(
              msg: "Please add skill",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          //showSnackBar(context, text: "Please add skill");
        } else {
          Fluttertoast.showToast(
              msg: "something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          //showSnackBar(context, text: "something went wrong");
        }
        //return skillsval.data;
      }
    } else if (skillslistresp.statusCode == 404) {
      Fluttertoast.showToast(
          msg: "no data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (skillslistresp.statusCode == 500) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Sever Not Reachable");

      // showLoginerror(context, 3);
    } else if (skillslistresp.statusCode == 408) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Connection time out");

      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
    }
    return [];
    // isskillnull=!isskillnull;
    // return Future.value(isskillnull);
  }

  @override
  Future getsearchdata(Searchlabourmdl value, BuildContext context) async {
    isSearchnull = true;
    final createlabrespval = await Labourdata().searchlab(value);
    //print(createlabrespval);
    if (createlabrespval == null) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Something went wrong");
    } else if (createlabrespval.statusCode == 200) {
      final resultAsjson = jsonDecode(createlabrespval.data);

      final searchval =
          Searchlabresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = searchval.success;
      final data = searchval.data;
      if (status == true && data.isNotEmpty) {
        final searchlab = searchval.data;

        getSearchListNotifier.value.clear();
        getSearchListNotifier.value.addAll(searchlab);
        getSearchListNotifier.notifyListeners();

        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenFilteredLab(
              isSearchnull: isSearchnull,
            ),
          ),
        );
      } else {
        isSearchnull = !isSearchnull;
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenFilteredLab(
              isSearchnull: isSearchnull,
            ),
          ),
        );
      }
    } else if (createlabrespval.statusCode == 404) {
      isSearchnull = !isSearchnull;
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ScreenFilteredLab(
            isSearchnull: isSearchnull,
          ),
        ),
      );
    } else if (createlabrespval.statusCode == 500) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Sever Not Reachable");

      // showLoginerror(context, 3);
    } else if (createlabrespval.statusCode == 408) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Connection time out");

      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
    }
    //return null;
  }

  @override
  Future viewprofile(int? value, BuildContext context) async {
    final profilereq = Getskillreq.req(userId: value);
    final createlabrespval = await Labourdata().viewProfile(profilereq);
    //print(createlabrespval);

    if (createlabrespval == null) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
    } else if (createlabrespval.statusCode == 200) {
      final resultAsjson = jsonDecode(createlabrespval.data);
      final searchval =
          Viewprofileresp.fromJson(resultAsjson as Map<String, dynamic>);
      final status = searchval.success;
      final data = searchval.data;
      if (status == true && data.isNotEmpty) {
        final searchlab = searchval.data;

        viewProfileListNotifier.value.clear();
        viewProfileListNotifier.value.addAll(searchlab);
        viewProfileListNotifier.notifyListeners();
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No Data Found");
      }
    } else if (createlabrespval.statusCode == 404) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "No Data Found");
    } else if (createlabrespval.statusCode == 500) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Sever Not Reachable");

      // showLoginerror(context, 3);
    } else if (createlabrespval.statusCode == 408) {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Connection time out");

      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return;
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
    }
  }

  Future<List<Getskillratelist>> getrateskill(
      Getskillratereq value, BuildContext context) async {
    final rateskillrslt = await Labourdata().getrateskill(value);
    List<Getskillratelist>? data;
    if (rateskillrslt == null) {
      Fluttertoast.showToast(
          msg: "something went rong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (rateskillrslt.statusCode == 200) {
      final resultAsjson = jsonDecode(rateskillrslt.data);
      final registerval =
          GetskillRateresp.fromJson(resultAsjson as Map<String, dynamic>);

      final status = registerval.success;
      if (registerval.data == null) {
        Fluttertoast.showToast(
            msg: "Rating And Review Not Available",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        data = registerval.data!.ratings;
        if (status == true && data != null) {
          // getSkillrateListNotifier.value.clear();
          // getSkillrateListNotifier.value.addAll(data);
          // getSkillrateListNotifier.notifyListeners();
          final totalrate = registerval.data!.rate;
          gettotalrateListNotifier.value = totalrate;
          gettotalrateListNotifier.notifyListeners();

          return data;
        } else {
          Fluttertoast.showToast(
              msg: "Rating And Review Not Available",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          gettotalrateListNotifier.value = '0';
          gettotalrateListNotifier.notifyListeners();
        }
      }
    } else if (rateskillrslt.statusCode == 404) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "No Data Found");
    } else if (rateskillrslt.statusCode == 500) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Sever Not Reachable");

      // showLoginerror(context, 3);
    } else if (rateskillrslt.statusCode == 408) {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Connection time out");

      //showLoginerror(context, 4);
    } else {
      if (!context.mounted) return [];
      CommonFun.instance.showApierror(context, "Something went wrong");
      //showLoginerror(context, 5);
    }
    gettotalrateListNotifier.value = '0';
    gettotalrateListNotifier.notifyListeners();
    return [];
  }
}
