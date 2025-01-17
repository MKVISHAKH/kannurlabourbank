class DistrictmodelList {
  final List<Districtmodel>? district;

  DistrictmodelList({this.district});

  factory DistrictmodelList.fromJson(List<dynamic> parsedJson) {
    List<Districtmodel> district =
        parsedJson.map((i) => Districtmodel.fromJson(i)).toList();
    return DistrictmodelList(
      district: district,
    );
  }
}

class Districtmodel {
  int? districtid;
  String? name;
  String? nameMl;

  Districtmodel({this.districtid, this.name, this.nameMl});

  factory Districtmodel.fromJson(Map<String, dynamic> json) {
    return Districtmodel(
      districtid: json['district_id'],
      name: json['name'],
      nameMl: json['name_ml'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"district_id": districtid, "name": name, "name_ml": nameMl};
}
