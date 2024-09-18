class Namemodel {
  final String? name;
  final String? nameml;

  Namemodel({this.name, this.nameml});

  static Namemodel fromMap(Map<String, Object?> map) {
    final name = map['name'] == null ? ' ' : map['name'] as String;
    final nameml = map['name_ml'] == null ? ' ' : map['name_ml'] as String;
    return Namemodel(name: name, nameml: nameml);
  }

  Map<String, Object?> toMap() => {
        "name": name,
        "name_ml": nameml,
      };
}
