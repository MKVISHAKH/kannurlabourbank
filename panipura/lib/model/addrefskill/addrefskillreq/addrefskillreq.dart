import '../addrefskilllist/addrefskilllist.dart';

class Addrefskillreq {
  final int? userId;
  final int? skillId;
  final int? occupationId;
  String? experience;
  String? wages;
  String? wperiod;
  String? additionalInfo;
  List<dynamic> willingpanchayath;
  List<Addrefskilllist> references;
  Addrefskillreq(
      {this.userId,
      this.skillId,
      this.occupationId,
      this.experience,
      this.wages,
      this.wperiod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      this.references = const []});
  Addrefskillreq.req(
      {this.userId,
      this.skillId,
      this.occupationId,
      this.experience,
      this.wages,
      this.wperiod,
      this.additionalInfo,
      this.willingpanchayath = const [],
      this.references = const []});
  factory Addrefskillreq.fromJson(Map<String, dynamic> json) {
    var panchlist = json["willing_panchayath"] as List;
    var list = json["references"] as List;
//print(panchlist.runtimeType);
//print(list.runtimeType);
    List<Addrefskilllist> reflist =
        list.map((e) => Addrefskilllist.fromJson(e)).toList();
    return Addrefskillreq(
        userId: json['user_id'],
        skillId: json['skill_id'],
        occupationId: json['occupation_id'],
        experience: json['experience'],
        wages: json['wages'],
        wperiod: json['w_period'],
        additionalInfo: json['additional_info'],
        willingpanchayath: panchlist,
        references: reflist);
  }
  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "skill_id": skillId,
        "occupation_id": occupationId,
        "experience": experience,
        "wages": wages,
        "w_period": wperiod,
        "additional_info": additionalInfo,
        "willing_panchayath": willingpanchayath,
        "references": references
      };
}
