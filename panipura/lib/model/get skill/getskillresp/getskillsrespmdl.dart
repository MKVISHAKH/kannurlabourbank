import '../skilllistmdlref/skillreflistmdl.dart';

class Skillsvw {
  final bool? success;
  final String? message;
  List<Getrefskillresplist>? data;
  Skillsvw({this.success, this.message, this.data = const []});
  factory Skillsvw.fromJson(Map<String, dynamic> json) {
    var list = json["data"] as List;
    // print(list.runtimeType);
    List<Getrefskillresplist>? skilllist =
        list.map((e) => Getrefskillresplist.fromJson(e)).toList();
    return Skillsvw(
        success: json['success'], message: json['message'], data: skilllist);
  }
}

// import '../skillslistmdl/skillslistmdl.dart';

// class Skillsvw {
//   final bool? success;
//   final String? message;
//   List<Skillslistmdl>? data;
//   Skillsvw({this.success, this.message, this.data = const []});
//   factory Skillsvw.fromJson(Map<String, dynamic> json) {
//     var list = json["data"] as List;
//     print(list.runtimeType);
//     List<Skillslistmdl>? skilllist =
//         list.map((e) => Skillslistmdl.fromJson(e)).toList();
//     return Skillsvw(
//         success: json['success'], message: json['message'], data: skilllist);
//   }
// }
