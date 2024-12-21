import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_app/core/api_service/end_points.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/circular_image_asset.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/features/common_data/data/models/hospital_document_model.dart';
import 'package:locum_app/features/hospital/hospital_profile/presentation/views/widgets/hospital_profile_not_complete.dart';
import 'package:locum_app/utils/assets/assets.dart';
import 'package:locum_app/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HospitalProfileView extends StatefulWidget {
  const HospitalProfileView({super.key});

  @override
  State<HospitalProfileView> createState() => _HospitalProfileViewState();
}

class _HospitalProfileViewState extends State<HospitalProfileView> {
  @override
  void initState() {
    context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Profile',
      bottomNavigationBar: hospitalBottomNavigationBar,
      drawer: const DefaultHospitalDrawer(),
      child: const SingleChildScrollView(
        child: HospitalProfileContent(),
        // child: SizedBox(),
      ),
    );
  }
}

class HospitalProfileContent extends StatefulWidget {
  const HospitalProfileContent({super.key});

  @override
  State<HospitalProfileContent> createState() => _HospitalProfileContentState();
}

class _HospitalProfileContentState extends State<HospitalProfileContent> {
  @override
  Widget build(BuildContext context) {
    final userInfoCubit = context.watch<UserInfoCubit>();
    final user = userInfoCubit.state.hospitalUserModel;
    return userInfoCubit.state.responseType == ResponseEnum.loading
        ? Container(
            height: 700.h,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircularCachedImage(
                      imageUrl:
                          "${EndPoint.imgBaseUrl}${user?.hospital?.photo ?? ''}",
                      imageAsset: AssetsData.malePlacholder,
                      height: 100.h,
                      width: 100.h,
                    ),
                    const SizedBox(height: 12),
                    txt(user?.name ?? '', e: St.bold16),
                    const SizedBox(height: 4),
                    txt(user?.email ?? '', e: St.reg12),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionCard(
                children: [
                  _buildSectionHeader('Basic Information', handleEdit: () {
                    Navigator.of(context).pushNamed(
                        AppRoutesNames.userHospitalForm,
                        arguments: {'create': false});
                  }),
                  _buildInfo('State', user?.state?.name),
                  _buildInfo('District', user?.district?.name),
                ],
                visibility: user != null,
              ),
              SizedBox(height: 15.h),
              _sectionCard(
                children: [
                  _buildSectionHeader('Main Facility Information',
                      handleEdit: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.hospitalForm,
                      arguments: {'create': false},
                    );
                  }),
                  _buildInfo('Facility Name', user?.hospital?.facilityName),
                  _buildInfo('Facility Type', user?.hospital?.type),
                  _buildInfo('Contact Person', user?.hospital?.contactPerson),
                  _buildInfo('Contact Email', user?.hospital?.contactEmail),
                  _buildInfo('Contact Phone', user?.hospital?.contactPhone),
                  _buildInfo('Address', user?.hospital?.address),
                  _buildInfo(
                      'Services Offered', user?.hospital?.servicesOffered,
                      isRow: false),
                  _buildInfo('Number of beds',
                      user?.hospital?.numberOfBeds?.toString()),
                  _buildInfo('Website Url', user?.hospital?.websiteUrl,
                      isRow: false),
                  _buildInfo('Year Established',
                      user?.hospital?.yearEstablished?.toString()),
                  _buildInfo('Facility Overview', user?.hospital?.overview,
                      isRow: false),
                ],
                visibility: user?.hospital != null,
                showDivider: true,
              ),
              SizedBox(height: 15.h),
              _sectionCard(
                children: [
                  _buildSectionHeader('Additional Information', handleEdit: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.hospitalInfoForm,
                      arguments: {'create': false},
                    );
                  }),
                  _buildInfo('License Number',
                      user?.hospital?.hospitalInfo?.licenseNumber),
                  _buildInfo('License State',
                      user?.hospital?.hospitalInfo?.licenseState),
                  _buildInfo('License Issue Date',
                      user?.hospital?.hospitalInfo?.licenseIssueDate),
                  _buildInfo('License Expiry Date',
                      user?.hospital?.hospitalInfo?.licenseExpiryDate),
                  _buildInfo('Operating Hours',
                      user?.hospital?.hospitalInfo?.operatingHours),
                ],
                visibility: user?.hospital != null,
                showDivider: true,
              ),
              Builder(builder: (context) {
                List<HospitalDocumentModel> documents =
                    user?.hospital?.hospitalDocuments ?? [];
                return _sectionCard(
                  children: [
                    _buildSectionHeader('Documents', handleEdit: () {}),
                    ...documents.map((document) => _buildDocumentRow(
                        document.type ?? '', document.file ?? '')),
                  ],
                  visibility: documents.isNotEmpty,
                );
              }),
              HopitalProfileNotCompleteWidgets(user: user),
              SizedBox(height: 15.h),
            ],
          );
  }

  Widget _buildSectionHeader(String title, {void Function()? handleEdit}) {
    BuildContext? context = navigatorKey.currentContext;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: navigatorKey.currentContext!.primaryColor,
          ),
        ),
        if (handleEdit != null)
          IconButton(
            onPressed: handleEdit,
            icon: Icon(
              MdiIcons.circleEditOutline,
              color: context?.primaryColor,
            ),
          )
      ],
    );
  }

  Widget _buildInfo(String? label, String? value, {bool isRow = true}) {
    if (value == null) return const SizedBox();
    final content = [
      label == null
          ? const SizedBox()
          : Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: navigatorKey.currentContext!.primaryColor.withRed(5),
              ),
            ),
      label == null ? const SizedBox() : SizedBox(width: 15.w, height: 5.w),
      Text(
        value,
        textAlign: isRow ? TextAlign.end : TextAlign.start,
        style: const TextStyle(
            // color: Colors.black54,
            ),
        maxLines: isRow ? 1 : null,
        overflow: isRow ? TextOverflow.clip : null,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: isRow
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: content,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: content,
            ),
    );
  }

  Widget _buildDocumentRow(String docType, String docLink) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            docType,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            onTap: () {
              // Replace with actual logic to view the document
            },
            child: const Text(
              'View Document',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
      {required List<Widget> children,
      bool visibility = true,
      bool showDivider = true}) {
    return visibility
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              ...children,
              if (showDivider) Divider(color: Colors.grey.withOpacity(0.5)),
            ],
          )
        : const SizedBox();
  }
}
