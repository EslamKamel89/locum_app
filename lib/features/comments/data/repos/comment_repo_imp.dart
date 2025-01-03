import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/features/comments/data/data_source/comment_remote_data_source.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/comments/domain/repos/comment_repo.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';

class CommentRepoImp implements CommentRepo {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepoImp({required this.commentRemoteDataSource});
  @override
  Future<Either<Failure, ResponseModel<List<CommentModel>>>> getCommentByParentType(
      {required GetCommentParams params}) async {
    final t = prt('getCommentByParentType  - CommentRepoImp');
    try {
      ResponseModel<List<CommentModel>> response = await commentRemoteDataSource.getCommentByParentType(params: params);
      return Right(pr(response, t));
    } catch (e) {
      pr(e.toString());
      if (e is DioException) {
        return Left(ServerFailure.formDioError(e));
      }
      return Left(ServerFailure(pr(e.toString(), t)));
    }
  }
}
