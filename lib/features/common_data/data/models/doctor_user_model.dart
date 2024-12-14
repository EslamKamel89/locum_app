import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/common_data/data/models/district_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';

class DoctorUserModel {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? stateId;
  int? districtId;
  UserType? type;
  DistrictModel? district;
  StateModel? state;
  DoctorModel? doctor;

  DoctorUserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.stateId,
    this.districtId,
    this.type,
    this.district,
    this.state,
    this.doctor,
  });

  @override
  String toString() {
    return 'DoctorUserModel(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, stateId: $stateId, districtId: $districtId, type: $type, district: $district, state: $state, doctor: $doctor)';
  }

  factory DoctorUserModel.fromJson(Map<String, dynamic> json) {
    return DoctorUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      stateId: json['state_id'] as int?,
      districtId: json['district_id'] as int?,
      type: json['type'] == null ? null : UserType.fromStr(json['type']),
      district: json['district'] == null ? null : DistrictModel.fromJson(json['district']),
      state: json['state'] == null ? null : StateModel.fromJson(json['state']),
      doctor: json['doctor'] == null ? null : DoctorModel.fromJson(json['doctor']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'state_id': stateId,
        'district_id': districtId,
        'type': type,
        'district': district,
        'state': state,
        'doctor': doctor,
      };
}
