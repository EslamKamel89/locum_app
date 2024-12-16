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

    if (create) {
      final data = await api.post(
        EndPoint.doctorInfoCreate,
        data: params.toJson(),
      );
      DoctorInfoModel doctorInfoModel = DoctorInfoModel.fromJson(data['data']);

      return pr(doctorInfoModel, t);
    } else {
      final data = await api.patch(
        EndPoint.doctorInfoUpdate(id),
        data: params.toJson(),
      );
      DoctorInfoModel doctorInfoModel = DoctorInfoModel.fromJson(data['data']);

      return pr(doctorInfoModel, t);
    }
  }
}
