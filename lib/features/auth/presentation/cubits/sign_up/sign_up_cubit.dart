// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/heleprs/snackbar.dart';
import 'package:locum_app/features/auth/domain/entities/user_entity.dart';
import 'package:locum_app/features/common_data/data/models/district_model.dart';
import 'package:locum_app/features/common_data/data/models/districts_data_model.dart';
import 'package:locum_app/features/common_data/data/models/state_model.dart';
import 'package:locum_app/features/common_data/domain/repos/common_data_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final CommonDataRepo commonDataRepo;
  SignUpCubit({
    required this.commonDataRepo,
  }) : super(SignUpState());
  Future fetchStates() async {
    final t = prt('fetchStates - SignUpCubit');
    // emit(state.copyWith(responseType: ResponseType.loading, errorMessage: null));
    final result = await commonDataRepo.fetchStates();
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseType.failed, errorMessage: failure.message));
      },
      (List<StateModel> states) {
        pr(states, t);
        emit(state.copyWith(states: states, responseType: ResponseType.success, errorMessage: null));
      },
    );
  }

  Future fetchDistrict(String selectedStateName) async {
    final t = prt('fetchDistrict - SignUpCubit');
    StateModel? selectedStateModel = state.states?.where((stateModel) => stateModel.name == selectedStateName).first;
    emit(state.copyWith(selectedState: selectedStateModel, errorMessage: null));
    if (selectedStateModel == null) {
      return;
    }
    final result = await commonDataRepo.fetchDistrictsData(selectedStateModel.id!);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseType.failed, errorMessage: failure.message));
      },
      (DistrictsDataModel districtsData) {
        pr(districtsData, t);
        emit(state.copyWith(districtsDataModel: districtsData, responseType: ResponseType.success, errorMessage: null));
      },
    );
  }
}
