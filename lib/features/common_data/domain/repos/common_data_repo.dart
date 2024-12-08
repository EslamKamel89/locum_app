import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_app/features/common_data/data/models/job_info_model.dart';
import 'package:locum_app/features/common_data/data/models/specialty_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';
import 'package:locum_app/features/common_data/data/models/university_model.dart';

abstract class CommonDataRepo {
  Future<Either<Failure, List<SpecialtyModel>>> fetchSpecialties();
  Future<Either<Failure, List<StateModel>>> fetchStates();
  Future<Either<Failure, List<UniversityModel>>> fetchUniversities();
  Future<Either<Failure, List<JobInfoModel>>> fetchJobInfos();
  Future<Either<Failure, DistrictsDataModel>> fetchDistrictsData(int stateId);
}
