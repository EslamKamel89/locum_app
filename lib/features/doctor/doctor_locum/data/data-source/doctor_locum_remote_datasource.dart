import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';

class DoctorLocumRemoteDataSource {
  final ApiConsumer api;

  DoctorLocumRemoteDataSource({required this.api});

  Future<JobAddModel> showJobAdd({
    required int jobAddId,
  }) async {
    final t = prt('showJobAdd - DoctorLocumRemoteDataSource');

    final data = await api.get(
      EndPoint.showJobAdd(jobAddId),
    );
    JobAddModel jobAddModel = JobAddModel.fromJson(data['data']);

    return pr(jobAddModel, t);
  }

  Future<ResponseModel<List<JobAddModel>>> showAllJobAdds({required int limit, required int page}) async {
    final t = prt('showAllJobAdds - DoctorLocumRemoteDataSource');
    final data = await api.get(EndPoint.showAllJobAdds, queryParameter: {
      'limit': limit,
      'page': page,
    });
    ResponseModel<List<JobAddModel>> response = ResponseModel.fromJson(data);
    List<JobAddModel> jobAddModels = data['data'].map<JobAddModel>((e) => JobAddModel.fromJson(e)).toList();
    response.data = jobAddModels;

    return pr(response, t);
  }
}
