import '../searchlablist/searchlablist.dart';
import 'dart:developer';

class Searchlabresp {
  final bool? success;
  final String? message;
  List<Searchlablist> data;
  Searchlabresp({this.success, this.message, this.data = const []});
  factory Searchlabresp.fromJson(Map<String, dynamic> json) {
    var list = ((json["data"] ?? []) as List);
    log('${list.runtimeType}');
    List<Searchlablist> searchlist =
        list.map((e) => Searchlablist.fromJson(e)).toList();
    return Searchlabresp(
        success: json['success'], message: json['message'], data: searchlist);
  }
}
