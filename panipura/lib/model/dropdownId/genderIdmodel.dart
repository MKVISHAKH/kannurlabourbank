class GenderIdmodel {
  final int? id;

  GenderIdmodel({required this.id});

  static GenderIdmodel fromMap(Map<String, Object?> map) {
    final id = map['gender_id'] as int;
    return GenderIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "gender_id": id,
      };
}
