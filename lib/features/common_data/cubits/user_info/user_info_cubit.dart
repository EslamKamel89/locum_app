// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/auth/helpers/auth_helpers.dart';
import 'package:locum_app/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_app/features/common_data/data/models/hospital_user_model.dart';
import 'package:locum_app/features/common_data/domain/repos/common_data_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  final CommonDataRepo commonDataRepo;
  final SharedPreferences sharedPreferences;
  UserInfoCubit({
    required this.commonDataRepo,
    required this.sharedPreferences,
  }) : super(UserInfoState());

  Future fetchUserInfo([bool navigate = false]) async {
    final t = prt('fetchUserInfo - UserInfoCubit');
    emit(UserInfoState(responseType: ResponseType.loading));
    if (!AuthHelpers.isSignedIn()) {
      _navigateToOnBoardingScreen();
      return;
    }
    final result = await commonDataRepo.fetchUserInfo();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        // showSnackbar('Server Error', failure.message, true);
        emit(UserInfoState(
            responseType: ResponseType.failed, errorMessage: failure.message));
      },
      (Either<DoctorUserModel, HospitalUserModel> doctorOrHospital) {
        pr(doctorOrHospital, t);
        doctorOrHospital.fold(
          (DoctorUserModel doctor) {
            AuthHelpers.cacheUser(doctor);
            emit(UserInfoState(
                doctorUserModel: doctor,
                userType: UserType.doctor,
                responseType: ResponseType.success));
          },
          (HospitalUserModel hospital) {
            AuthHelpers.cacheUser(hospital);
            emit(UserInfoState(
                hospitalUserModel: hospital,
                userType: UserType.hospital,
                responseType: ResponseType.success));
          },
        );
        if (navigate) _navigateToHomeScreen();
      },
    );
  }

  Future _navigateToOnBoardingScreen() async {
    final t = prt('navigateToOnBoardingScreen - UserInfoCubit');
    pr('navigating to on boarding screen because the cached token is null', t);
    Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
      AppRoutesNames.onboardingScreen,
      (_) => false,
    );
  }

  Future _navigateToHomeScreen() async {
    final t = prt('navigateToHomeScreen - UserInfoCubit');

    final context = navigatorKey.currentContext;
    if (context == null) {
      pr('Error: context is null', t);
      return;
    }
    if (state.userType == UserType.doctor) {
      pr('Navigate to doctors home page', t);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        AppRoutesNames.doctorHomeScreen,
        (_) => false,
      );
      return;
    }
    if (state.userType == UserType.hospital) {
      pr('Navigate to hospitals home page', t);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        AppRoutesNames.hospitalHomeScreen,
        (_) => false,
      );
      return;
    }
    if (state.userType == null) {
      pr('Navigate to onboarding screen', t);
      Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        AppRoutesNames.onboardingScreen,
        (_) => false,
      );
      return;
    }
  }

  Future handleSignOut() async {
    sharedPreferences.clear();
    emit(UserInfoState());
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutesNames.signinScreen, (_) => false);
  }
}
