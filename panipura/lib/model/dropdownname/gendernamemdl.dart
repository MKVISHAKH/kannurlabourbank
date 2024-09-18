class GenderNamemodel {
  final String? name;

  GenderNamemodel({required this.name});

  static GenderNamemodel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    return GenderNamemodel(name: name);
  }

  Map<String, Object?> toMap() => {
        "name": name,
      };
}
