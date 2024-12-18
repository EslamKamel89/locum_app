// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/api_service/upload_file_to_api.dart';
import 'package:locum_app/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_model.dart';

abstract class DoctorProfileRepo {
  Future<Either<Failure, DoctorInfoModel>> updateOrCreateDoctorInfo({
    required DoctorInfoParams params,
    required bool create,
    int? id,
  });
  Future<Either<Failure, DoctorModel>> updateOrCreateDoctor({
    required DoctorParams params,
    required bool create,
    int? id,
  });
}

class DoctorInfoParams {
  String? professionalLicenseNumber;
  String? licenseState;
  String? licenseIssueDate;
  String? licenseExpiryDate;
  String? universityName;
  String? highestDegree;
  String? fieldOfStudy;
  int? graduationYear;
  String? workExperience;
  File? cv;
  String? biography;

  DoctorInfoParams({
    this.professionalLicenseNumber,
    this.licenseState,
    this.licenseIssueDate,
    this.licenseExpiryDate,
    this.universityName,
    this.highestDegree,
    this.fieldOfStudy,
    this.graduationYear,
    this.workExperience,
    this.cv,
    this.biography,
  });

  Future<Map<String, dynamic>> toJson() async => {
        'professional_license_number': professionalLicenseNumber,
        'license_state': licenseState,
        'license_issue_date': licenseIssueDate,
        'license_expiry_date': licenseExpiryDate,
        'university_name': universityName,
        'highest_degree': highestDegree,
        'field_of_study': fieldOfStudy,
        'graduation_year': graduationYear,
        'work_experience': workExperience,
        'cv': cv == null ? null : (await uploadFileToApi(cv!)),
        'biography': biography,
      };
  @override
  String toString() {
    return 'DoctorInfoParams(professionalLicenseNumber: $professionalLicenseNumber, licenseState: $licenseState, licenseIssueDate: $licenseIssueDate, licenseExpiryDate: $licenseExpiryDate, universityName: $universityName, highestDegree: $highestDegree, fieldOfStudy: $fieldOfStudy, graduationYear: $graduationYear, workExperience: $workExperience, cv: $cv, biography: $biography)';
  }
}

class DoctorParams {
  String? specialtyName;
  String? jobInfoName;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? phone;
  bool? willingToRelocate;
  File? photo;
  String? langs;
  String? skills;

  DoctorParams({
    this.specialtyName,
    this.jobInfoName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.phone,
    this.willingToRelocate,
    this.photo,
    this.langs,
    this.skills,
  });

  @override
  String toString() {
    return 'DoctorParams(specialtyName: $specialtyName, jobInfoName: $jobInfoName, dateOfBirth: $dateOfBirth, gender: $gender, address: $address, phone: $phone, willingToRelocate: $willingToRelocate, photo: $photo, langs: $langs, skills: $skills)';
  }

  Future<Map<String, dynamic>> toJson() async => {
        'specialty_name': specialtyName,
        'job_info_name': jobInfoName,
        'date_of_birth': dateOfBirth,
        'gender': gender,
        'address': address,
        'phone': phone,
        'willing_to_relocate': willingToRelocate == true ? 1 : 0,
        'photo': photo == null ? null : (await uploadFileToApi(photo!)),
        'langs': langs,
        'skills': skills,
      };
}
