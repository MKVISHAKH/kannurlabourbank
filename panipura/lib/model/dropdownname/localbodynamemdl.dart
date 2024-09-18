class LocalbodyNamemodel {
  final String? name;

  LocalbodyNamemodel({required this.name});

  static LocalbodyNamemodel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    return LocalbodyNamemodel(name: name);
  }

  Map<String, Object?> toMap() => {
        "name": name,
      };
}
