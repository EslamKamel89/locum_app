import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/service_locator/service_locator.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/comments/presentation/cubits/view_comments/view_comments_cubit.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/comment_widget.dart';

class ViewCommentsWidget extends StatefulWidget {
  const ViewCommentsWidget({super.key, required this.commentableType, required this.commentableId});
  final String commentableType;
  final int commentableId;
  @override
  State<ViewCommentsWidget> createState() => _ViewCommentWidgetState();
}

class _ViewCommentWidgetState extends State<ViewCommentsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewCommentsCubit(
        commentRepo: serviceLocator(),
        commentableType: widget.commentableType,
        commentableId: widget.commentableId,
      )..getCommentByParentType(),
      child: Builder(builder: (context) {
        return BlocConsumer<ViewCommentsCubit, ViewCommentsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.commentModelsResponse?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final CommentModel? commentModel = state.commentModelsResponse?.data?[index];
                if (commentModel == null) return const SizedBox();
                return CommentWidget(commentModel);
              },
            );
          },
        );
      }),
    );
  }
}
