
class LocaltypeIdmodel {
  final int? id;

  LocaltypeIdmodel({required this.id});

  static LocaltypeIdmodel fromMap(Map<String, Object?> map) {
    final id = map['lb_type_id'] as int;
    return LocaltypeIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "lb_type_id": id,
      };
}
