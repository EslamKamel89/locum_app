import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/common_data/cubits/user_info/user_info_cubit.dart';
import 'package:locum_app/features/common_data/data/models/doctor_info_model.dart';
import 'package:locum_app/features/common_data/data/models/doctor_user_model.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/cubits/doctor_info/doctor_info_cubit.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class DoctorInfoForm extends StatefulWidget {
  const DoctorInfoForm({super.key});

  @override
  State<DoctorInfoForm> createState() => DoctorInfoFormState();
}

class DoctorInfoFormState extends State<DoctorInfoForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _licenseStateController = TextEditingController();
  final TextEditingController _universityNameController = TextEditingController();
  final TextEditingController _highestDegreeController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _graduationYearController = TextEditingController();
  final TextEditingController _workExperienceController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  // Date fields
  DateTime? _licenseIssueDate;
  DateTime? _licenseExpiryDate;

  // CV upload
  String? _cvFilePath;
  late final DoctorInfoCubit controller;
  late DoctorUserModel? doctorUserModel;
  @override
  void initState() {
    controller = context.read<DoctorInfoCubit>();
    doctorUserModel = context.read<UserInfoCubit>().state.doctorUserModel;
    DoctorInfoModel? doctorInfoModel = doctorUserModel?.doctor?.doctorInfo;
    if (doctorInfoModel == null) return;
    _licenseNumberController.text = doctorInfoModel.professionalLicenseNumber ?? '';
    _licenseStateController.text = doctorInfoModel.licenseState ?? '';
    _universityNameController.text = doctorInfoModel.university?.name ?? '';
    _highestDegreeController.text = doctorInfoModel.highestDegree ?? '';
    _fieldOfStudyController.text = doctorInfoModel.fieldOfStudy ?? '';
    _graduationYearController.text = doctorInfoModel.graduationYear.toString();
    _workExperienceController.text = doctorInfoModel.workExperience ?? '';
    _biographyController.text = doctorInfoModel.biography ?? '';
    super.initState();
  }

  Future<void> _uploadCV() async {
    setState(() {
      _cvFilePath = "sample_cv.pdf";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorInfoCubit, DoctorInfoState>(
      builder: (context, state) {
        return MainScaffold(
          appBarTitle: 'Professional Information',
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField('License Number', _licenseNumberController, 'Enter license number'),
                  CustomTextField('License State', _licenseStateController, 'Enter license state'),
                  CustomDateField(
                    'License Issue Date',
                    _licenseIssueDate,
                    isIssueDate: true,
                    licenseExpiryDate: _licenseExpiryDate ?? DateTime.now(),
                    licenseIssueDate: _licenseIssueDate ?? DateTime.now(),
                  ),
                  CustomDateField(
                    'License Expiry Date',
                    _licenseExpiryDate,
                    isIssueDate: false,
                    licenseExpiryDate: _licenseExpiryDate ?? DateTime.now(),
                    licenseIssueDate: _licenseIssueDate ?? DateTime.now(),
                  ),
                  CustomTextField('University Name', _universityNameController, 'Enter university name'),
                  CustomTextField('Highest Degree', _highestDegreeController, 'Enter highest degree'),
                  CustomTextField('Field of Study', _fieldOfStudyController, 'Enter field of study'),
                  CustomTextField(
                    'Graduation Year',
                    _graduationYearController,
                    'Enter graduation year',
                    inputType: TextInputType.number,
                  ),
                  CustomTextField('Work Experience', _workExperienceController, 'Enter work experience'),
                  CustomBiographyForm(controller: _biographyController),
                  CustomBiographyForm(controller: _biographyController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform save or update actions here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data saved successfully!')),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFileUploadField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _uploadCV,
            child: Text(_cvFilePath == null ? 'Upload CV' : 'Change CV'),
          ),
          const SizedBox(width: 16),
          if (_cvFilePath != null)
            Expanded(
              child: Text(
                'Selected: $_cvFilePath',
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
