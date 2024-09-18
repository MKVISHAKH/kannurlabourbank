import 'package:panipura/model/todolist/gettodolist/gettodolist.dart';
import 'dart:developer';

class Addtodoresp {
  bool? success;
  List<Gettodolist>? data;
  String? message;
  Addtodoresp({this.success, this.data = const [], this.message});
  factory Addtodoresp.fromJson(Map<String, dynamic> json) {
    var data = ((json["data"] ?? []) as List);
    List<Gettodolist>? todolist =
        data.map((e) => Gettodolist.fromJson(e)).toList();
    log('${data.runtimeType}');

    return Addtodoresp(
      success: json['success'],
      message: json['message'],
      data: todolist,
    );
  }
  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
