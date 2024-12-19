// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_doctor_cubit.dart';

class UserDoctorState {
  String? errorMessage;
  ResponseEnum? responseType = ResponseEnum.initial;
  UserDoctorParams? doctorInfoParams;
  UserModel? userModel;
  UserDoctorState({
    this.errorMessage,
    this.responseType,
    this.doctorInfoParams,
    this.userModel,
  });

  UserDoctorState copyWith({
    String? errorMessage,
    ResponseEnum? responseType,
    UserDoctorParams? doctorInfoParams,
    UserModel? userModel,
  }) {
    return UserDoctorState(
      errorMessage: errorMessage ?? this.errorMessage,
      responseType: responseType ?? this.responseType,
      doctorInfoParams: doctorInfoParams ?? this.doctorInfoParams,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  String toString() {
    return 'UserDoctorState(errorMessage: $errorMessage, responseType: $responseType, doctorInfoParams: $doctorInfoParams, userModel: $userModel)';
  }
}
