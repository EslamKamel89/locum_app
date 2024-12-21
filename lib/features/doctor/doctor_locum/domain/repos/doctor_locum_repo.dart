import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';

abstract class DoctorLocumRepo {
  Future<Either<Failure, JobAddModel>> showJobAdd({
    required int jobAddId,
  });
  Future<Either<Failure, ResponseModel<List<JobAddModel>>>> showAllJobAdds({
    required int limit,
    required int page,
  });
}
