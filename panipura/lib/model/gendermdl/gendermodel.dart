class GendermodelList {
  final List<Gendermodel>? gender;

  GendermodelList({this.gender});

  factory GendermodelList.fromJson(List<dynamic> parsedJson) {
    List<Gendermodel> gender =
        parsedJson.map((i) => Gendermodel.fromJson(i)).toList();
    return GendermodelList(
      gender: gender,
    );
  }
}

class Gendermodel {
  late int? genderid;
  late String? name;

  Gendermodel({this.genderid, this.name});

  factory Gendermodel.fromJson(Map<String, dynamic> json) {
    return Gendermodel(
      genderid: json['gender_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "gender_id": genderid,
        "name": name,
      };
}
