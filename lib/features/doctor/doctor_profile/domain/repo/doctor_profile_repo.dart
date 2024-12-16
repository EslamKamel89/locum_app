// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/common_data/data/models/doctor_info_model.dart';

abstract class DoctorProfileRepo {
  Future<Either<Failure, DoctorInfoModel>> updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  });
}

class DoctorInfoParams {
  String? professionalLicenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  int? universityId;
  String? highestDegree;
  String? fieldOfStudy;
  int? graduationYear;
  String? workExperience;
  String? cv;
  String? biography;

  DoctorInfoParams({
    this.professionalLicenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.universityId,
    this.highestDegree,
    this.fieldOfStudy,
    this.graduationYear,
    this.workExperience,
    this.cv,
    this.biography,
  });

  Map<String, dynamic> toJson() => {
        'professional_license_number': professionalLicenseNumber,
        'license_state': licenseState,
        'license_issue_date': licenseIssueDate,
        'license_expiry_date': licenseExpiryDate,
        'university_id': universityId,
        'highest_degree': highestDegree,
        'field_of_study': fieldOfStudy,
        'graduation_year': graduationYear,
        'work_experience': workExperience,
        'cv': cv,
        'biography': biography,
      };
  @override
  String toString() {
    return 'DoctorInfoParams(professionalLicenseNumber: $professionalLicenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, universityId: $universityId, highestDegree: $highestDegree, fieldOfStudy: $fieldOfStudy, graduationYear: $graduationYear, workExperience: $workExperience, cv: $cv, biography: $biography)';
  }
}
