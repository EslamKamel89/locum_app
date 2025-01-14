import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/doctor/support/domain/models/support_model.dart';

abstract class SupportRepo {
  Future<Either<Failure, List<SupportModel>>> fetchAllSupport();
}
