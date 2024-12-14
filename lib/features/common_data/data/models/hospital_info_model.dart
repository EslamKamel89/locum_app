class HospitalInfoModel {
  int? id;
  int? hospitalId;
  String? licenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  String? operatingHours;

  HospitalInfoModel({
    this.id,
    this.hospitalId,
    this.licenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.operatingHours,
  });

  @override
  String toString() {
    return 'HospitalInfoModel(id: $id, hospitalId: $hospitalId, licenseNumber: $licenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, operatingHours: $operatingHours, )';
  }

  factory HospitalInfoModel.fromJson(Map<String, dynamic> json) {
    return HospitalInfoModel(
      id: json['id'] as int?,
      hospitalId: json['hospital_id'] as int?,
      licenseNumber: json['license_number'] as String?,
      licenseState: json['license_state'] as String?,
      licenseIssueDate: json['license_issue_date'] as String?,
      licenseExpiryDate: json['license_expiry_date'] as String?,
      operatingHours: json['operating_hours'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'hospital_id': hospitalId,
        'license_number': licenseNumber,
        'license_state': licenseState,
        'license_issue_date': licenseIssueDate,
        'license_expiry_date': licenseExpiryDate,
        'operating_hours': operatingHours,
      };
}
