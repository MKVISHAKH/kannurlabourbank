// import 'getskillratedata.dart';

// class GetskillRateresp {
//   final bool? success;
//   final String? message;
//   GetskillRatedata? data;
//   GetskillRateresp({this.success, this.message, this.data});
//   factory GetskillRateresp.fromJson(Map<String, dynamic> json) {
//     var list=json['data'] == null
//           ? null
//           : GetskillRatedata.fromJson(json['data'] as Map<String, dynamic>),
//     return GetskillRateresp(
//         success: json['success'], message: json['message'],data:list);
//   }
// }

// import '../getskillratelist/getskillratelist.dart';

// class GetskillRateresp {
//   final bool? success;
//   final String? message;
//   List<Getskillratelist>? data;
//   GetskillRateresp({this.success, this.message, this.data = const []});
//   factory GetskillRateresp.fromJson(Map<String, dynamic> json) {
//     var list = ((json["data"]??[]) as List);
//     //  var panchlist=((json["willing_panchayath"]??[]) as List);
//     print(list.runtimeType);
//     List<Getskillratelist>? skilllist =
//         list.map((e) => Getskillratelist.fromJson(e)).toList();
//     return GetskillRateresp(
//         success: json['success'], message: json['message'], data: skilllist);
//   }
// }
