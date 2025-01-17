import '../../getskillratelist/getskillratelist.dart';
import 'dart:developer';

class GetskillRatedata {
  final String? rate;
  List<Getskillratelist>? ratings;

  GetskillRatedata({this.rate, this.ratings = const []});
  factory GetskillRatedata.fromJson(Map<String, dynamic> json) {
    var list = ((json["ratings"] ?? []) as List);
    log('${list.runtimeType}');
    List<Getskillratelist>? skilllist =
        list.map((e) => Getskillratelist.fromJson(e)).toList();
    return GetskillRatedata(rate: json['rate'].toString(), ratings: skilllist);
  }
}
