import 'package:flutter/material.dart';

class CircularImageAsset extends StatelessWidget {
  const CircularImageAsset({
    super.key,
    required this.image,
    required this.height,
  });

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        // padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Image.asset(
          image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
