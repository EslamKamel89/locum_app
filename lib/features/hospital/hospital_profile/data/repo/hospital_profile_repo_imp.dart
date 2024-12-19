// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/hospital_model.dart';
import 'package:locum_app/features/hospital/hospital_profile/data/remote_data_source/hospital_profile_remote_datasource.dart';
import 'package:locum_app/features/hospital/hospital_profile/domain/repo/hospital_profile_repo.dart';

class HospitalProfileRepoImp implements HospitalProfileRepo {
  final HospitalProfileRemoteDatasource hospitalProfileRemoteDatasource;
  HospitalProfileRepoImp({
    required this.hospitalProfileRemoteDatasource,
  });
  @override
  Future<Either<Failure, HospitalModel>> updateOrCreateHospital(
      {required HospitalParams params, required bool create, int? id}) async {
    final t = prt('updateOrCreateHospital  - HospitalProfileRepoImp');
    try {
      HospitalModel model = await hospitalProfileRemoteDatasource.updateOrCreateHospital(
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
