
class LocalbdyIdmodel {
  final int? id;

  LocalbdyIdmodel({required this.id});

  static LocalbdyIdmodel fromMap(Map<String, Object?> map) {
    final id = map['localbody_id'] as int;
    return LocalbdyIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "localbody_id": id,
      };
}
