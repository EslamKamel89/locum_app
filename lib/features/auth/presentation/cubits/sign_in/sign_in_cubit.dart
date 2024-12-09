// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/features/auth/data/models/user_model.dart';
import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/auth/domain/repos/auth_repo.dart';
import 'package:locum_app/features/auth/helpers/auth_helpers.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;
  SignInCubit({
    required this.authRepo,
  }) : super(SignInState());
  Future signIn({required Map<String, String> signInData}) async {
    final t = prt('signIn - SignInCubit');
    emit(state.copyWith(responseType: ResponseType.loading, errorMessage: null));
    final result = await authRepo.signIn(email: signInData['email']!, password: signInData['password']!);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        emit(state.copyWith(responseType: ResponseType.failed, errorMessage: failure.message));
      },
      (UserModel user) {
        pr(user, t);
        AuthHelpers.cacheUser(user);
        emit(state.copyWith(userEntity: user, responseType: ResponseType.success, errorMessage: null));
        _navigateToHomeScreen();
      },
    );
  }

  Future _navigateToHomeScreen() async {
    final t = prt('navigateToHomeScreen - SignInCubit');
    Future.delayed(const Duration(seconds: 1)).then((_) {
      final context = navigatorKey.currentContext;
      final isDoctor = AuthHelpers.isDoctor();
      if (context == null || isDoctor == null) {
        pr('Error: context or isDoctor is null', t);
        return;
      }
      if (isDoctor) {
        pr('Navigate to doctors home page', t);
        Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          AppRoutesNames.doctorHomeScreen,
          (_) => false,
        );
      } else {
        pr('Navigate to hospitals home page', t);
        Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil(
          AppRoutesNames.hospitalHomeScreen,
          (_) => false,
        );
      }
    });
  }
}
