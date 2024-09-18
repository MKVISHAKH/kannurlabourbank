class LocalTypeNamemodel {
  final String? name;

  LocalTypeNamemodel({required this.name});

  static LocalTypeNamemodel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    return LocalTypeNamemodel(name: name);
  }

  Map<String, Object?> toMap() => {
        "name": name,
      };
}
