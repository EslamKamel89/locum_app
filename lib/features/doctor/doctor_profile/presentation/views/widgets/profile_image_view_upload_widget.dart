import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/heleprs/pick_image.dart';
import 'package:locum_app/core/widgets/choose_camera_or_gallery.dart';
import 'package:locum_app/core/widgets/circular_image_asset.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/features/common_data/data/models/doctor_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_app/utils/assets/assets.dart';

class ProfileImageUploadView extends StatefulWidget {
  const ProfileImageUploadView({super.key, required this.onImageSelected});
  final Function(File file) onImageSelected;

  @override
  State<ProfileImageUploadView> createState() => _ProfileImageUploadViewState();
}

class _ProfileImageUploadViewState extends State<ProfileImageUploadView> {
  late DoctorUserModel? doctorUserModel;
  late DoctorModel? doctorModel;
  File? selectedPhoto;

  @override
  void initState() {
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    doctorModel = doctorUserModel?.doctor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: selectedPhoto == null
                ? CircularCachedImage(
                    imageUrl: doctorModel?.photo ?? '',
                    imageAsset:
                        doctorModel?.gender == 'female' ? AssetsData.femalePlacholder : AssetsData.malePlacholder,
                    height: 100.h,
                    width: 100.h,
                  )
                : CircularImageFile(
                    image: selectedPhoto!,
                    height: 100.h,
                    width: 100.h,
                  ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: context.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () async {
                  ImageSource? source = await chooseGalleryOrCameraDialog();
                  if (source == null) return;
                  selectedPhoto = await pickImage(source);
                  setState(() {});
                  if (selectedPhoto != null) {
                    widget.onImageSelected(selectedPhoto!);
                  }
                },
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}