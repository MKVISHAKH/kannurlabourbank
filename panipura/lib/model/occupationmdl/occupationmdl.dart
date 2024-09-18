class OccupationList {
  final List<Occupationmodel>? occupationmdl;

  OccupationList({this.occupationmdl});

  factory OccupationList.fromJson(List<dynamic> parsedJson) {
    List<Occupationmodel> occupationmdl =
        parsedJson.map((i) => Occupationmodel.fromJson(i)).toList();
    return OccupationList(
      occupationmdl: occupationmdl,
    );
  }
}

class Occupationmodel {
  late int? occupationid;
  late String? name;

  Occupationmodel({this.occupationid, this.name});

  factory Occupationmodel.fromJson(Map<String, dynamic> json) {
    return Occupationmodel(
      occupationid: json['occupation_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "occupation_id": occupationid,
        "name": name,
      };
}
