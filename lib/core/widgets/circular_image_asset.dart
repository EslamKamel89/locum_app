import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locum_app/core/widgets/custom_fading_widget.dart';

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

class CircularCachedImage extends StatelessWidget {
  const CircularCachedImage({
    super.key,
    required this.imageUrl,
    required this.imageAsset,
    required this.height,
    this.width,
  });

  final String imageUrl;
  final String imageAsset;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        // padding: EdgeInsets.symmetric(vertical: 5.h),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                ),
              ),
            );
          },
          placeholder: (context, url) =>
              CustomFadingWidget(child: Image.asset(imageAsset)),
          errorWidget: (context, url, error) => Image.asset(imageAsset),
        ),
      ),
    );
  }
}
