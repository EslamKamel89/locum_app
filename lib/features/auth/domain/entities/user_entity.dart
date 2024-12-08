class UserEntity {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic stateId;
  dynamic districtId;
  String? token;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.stateId,
    this.districtId,
    this.token,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, stateId: $stateId, districtId: $districtId, token: $token)';
  }
}
