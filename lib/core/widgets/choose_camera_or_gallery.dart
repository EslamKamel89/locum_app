import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/utils/styles/styles.dart';

Future<ImageSource?> chooseGalleryOrCameraDialog() async {
  BuildContext? context = navigatorKey.currentContext;
  if (context == null) return null;
  final ImageSource? result = await showDialog<ImageSource>(
    context: context,
    builder: (contex) {
      return AlertDialog(
        title: txt('Pick Image From', e: St.bold14, c: context.primaryColor),
        // content: txt('Image From', e: St.semi12),
        actions: [
          TextButton(
            child: txt('Gallery', e: St.reg12),
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
          ),
          TextButton(
            child: txt('Camera', e: St.reg12),
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
          )
        ],
      );
    },
  );
  return result;
}
