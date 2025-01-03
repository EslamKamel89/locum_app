import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/features/comments/domain/models/comment_model.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/replies_widget.dart';
import 'package:locum_app/features/comments/presentation/views/widgets/review_dialog.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(this.commentModel, {super.key});
  final CommentModel commentModel;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showReplies = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shadowColor: context.secondaryHeaderColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.commentModel.user?.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.secondaryHeaderColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.commentModel.user?.userType?.toString() ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            RatingBarIndicator(
              rating: widget.commentModel.rating?.toDouble() ?? 5.0,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20,
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 10),
            Text(
              widget.commentModel.content ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  setState(() {
                    showReplies = !showReplies;
                  });
                },
                child: Text(
                  showReplies ? 'Hide Replies' : 'Show Replies',
                  style: TextStyle(color: context.primaryColor, decoration: TextDecoration.underline),
                ),
              ),
              InkWell(
                  onTap: () {
                    showReviewDialog(context);
                  },
                  child: Icon(Icons.add, color: context.secondaryHeaderColor)),
            ]),
            const SizedBox(height: 2),
            if (showReplies) Divider(color: context.secondaryHeaderColor, thickness: 2),
            const SizedBox(height: 2),
            if (showReplies) RepliesWidget(commentModel: widget.commentModel),
          ],
        ),
      ),
    );
  }
}
