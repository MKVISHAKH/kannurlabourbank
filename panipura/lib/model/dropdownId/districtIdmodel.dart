class DistricIdmodel {
  final int? id;

  DistricIdmodel({required this.id});

  static DistricIdmodel fromMap(Map<String, Object?> map) {
    final id = map['district_id'] as int;
    return DistricIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "district_id": id,
      };
}
