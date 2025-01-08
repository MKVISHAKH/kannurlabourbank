import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panipura/api/apidata.dart';
import 'package:panipura/model/get%20skill/getskillreq/getskillreq.dart';
import 'package:panipura/model/viewprofile/viewprofileresp/viewpfofileresp.dart';
import '../model/get skill/getskillresp/getskillsrespmdl.dart';
import '../model/get skill/skilllistmdlref/skillreflistmdl.dart';
import '../model/getskillrate/getskillratereq/getskillratereq.dart';
import '../model/getskillrate/getskillrateresp/getskillratelist/getskillratelist.dart';
import '../model/getskillrate/getskillrateresp/getskillratemain/getskillrateresp/getskillrateresp.dart';
import '../model/searchlabour/searchlablist/searchlablist.dart';
import '../model/searchlabour/searchlabourmdl/searchlabourmdl.dart';
import '../model/searchlabour/searchlabresp/searchlab.dart';
import '../model/viewprofile/viewprofileinfo/viewprofileinfo.dart';
import '../screens/screenemployer/screenfilteredlab.dart';
import 'dart:developer';

abstract class Labourfn {
  Future<List<Getrefskillresplist>> getskillfn(int? userId, String? langcode);
  Future getsearchdata(Searchlabourmdl value, BuildContext? ctx);
  Future viewprofile(int? value);
  
  // Future rateskill(Getskillratereq value,bool? isSearchnullval,String? name,int? wrkId,String? mobile,String? wrkname,BuildContext? ctx);
  //Future deleteskill(Deletereq  value);
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

  Future<void> refreshskillUI(int? userId, String? langcode) async {
    final list = await getskillfn(userId, langcode);
    getSkillListNotifier.value.clear();
    log('$list');
    list
        .sort((first, second) => second.updatedAt!.compareTo(first.createdAt!));
    //getSkillListNotifier.value.clear();
    getSkillListNotifier.value.addAll(list);
    getSkillListNotifier.notifyListeners();
  }

  Future<void> refreshRateUI(Getskillratereq value) async {
    final list = await getrateskill(value);
    getSkillrateListNotifier.value.clear();
    log('$list');
    list
        .sort((first, second) => second.updatedAt!.compareTo(first.createdAt!));
    getSkillrateListNotifier.value.addAll(list);
    getSkillrateListNotifier.notifyListeners();
  }

  @override
  Future<List<Getrefskillresplist>> getskillfn(
      int? userId, String? langcode) async {
    final skillslistreq = Getskillreq.req(userId: userId, locale: langcode);
    final skillslistresp = await Labourdata().getskill(skillslistreq);
    if (skillslistresp == null) {
      Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (skillslistresp.statusCode == 200) {
      final resultAsjson = jsonDecode(skillslistresp.data);

      final skillsval =
          Skillsvw.fromJson(resultAsjson as Map<String, dynamic>);
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
    } else {
      Fluttertoast.showToast(
          msg: "server not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return [];
    // isskillnull=!isskillnull;
    // return Future.value(isskillnull);
  }

  @override
  Future getsearchdata(Searchlabourmdl value, BuildContext? ctx) async {
    isSearchnull = true;
    final createlabrespval = await Labourdata().searchlab(value);
    //print(createlabrespval);

    if (createlabrespval!.statusCode == 200) {
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
        Navigator.of(ctx!).push(
          MaterialPageRoute(
            builder: (ctx) => ScreenFilteredLab(
              isSearchnull: isSearchnull,
            ),
          ),
        );
      } else {
        isSearchnull = !isSearchnull;
        // ignore: use_build_context_synchronously
        Navigator.of(ctx!).push(
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
      Navigator.of(ctx!).push(
        MaterialPageRoute(
          builder: (ctx) => ScreenFilteredLab(
            isSearchnull: isSearchnull,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Server not reached",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    //return null;
  }

  @override
  Future viewprofile(int? value) async {
    final profilereq = Getskillreq.req(userId: value);
    final createlabrespval = await Labourdata().viewProfile(profilereq);
    //print(createlabrespval);

    if (createlabrespval!.statusCode == 200) {
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
        Fluttertoast.showToast(
          msg: "No Data Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      }
    } else if (createlabrespval.statusCode == 404) {
      Fluttertoast.showToast(
          msg: "No Data Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Server not reached",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<List<Getskillratelist>> getrateskill(Getskillratereq value) async {
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
        }
      }
    } else if (rateskillrslt.statusCode == 404) {
      // await showDialogError(_scaffoldKey.currentContext);
      Fluttertoast.showToast(
          msg: "No data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // await showDialogError(_scaffoldKey.currentContext);
      Fluttertoast.showToast(
          msg: "server not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return [];
  }
  
  @override
  Future deleteAccount(int? userId)async {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
