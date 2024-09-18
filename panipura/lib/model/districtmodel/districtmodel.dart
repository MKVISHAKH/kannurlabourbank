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
  late int? districtid;
  late String? name;

  Districtmodel({this.districtid, this.name});

  factory Districtmodel.fromJson(Map<String, dynamic> json) {
    return Districtmodel(
      districtid: json['district_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "district_id": districtid,
        "name": name,
      };
}
