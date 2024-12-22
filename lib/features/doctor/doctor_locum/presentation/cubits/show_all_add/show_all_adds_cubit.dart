// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/heleprs/snackbar.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/repos/doctor_locum_repo.dart';

part 'show_all_adds_state.dart';

class ShowAllAddsCubit extends Cubit<ShowAllAddsState> {
  final DoctorLocumRepo doctorLocumRepo;
  ShowAllAddsCubit(
    this.doctorLocumRepo,
  ) : super(ShowAllAddsState());

  Future showAllJobAdds() async {
    final t = prt('showAllJobAdds - ShowAllAddsCubit');
    if (state.responseType == ResponseEnum.loading) {
      pr('Still loading data exiting showAllJobAdds ', t);
      return;
    }
    if (state.hasNextPage != true) {
      pr('No more pages exiting showAllJobAdds ', t);
      return;
    }
    emit(state.copyWith(responseType: ResponseEnum.loading, errorMessage: null, page: state.page! + 1));
    final result = await doctorLocumRepo.showAllJobAdds(limit: state.limit!, page: state.page!);
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (ResponseModel<List<JobAddModel>> jobAdds) async {
        pr(jobAdds, t);
        pr(jobAdds.pagination, t);
        jobAdds.data = [...state.jobAddsResponse?.data ?? [], ...jobAdds.data ?? []];
        emit(
          state.copyWith(
            jobAddsResponse: jobAdds,
            responseType: ResponseEnum.success,
            errorMessage: null,
            hasNextPage: jobAdds.pagination?.hasMorePages ?? false,
          ),
        );
      },
    );
  }
}
