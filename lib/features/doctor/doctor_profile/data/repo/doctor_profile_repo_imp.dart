import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_model.dart';
import 'package:locum_app/features/doctor/doctor_profile/data/remote_data_source/doctor_profile_remote_datasource.dart';
import 'package:locum_app/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

class DoctorProfileRepoImp implements DoctorProfileRepo {
  final DoctorProfileRemoteDataSource doctorProfileRemoteDataSource;

  DoctorProfileRepoImp({required this.doctorProfileRemoteDataSource});
  @override
  Future<Either<Failure, DoctorInfoModel>> updateOrCreateDoctorInfo(
      {required DoctorInfoParams params, required bool create, int? id}) async {
    final t = prt('updateOrCreateDoctorInfo  - DoctorProfileRemoteDataSource');
    try {
      DoctorInfoModel model = await doctorProfileRemoteDataSource.updateOrCreateDoctorInfo(
        params: params,
        create: create,
        id: id,
      );
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
  Future<Either<Failure, DoctorModel>> updateOrCreateDoctor(
      {required DoctorParams params, required bool create, int? id}) async {
    final t = prt('updateOrCreateDoctor  - DoctorProfileRemoteDataSource');
    try {
      DoctorModel model = await doctorProfileRemoteDataSource.updateOrCreateDoctor(
        params: params,
        create: create,
        id: id,
      );
      return Right(pr(model, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
