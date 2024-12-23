import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/data/data-source/doctor_locum_remote_datasource.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

class DoctorLocumRepoImp implements DoctorLocumRepo {
  final DoctorLocumRemoteDataSource doctorLocumRemoteDataSource;

  DoctorLocumRepoImp({required this.doctorLocumRemoteDataSource});
  @override
  Future<Either<Failure, JobAddModel>> showJobAdd({
    required int jobAddId,
  }) async {
    final t = prt('updateOrCreateDoctorInfo  - DoctorLocumRepoImp');
    try {
      JobAddModel model = await doctorLocumRemoteDataSource.showJobAdd(jobAddId: jobAddId);
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }

  @override
  Future<Either<Failure, ResponseModel<List<JobAddModel>>>> showAllJobAdds(
      {required ShowAllJobAddsParams params}) async {
    final t = prt('showAllJobAdds  - DoctorLocumRepoImp');
    try {
      ResponseModel<List<JobAddModel>> response = await doctorLocumRemoteDataSource.showAllJobAdds(params: params);
      return Right(pr(response, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
