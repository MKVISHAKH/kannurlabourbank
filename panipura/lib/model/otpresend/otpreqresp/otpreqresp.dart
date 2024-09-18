import 'package:json_annotation/json_annotation.dart';

part 'otpreqresp.g.dart';

@JsonSerializable()
class Otpreqresp {
  String? success;
  String? error;

  Otpreqresp({this.success, this.error});

  factory Otpreqresp.fromJson(Map<String, dynamic> json) {
    return _$OtpreqrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OtpreqrespToJson(this);
}
