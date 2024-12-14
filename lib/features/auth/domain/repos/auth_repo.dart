// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/user_type_enum.dart';
import 'package:locum_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> signIn(
      {required String email, required String password});
  Future<Either<Failure, UserModel>> signup(SignUpParams params);
}

class SignUpParams {
  String? name;
  String? email;
  String? password;
  int? stateId;
  int? districtId;
  UserTypeEnum? userType;
  SignUpParams({
    this.name,
    this.email,
    this.password,
    this.stateId,
    this.districtId,
    this.userType,
  });

  Map<String, dynamic> toMap() {
    if (districtId == null) {
      return <String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'state_id': stateId,
        'type': userType?.toShortString(),
      };
    }
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'state_id': stateId,
      'district_id': districtId,
      'type': userType?.toShortString(),
    };
  }
}
