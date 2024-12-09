import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> signIn({required String email, required String password});
}
