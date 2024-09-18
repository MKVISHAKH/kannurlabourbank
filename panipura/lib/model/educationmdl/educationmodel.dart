class EducationmodelList {
  final List<Educationmodel>? education;

  EducationmodelList({this.education});

  factory EducationmodelList.fromJson(List<dynamic> parsedJson) {
    List<Educationmodel> education =
        parsedJson.map((i) => Educationmodel.fromJson(i)).toList();
    return EducationmodelList(
      education: education,
    );
  }
}

class Educationmodel {
  late int? educationid;
  late String? name;

  Educationmodel({this.educationid, this.name});

  factory Educationmodel.fromJson(Map<String, dynamic> json) {
    return Educationmodel(
      educationid: json['education_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "education_id": educationid,
        "name": name,
      };
}
