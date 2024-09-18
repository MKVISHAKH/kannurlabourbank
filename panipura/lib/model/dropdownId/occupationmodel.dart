class WrkIdmodel {
  final int? id;

  WrkIdmodel({required this.id});

  static WrkIdmodel fromMap(Map<String, Object?> map) {
    final id = map['occupation_id'] as int;
    return WrkIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "occupation_id": id,
      };
}
