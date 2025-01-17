import '../skillreflistmdl/skillreflistmdlresp.dart';

class Getrefskillresplist {
  int? skillId;
  int? userId;
  int? occupationId;
  String? occupationname;
  String? experience;
  int? wages;
  String? wPeriod;
  String? additionalInfo;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<SkillrefListmdl> references;
  List<dynamic> willingpanchayath;
  String? skillname;
  String? error;
  Getrefskillresplist(
      {this.skillId,
      this.userId,
      this.occupationId,
      this.occupationname,
      this.experience,
      this.wages,
      this.wPeriod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      this.references = const [],
      this.createdAt,
      this.updatedAt,
      this.skillname,
      this.error});

  Getrefskillresplist.req(
      {this.userId,
      this.skillId,
      this.occupationId,
      this.occupationname,
      this.experience,
      this.wages,
      this.wPeriod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      this.references = const [],
      this.createdAt,
      this.updatedAt,
      this.skillname,
      this.error});
  factory Getrefskillresplist.fromJson(Map<String, dynamic> json) {
    var panchlist = ((json["willing_panchayath"] ?? []) as List);
    var list = ((json["references"] ?? []) as List);
    // print(panchlist.runtimeType);
//print(list.runtimeType);
    List<SkillrefListmdl> reflist =
        list.map((e) => SkillrefListmdl.fromMap(e)).toList();
    return Getrefskillresplist(
      userId: json['user_id'],
      skillId: json['skill_id'],
      occupationId: json['occupation_id'],
      occupationname: json['occupation_name'],
      experience: json['experience'],
      wages: json['wages'],
      wPeriod: json['w_period'],
      additionalInfo: json['additional_info'],
      willingpanchayath: panchlist,
      references: reflist,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      error: json['error'],
    );
  }
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "skill_id": skillId,
        "occupation_id": occupationId,
        "occupation_name": occupationname,
        "experience": experience,
        "wages": wages,
        "w_period": wPeriod,
        "additional_info": additionalInfo,
        "willing_panchayath": willingpanchayath,
        "references": references,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "error": error,
      };
}
