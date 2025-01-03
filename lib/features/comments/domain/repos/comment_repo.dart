// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:locum_app/core/Errors/failure.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/common_data/data/models/response_model.dart';

abstract class CommentRepo {
  Future<Either<Failure, ResponseModel<List<CommentModel>>>> getCommentByParentType({required GetCommentParams params});
}

class GetCommentParams {
  String? commentableType;
  int? commentableId;
  int? limit;
  int? page;
  GetCommentParams({
    this.commentableType,
    this.commentableId,
    this.limit,
    this.page,
  });

  @override
  String toString() {
    return 'GetCommentParams(commentableType: $commentableType, commentableId: $commentableId, limit: $limit, page: $page)';
  }

  GetCommentParams copyWith({
    String? parent,
    int? parentId,
    int? limit,
    int? page,
  }) {
    return GetCommentParams(
      commentableType: parent ?? commentableType,
      commentableId: parentId ?? commentableId,
      limit: limit ?? this.limit,
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentableType': commentableType,
      'commentableId': commentableId,
      'limit': limit,
      'page': page,
    };
  }
}
