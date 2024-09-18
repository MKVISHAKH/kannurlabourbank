class LocalbodiesList {
  final List<Localbodiesmodel>? localbodies;

  LocalbodiesList({this.localbodies});

  factory LocalbodiesList.fromJson(List<dynamic> parsedJson) {
    List<Localbodiesmodel> localbodies =
        parsedJson.map((i) => Localbodiesmodel.fromJson(i)).toList();
    return LocalbodiesList(
      localbodies: localbodies,
    );
  }
}

class Localbodiesmodel {
  late int? localbodyid;
  late int? districtid;
  late int? lbtypeid;
  late String? name;

  Localbodiesmodel(
      {this.localbodyid, this.districtid, this.lbtypeid, this.name});

  factory Localbodiesmodel.fromJson(Map<String, dynamic> json) {
    return Localbodiesmodel(
      localbodyid: json['localbody_id'],
      districtid: json['district_id'],
      lbtypeid: json['lb_type_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "localbody_id": localbodyid,
        "district_id": districtid,
        "lb_type_id": lbtypeid,
        "name": name,
      };
}
