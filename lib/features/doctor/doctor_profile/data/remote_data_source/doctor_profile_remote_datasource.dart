import 'package:locum_app/core/api_service/api_consumer.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_app/features/doctor/doctor_profile/domain/repo/doctor_profile_repo.dart';

class DoctorProfileRemoteDataSource {
  final ApiConsumer api;

  DoctorProfileRemoteDataSource({required this.api});
  Future<DoctorInfoModel> updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  }) async {
    final t = prt('updateOrCreateDoctorInfo - DoctorProfileRemoteDataSource');
    // Map<String, dynamic> requestData = create ? params.toJson() : params.toJson()
    //   ..addAll({'id': id});
    Map<String, dynamic> requestData = await params.toJson();
    if (!create) {
      requestData.addAll({'id': id});
    }
    final data = await api.post(
      EndPoint.doctorInfoCreateOrUpdate,
      isFormData: true,
      data: requestData,
    );
    DoctorInfoModel doctorInfoModel = DoctorInfoModel.fromJson(data['data']);

    return pr(doctorInfoModel, t);
  }
}
