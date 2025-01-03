import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/review_dialog.dart';

class RepliesWidget extends StatelessWidget {
  const RepliesWidget({super.key, required this.commentModel});
  final CommentModel? commentModel;
  @override
  Widget build(BuildContext context) {
    if (commentModel == null) return const SizedBox();
    if (commentModel?.children?.isEmpty == true) return const SizedBox();
    return Column(
      children: [
        ...List.generate(commentModel?.children?.length ?? 0, (index) {
          return Column(
            children: [
              SingleReplyWidget(commentModel: commentModel),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: RepliesWidget(commentModel: commentModel?.children?[index]),
              )
            ],
          );
        }),
      ],
    );
  }
}

class SingleReplyWidget extends StatelessWidget {
  const SingleReplyWidget({
    super.key,
    required this.commentModel,
  });

  final CommentModel? commentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: context.secondaryHeaderColor, width: 3),
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.only(left: 5),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(commentModel?.content ?? ''),
              subtitle: Text(commentModel?.user?.name ?? ''),
              subtitleTextStyle: TextStyle(color: context.primaryColor),
            ),
            InkWell(
              onTap: () {
                showReviewDialog(context);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 5, right: 5),
                alignment: Alignment.centerRight,
                child: Icon(Icons.add, color: context.secondaryHeaderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
