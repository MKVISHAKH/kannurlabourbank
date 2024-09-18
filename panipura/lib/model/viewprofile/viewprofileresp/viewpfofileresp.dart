import 'package:panipura/model/viewprofile/viewprofileinfo/viewprofileinfo.dart';
import 'dart:developer';

class Viewprofileresp {
  final bool? success;
  final String? message;
  List<ViewprofileInfo> data;
  Viewprofileresp({this.success, this.message, this.data = const []});
  factory Viewprofileresp.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    log('${list.runtimeType}');
    List<ViewprofileInfo> searchlist =
        list.map((e) => ViewprofileInfo.fromJson(e)).toList();
    return Viewprofileresp(
        success: json['success'], message: json['message'], data: searchlist);
  }
}
