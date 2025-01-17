import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetchlocalbody.g.dart';

@JsonSerializable()
class Fetchlocalbody {
  bool? success;
  List<Datum>? data;
  String? message;

  Fetchlocalbody({this.success, this.data, this.message});

  factory Fetchlocalbody.fromJson(Map<String, dynamic> json) {
    return _$FetchlocalbodyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetchlocalbodyToJson(this);
}
