import 'getskillratedata.dart';

// part 'getskillrateresp.g.dart';

// @JsonSerializable()
// class Getskillrateresp {
//   bool? success;
//   GetskillRatedata? data;
//   String? message;

//   Getskillrateresp({this.success, this.data, this.message});

//   factory Getskillrateresp.fromJson(Map<String, dynamic> json) {
//     return _$GetskillraterespFromJson(json);
//   }

//   Map<String, dynamic> toJson() => _$GetskillraterespToJson(this);
// }

class GetskillRateresp {
  final bool? success;
  final String? message;
  GetskillRatedata? data;
  GetskillRateresp({this.success, this.message, this.data});
  factory GetskillRateresp.fromJson(Map<String, dynamic> json) {
    var list = json['data'] == null
        ? null
        : GetskillRatedata.fromJson(json['data'] as Map<String, dynamic>);
    return GetskillRateresp(
        success: json['success'], message: json['message'], data: list);
  }
}
