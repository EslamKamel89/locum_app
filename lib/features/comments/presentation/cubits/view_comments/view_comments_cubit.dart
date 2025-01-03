import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/heleprs/snackbar.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';

part 'view_comments_state.dart';

class ViewCommentsCubit extends Cubit<ViewCommentsState> {
  final CommentRepo commentRepo;
  ViewCommentsCubit({required this.commentRepo, required String commentableType, required int commentableId})
      : super(
          ViewCommentsState(
            commentableType: commentableType,
            commentableId: commentableId,
            params: GetCommentParams(commentableType: commentableType, commentableId: commentableId),
          ),
        );

  Future getCommentByParentType() async {
    final t = prt('getCommentByParentType - ViewCommentsCubit');
    if (state.responseType == ResponseEnum.loading) {
      pr('Still loading data exiting getCommentByParentType ', t);
      return;
    }
    if (state.hasNextPage != true) {
      pr('No more pages exiting getCommentByParentType ', t);
      return;
    }

    emit(state.copyWith(
      responseType: ResponseEnum.loading,
      errorMessage: null,
      page: state.page! + 1,
      params: state.params?.copyWith(page: state.page! + 1),
    ));

    final result = await commentRepo.getCommentByParentType(
      params: pr(
        state.params!,
        '$t params used in the request',
      ),
    );
    result.fold(
      (Failure failure) {
        pr(failure.message, t);
        showSnackbar('Server Error', failure.message, true);
        emit(state.copyWith(responseType: ResponseEnum.failed, errorMessage: failure.message));
      },
      (ResponseModel<List<CommentModel>> comments) async {
        pr(comments, t);
        pr(comments.pagination, t);
        comments.data = [...state.commentModelsResponse?.data ?? [], ...comments.data ?? []];
        emit(
          state.copyWith(
            commentModelsResponse: comments,
            responseType: ResponseEnum.success,
            errorMessage: null,
            hasNextPage: comments.pagination?.hasMorePages ?? false,
          ),
        );
      },
    );
  }
}
