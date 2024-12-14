import 'package:locum_app/features/auth/data/models/user_model.dart';
import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/common_data/data/models/district_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';

class DoctorUserModel extends UserModel {
  UserType? type;
  DistrictModel? district;
  StateModel? state;
  DoctorModel? doctor;

  DoctorUserModel({
    super.id,
    super.name,
    super.email,
    super.stateId,
    super.districtId,
    super.userTypeStr,
    this.type,
    this.district,
    this.state,
    this.doctor,
  });

  @override
  String toString() {
    return 'DoctorUserModel(id: $id, name: $name, email: $email,  stateId: $stateId, districtId: $districtId, type: $type, district: $district, state: $state, doctor: $doctor)';
  }

  factory DoctorUserModel.fromJson(Map<String, dynamic> json) {
    return DoctorUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      stateId: json['state_id'] as int?,
      districtId: json['district_id'] as int?,
      type: json['type'] == null ? null : UserType.fromStr(json['type']),
      userTypeStr: json['type'] as String,
      district: json['district'] == null ? null : DistrictModel.fromJson(json['district']),
      state: json['state'] == null ? null : StateModel.fromJson(json['state']),
      doctor: json['doctor'] == null ? null : DoctorModel.fromJson(json['doctor']),
    );
  }
}
