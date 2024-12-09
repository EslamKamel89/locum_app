// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

class SignUpState {
  String? email;
  String? password;
  String? errorMessage;
  UserEntity? userEntity;
  ResponseType? responseType = ResponseType.initial;
  List<StateModel>? states = [];
  StateModel? selectedState;
  DistrictsDataModel? districtsDataModel;
  DistrictModel? selectdDistrict;
  SignUpState({
    this.email,
    this.password,
    this.errorMessage,
    this.userEntity,
    this.responseType,
    this.states,
    this.selectedState,
    this.districtsDataModel,
    this.selectdDistrict,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    UserEntity? userEntity,
    ResponseType? responseType,
    List<StateModel>? states,
    StateModel? selectedState,
    DistrictsDataModel? districtsDataModel,
    DistrictModel? selectdDistrict,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      userEntity: userEntity ?? this.userEntity,
      responseType: responseType ?? this.responseType,
      states: states ?? this.states,
      selectedState: selectedState ?? this.selectedState,
      districtsDataModel: districtsDataModel ?? this.districtsDataModel,
      selectdDistrict: selectdDistrict ?? this.selectdDistrict,
    );
  }

  @override
  String toString() {
    return 'SignUpState(email: $email, password: $password, errorMessage: $errorMessage, userEntity: $userEntity, responseType: $responseType, states: $states, selectedState: $selectedState, districtsDataModel: $districtsDataModel, selectdDistrict: $selectdDistrict)';
  }
}
