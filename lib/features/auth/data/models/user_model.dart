import 'package:locum_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  String? userTypeStr;
  UserModel({
    super.id,
    super.name,
    super.email,
    super.stateId,
    super.districtId,
    super.token,
    this.userTypeStr,
  }) : super(userType: UserType.fromStr(userTypeStr ?? ''));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email,  stateId: $stateId, districtId: $districtId, token: $token , userTypeStr: $userTypeStr)';
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        stateId: json['state_id'] as int?,
        districtId: json['district_id'] as int?,
        token: json['token'] as String?,
        userTypeStr: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'state_id': stateId,
        'district_id': districtId,
        'token': token,
        'type': userTypeStr,
      };
}
