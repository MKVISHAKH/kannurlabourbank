class LocalbdyTypeList {
  final List<Localbdytypemodel>? localtype;

  LocalbdyTypeList({this.localtype});

  factory LocalbdyTypeList.fromJson(List<dynamic> parsedJson) {
    List<Localbdytypemodel> localtype =
        parsedJson.map((i) => Localbdytypemodel.fromJson(i)).toList();
    return LocalbdyTypeList(
      localtype: localtype,
    );
  }
}

class Localbdytypemodel {
  late int? lbtypeid;
  late String? name;

  Localbdytypemodel({this.lbtypeid, this.name});

  factory Localbdytypemodel.fromJson(Map<String, dynamic> json) {
    return Localbdytypemodel(
      lbtypeid: json['lb_type_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "lb_type_id": lbtypeid,
        "name": name,
      };
}
