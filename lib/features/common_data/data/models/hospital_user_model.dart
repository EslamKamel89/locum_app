import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/common_data/data/models/district_model.dart';
import 'package:locum_app/features/common_data/data/models/hospital_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';

class HospitalUserModel {
  int? id;
  String? name;
  String? email;
  int? stateId;
  int? districtId;
  UserType? type;
  DistrictModel? district;
  StateModel? state;
  HospitalModel? hospital;

  HospitalUserModel({
    this.id,
    this.name,
    this.email,
    this.stateId,
    this.districtId,
    this.type,
    this.district,
    this.state,
    this.hospital,
  });

  @override
  String toString() {
    return 'HospitalUserModel(id: $id, name: $name, email: $email, stateId: $stateId, districtId: $districtId, type: $type, district: $district, state: $state, hospital: $hospital)';
  }

  factory HospitalUserModel.fromJson(Map<String, dynamic> json) {
    return HospitalUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      stateId: json['state_id'] as int?,
      districtId: json['district_id'] as int?,
      type: json['type'] == null ? null : UserType.fromStr(json['type']),
      district: json['district'] == null ? null : DistrictModel.fromJson(json['district']),
      state: json['state'] == null ? null : StateModel.fromJson(json['state']),
      hospital: json['hospital'] == null ? null : HospitalModel.fromJson(json['hospital']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'state_id': stateId,
        'district_id': districtId,
        'type': type,
        'district': district,
        'state': state,
        'hospital': hospital,
      };
}
