class EduIdmodel {
  final int? id;

  EduIdmodel({required this.id});

  static EduIdmodel fromMap(Map<String, Object?> map) {
    final id = map['education_id'] as int;
    return EduIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "education_id": id,
      };
}
