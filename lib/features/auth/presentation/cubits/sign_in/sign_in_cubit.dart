// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
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
      },
    );
  }
}
