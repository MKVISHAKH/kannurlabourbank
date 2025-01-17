import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetchoccupation.g.dart';

@JsonSerializable()
class Fetchoccupation {
  bool? success;
  List<Datum>? data;
  String? message;

  Fetchoccupation({this.success, this.data, this.message});

  factory Fetchoccupation.fromJson(Map<String, dynamic> json) {
    return _$FetchoccupationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetchoccupationToJson(this);
}
