class SkillrefListmdl {
  final int? referenceId;
  final int? userId;
  final int? skillId;
  final String? name;
  final String? mobile;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  SkillrefListmdl(
      {this.referenceId,
      this.userId,
      this.skillId,
      this.name,
      this.mobile,
      this.updatedAt,
      this.createdAt});

  static SkillrefListmdl fromMap(Map<String, dynamic> map) {
    final refereceId = map['reference_id'] as int;
    final userId = map['user_id'] as int;
    final skillId = map['skill_id'] as int;
    final name = map['name'] as String;
    final mobile = map['mobile'] as String;

    final updatedAt = map['updated_at'] == null
        ? null
        : DateTime.parse(map['updated_at'] as String);

    final createdAt = map['created_at'] == null
        ? null
        : DateTime.parse(map['created_at'] as String);

    return SkillrefListmdl(
        referenceId: refereceId,
        userId: userId,
        skillId: skillId,
        name: name,
        mobile: mobile,
        updatedAt: updatedAt,
        createdAt: createdAt);
  }

  Map<String, dynamic> toMap() => {
        "reference_id": referenceId,
        "user_id": userId,
        "skill_id": skillId,
        "name": name,
        "mobile": mobile,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String()
      };
}
