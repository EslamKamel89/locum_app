import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';

class ReviewDialog extends StatefulWidget {
  const ReviewDialog({super.key});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _commentController = TextEditingController();
  final int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: context.scaffoldBackgroundColor.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            const Text(
              'Leave a Reply',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 16),

            // Text Field for Comment
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Your Comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // // Rating Selector
            // const Text(
            //   'Your Rating',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.black87,
            //   ),
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(5, (index) {
            //     return IconButton(
            //       onPressed: () {
            //         setState(() {
            //           _selectedRating = index + 1;
            //         });
            //       },
            //       icon: Icon(
            //         Icons.star,
            //         color: _selectedRating > index ? Colors.amber : Colors.grey.shade400,
            //         size: 32,
            //       ),
            //     );
            //   }),
            // ),

            // const SizedBox(height: 16),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Save Logic
                  final comment = _commentController.text;
                  final rating = _selectedRating;
                  if (comment.isNotEmpty && rating > 0) {
                    Navigator.pop(context, {'comment': comment, 'rating': rating});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please provide a comment and rating.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Usage Example
void showReviewDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ReviewDialog();
    },
  ).then((result) {
    if (result != null) {
      print('Comment: ${result['comment']}');
      print('Rating: ${result['rating']}');
    }
  });
}
