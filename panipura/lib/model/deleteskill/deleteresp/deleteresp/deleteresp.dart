import 'package:json_annotation/json_annotation.dart';

part 'deleteresp.g.dart';

@JsonSerializable()
class Deleteresp {
  bool? success;
  String? message;

  Deleteresp({this.message, this.success});

  factory Deleteresp.fromJson(Map<String, dynamic> json) {
    return _$DeleterespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeleterespToJson(this);
}
