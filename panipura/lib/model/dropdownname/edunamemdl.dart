class EduNamemodel {
  final String? name;

  EduNamemodel({required this.name});

  static EduNamemodel fromMap(Map<String, Object?> map) {
    final name = map['name'] as String;
    return EduNamemodel(name: name);
  }

  Map<String, Object?> toMap() => {
        "name": name,
      };
}
