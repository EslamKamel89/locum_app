// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_app/features/common_data/data/models/job_info_model.dart';
import 'package:locum_app/features/common_data/data/models/specialty_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';
import 'package:locum_app/features/common_data/data/models/university_model.dart';

class CommonDataRemoteSource {
  final ApiConsumer api;
  CommonDataRemoteSource({
    required this.api,
  });
  Future<List<SpecialtyModel>> fetchSpecialties() async {
    final t = prt('fetchSpecialties - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchSpecialties);
    List<SpecialtyModel> specialties = data['data']
        .map<SpecialtyModel>((e) => SpecialtyModel.fromJson(e))
        .toList();

    return pr(specialties, t);
  }

  Future<List<StateModel>> fetchStates() async {
    final t = prt('fetchStates - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchStates);
    List<StateModel> stateModels =
        data['data'].map<StateModel>((e) => StateModel.fromJson(e)).toList();

    return pr(stateModels, t);
  }

  Future<List<UniversityModel>> fetchUniversities() async {
    final t = prt('fetchUniversities - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchUniversities);
    List<UniversityModel> universityModels = data['data']
        .map<UniversityModel>((e) => UniversityModel.fromJson(e))
        .toList();

    return pr(universityModels, t);
  }

  Future<List<JobInfoModel>> fetchJobInfos() async {
    final t = prt('fetchJobInfos - CommonDataRemoteSource');
    final data = await api.get(EndPoint.fetchJobInfos);
    List<JobInfoModel> jobInfoModels = data['data']
        .map<JobInfoModel>((e) => JobInfoModel.fromJson(e))
        .toList();

    return pr(jobInfoModels, t);
  }

  Future<DistrictsDataModel> fetchDistrictsData(int stateId) async {
    final t = prt('fetchDistrictsData - CommonDataRemoteSource');
    final data = await api.get(
      EndPoint.fetchDistrictsData,
      queryParameter: {'state_id': stateId},
    );
    DistrictsDataModel districtsDataModel =
        DistrictsDataModel.fromJson(data['data']);

    return pr(districtsDataModel, t);
  }
}
