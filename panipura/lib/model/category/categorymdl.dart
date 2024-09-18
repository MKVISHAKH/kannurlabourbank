class CategoryIdmodel {
  final int? id;

  CategoryIdmodel({required this.id});

  static CategoryIdmodel fromMap(Map<String, Object?> map) {
    final id = map['occupation_id'] as int;
    return CategoryIdmodel(id: id);
  }

  Map<String, Object?> toMap() => {
        "occupation_id": id,
      };
}
