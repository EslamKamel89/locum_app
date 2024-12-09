enum UserType {
  hospital,
  doctor;

  static UserType fromStr(String userType) {
    return userType == 'doctor' ? UserType.doctor : UserType.hospital;
  }

  @override
  String toString() {
    return this == UserType.doctor ? 'doctor' : 'hospital';
  }
}

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
  UserType? userType;

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
    this.userType,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, stateId: $stateId, districtId: $districtId, token: $token , userType: $userType)';
  }
}
