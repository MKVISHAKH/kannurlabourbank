// import '../../addrefskill/addrefskilllist/addrefskilllist.dart';

class GetEditskillresplist {
  int? skillId;
  int? userId;
  int? occupationId;
  String? occupationname;
  String? experience;
  int? wages;
  String? wPeriod;
  List<String>? willingpanchayath;
  // List<SkillrefListmdl>? references;
  String? additionalInfo;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? skillname;
  String? error;
  String? token;
  int? districtId;
  GetEditskillresplist(
      {this.skillId,
      this.userId,
      this.occupationId,
      this.occupationname,
      this.experience,
      this.wages,
      this.wPeriod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      // this.references = const [],
      this.createdAt,
      this.updatedAt,
      this.skillname,
      this.error,
      this.token,
      this.districtId});

  GetEditskillresplist.req(
      {this.skillId,
      this.userId,
      this.occupationId,
      this.occupationname,
      this.experience,
      this.wages,
      this.wPeriod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      // this.references = const [],
      this.createdAt,
      this.updatedAt,
      this.skillname,
      this.error,
      this.token,
      this.districtId});
  factory GetEditskillresplist.fromJson(Map<String, dynamic> json) {
    // final panchlist=json["willing_panchayath"] as List;
    List<String> panchval =
        List<String>.from(json["willing_panchayath"] as List);
    // final panchayathlist=Willingpanchayath().fromMap(panchlist);
    // final list = json["references"] as List;
    //print(panchval.runtimeType);
    // print(list.runtimeType);
    // List<SkillrefListmdl> reflist =
    //     list.map((e) => SkillrefListmdl.fromMap(e)).toList();
    return GetEditskillresplist(
        userId: json['userId'],
        skillId: json['skillId'],
        occupationId: json['occupationId'],
        occupationname: json['occupationname'],
        experience: json['experience'],
        wages: json['wages'],
        wPeriod: json['wPeriod'],
        additionalInfo: json['additionalInfo'],
        willingpanchayath: panchval,
        // references: reflist,
        token: json['token'],
        districtId: json['districtId']);
  }
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "skillId": skillId,
        "occupationId": occupationId,
        "occupationname": occupationname,
        "experience": experience,
        "wages": wages,
        "wPeriod": wPeriod,
        "additionalInfo": additionalInfo,
        "willing_panchayath": willingpanchayath,
        // "references":references,
        "token": token,
        "districtId": districtId
      };
}
