import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/doctor/support/data/remote-datasource/support_remotedatasource.dart';
import 'package:locum_app/features/doctor/support/domain/models/support_model.dart';
import 'package:locum_app/features/doctor/support/domain/repos/support_repo.dart';

class SupportRepoImp implements SupportRepo {
  final SupportRemoteDatasource remoteSource;

  SupportRepoImp({required this.remoteSource});
  @override
  Future<Either<Failure, List<SupportModel>>> fetchAllSupport() async {
    final t = prt('fetchAllSupport  - SupportRepoImp');
    try {
      List<SupportModel> models = await remoteSource.fetchAllSupport();
      return Right(pr(models, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        pr(e.response?.data, t);
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
