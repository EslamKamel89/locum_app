import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/globals.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/widgets/badge_wrap.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/circular_image_asset.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/features/common_data/data/models/doctor_document_model.dart';
import 'package:locum_app/features/common_data/data/models/language_model.dart';
import 'package:locum_app/features/common_data/data/models/skill_model.dart';
import 'package:locum_app/utils/assets/assets.dart';
import 'package:locum_app/utils/styles/styles.dart';

class DoctorProfileView extends StatefulWidget {
  const DoctorProfileView({super.key});

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  @override
  void initState() {
    context.read<UserInfoCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'Profile',
      bottomNavigationBar: doctorBottomNavigationBar,
      drawer: const DefaultDoctorDrawer(),
      child: const SingleChildScrollView(
        child: DoctorProfileContent(),
      ),
    );
  }
}

class DoctorProfileContent extends StatelessWidget {
  const DoctorProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoCubit = context.watch<UserInfoCubit>();
    final user = userInfoCubit.state.doctorUserModel;
    const t = 'Profile Screen';
    pr(userInfoCubit.state, '$t - userInfoCubit.state');
    pr(user?.doctor?.doctorInfo, '$t - user?.doctor?.doctorInfo');
    return userInfoCubit.state.responseType == ResponseType.loading
        ? Container(
            height: 700.h,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: User Photo, Name, and Email
              Center(
                child: Column(
                  children: [
                    CircularCachedImage(
                      imageUrl: user?.doctor?.photo ?? '',
                      imageAsset:
                          user?.doctor?.gender == 'male' ? AssetsData.malePlacholder : AssetsData.femalePlacholder,
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

              // Section 2: User Information
              _sectionCard(
                children: [
                  _buildSectionHeader('Basic Information'),
                  _buildInfo('State', user?.state?.name),
                  _buildInfo('District', user?.district?.name),
                ],
                visibility: user != null,
              ),

              SizedBox(height: 15.h),

              // Section 3: Main Professional Information
              _sectionCard(
                children: [
                  _buildSectionHeader('Main Professional Information'),
                  _buildInfo('Specialty', user?.doctor?.specialty?.name),
                  _buildInfo('Date of Birth', user?.doctor?.dateOfBirth),
                  _buildInfo('Gender', user?.doctor?.gender),
                  _buildInfo('Address', user?.doctor?.address),
                  _buildInfo('Phone', user?.doctor?.phone),
                  _buildInfo(
                      'Willing to Relocate',
                      user?.doctor?.willingToRelocate == null || user?.doctor?.willingToRelocate == false
                          ? 'No'
                          : 'Yes'),
                ],
                visibility: user?.doctor != null,
              ),

              SizedBox(height: 15.h),

              // Section 4: Additional Professional Information
              _sectionCard(
                children: [
                  _buildSectionHeader('Additional Professional Information'),
                  _buildInfo('Professional License No.', user?.doctor?.doctorInfo?.professionalLicenseNumber),
                  _buildInfo('License State', user?.doctor?.doctorInfo?.licenseState),
                  _buildInfo('License Issue Date', user?.doctor?.doctorInfo?.licenseIssueDate),
                  _buildInfo('License Expiry Date', user?.doctor?.doctorInfo?.licenseExpiryDate),
                  _buildInfo('University', user?.doctor?.doctorInfo?.university?.name),
                  _buildInfo('Highest Degree', user?.doctor?.doctorInfo?.highestDegree),
                  _buildInfo('Field of Study', user?.doctor?.doctorInfo?.fieldOfStudy),
                  _buildInfo('Graduation Year', user?.doctor?.doctorInfo?.graduationYear.toString()),
                  _buildInfo('Work Experience', user?.doctor?.doctorInfo?.workExperience, isRow: false),
                  _buildInfo('Biography', user?.doctor?.doctorInfo?.biography, isRow: false),
                ],
                visibility: user?.doctor?.doctorInfo != null,
              ),

              SizedBox(height: 15.h),

              // Section 5: Languages Spoken
              Builder(
                builder: (context) {
                  List<LanguageModel> langs = user?.doctor?.langs ?? [];
                  String langsStr = '';
                  for (var lang in langs) {
                    langsStr = '$langsStr , ${lang.name} ';
                  }
                  langsStr = langsStr.replaceFirst(',', '').trim();
                  return _sectionCard(
                    children: [
                      _buildSectionHeader('Languages Spoken'),
                      // _buildInfo(null, langsStr, isRow: false),
                      const SizedBox(height: 5),
                      BadgeWrap(items: langs.map((lang) => lang.name ?? '').toList())
                    ],
                    visibility: langs.isNotEmpty,
                  );
                },
              ),

              SizedBox(height: 15.h),

              // Section 6: Doctor Skills
              Builder(
                builder: (context) {
                  List<SkillModel> skills = user?.doctor?.skills ?? [];
                  String skillsStr = '';
                  for (var skill in skills) {
                    skillsStr = '$skillsStr , ${skill.name} ';
                  }
                  skillsStr = skillsStr.replaceFirst(',', '').trim();
                  return _sectionCard(
                    children: [
                      _buildSectionHeader('Skills'),
                      // _buildInfo(null, skillsStr, isRow: false),
                      const SizedBox(height: 5),
                      BadgeWrap(items: skills.map((skill) => skill.name ?? '').toList())
                    ],
                    visibility: skills.isNotEmpty,
                  );
                },
              ),

              SizedBox(height: 15.h),

              // Section 7: Doctor Documents
              Builder(builder: (context) {
                List<DoctorDocumentModel> documents = user?.doctor?.doctorDocuments ?? [];
                return _sectionCard(
                  children: [
                    _buildSectionHeader('Documents'),
                    ...documents.map((document) => _buildDocumentRow(document.type ?? '', document.file ?? '')),
                  ],
                  visibility: documents.isNotEmpty,
                );
              }),

              SizedBox(height: 15.h),
            ],
          );
  }

  // Helper to build section headers
  Widget _buildSectionHeader(
    String title,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: navigatorKey.currentContext!.primaryColor,
      ),
    );
  }

  // Helper to build key-value rows
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

  // Helper to build document links
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

  Widget _sectionCard({required List<Widget> children, bool visibility = true}) {
    return visibility
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...children,
              Divider(color: Colors.grey.withOpacity(0.5)),
            ],
          )
        : const SizedBox();
  }
}
