import 'package:flutter/material.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/comment_create_widget.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/view_comments_widget.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key, required this.commentableType, required this.commentableId});
  final String commentableType;
  final int commentableId;
  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentCreateWidget(commentableType: widget.commentableType, commentableId: widget.commentableId),
        ViewCommentsWidget(commentableType: widget.commentableType, commentableId: widget.commentableId),
      ],
    );
  }
}
