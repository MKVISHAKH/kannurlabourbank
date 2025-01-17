import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetcheducation.g.dart';

@JsonSerializable()
class Fetcheducation {
  bool? success;
  List<Datum>? data;
  String? message;

  Fetcheducation({this.success, this.data, this.message});

  factory Fetcheducation.fromJson(Map<String, dynamic> json) {
    return _$FetcheducationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetcheducationToJson(this);
}
