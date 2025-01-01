import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:locum_app/core/enums/response_type.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/heleprs/print_helper.dart';
import 'package:locum_app/core/widgets/badge_wrap.dart';
import 'package:locum_app/core/widgets/bottom_navigation_bar.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/cubits/apply_to_job_add/apply_to_job_add_cubit.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/cubits/show_job_add/show_job_add_cubit.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/view/widgets/apply_to_job_popup.dart';

class DoctorJobAddDetailsView extends StatefulWidget {
  final int id;

  const DoctorJobAddDetailsView({
    super.key,
    required this.id,
  });

  @override
  State<DoctorJobAddDetailsView> createState() => _DoctorJobAddDetailsViewState();
}

class _DoctorJobAddDetailsViewState extends State<DoctorJobAddDetailsView> {
  late final ShowJobAddCubit controller;
  @override
  void initState() {
    controller = context.read<ShowJobAddCubit>();
    controller.showJobAdd(jobAddId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowJobAddCubit, ShowJobAddState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final JobAddModel? jobAddModel = state.jobAddModel;
        return MainScaffold(
          appBarTitle: 'Job Add Details',
          drawer: const DefaultDoctorDrawer(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<ApplyToJobAddCubit, ApplyToJobAddState>(
                  listener: (context, state) {
                    if (state.responseType == ResponseEnum.success) {
                      // Navigator.of(context).pop();
                      doctorBottomNavigationBar.navigateTo(1);
                    }
                  },
                  builder: (context, applyToJobAddState) {
                    final applyToJobAddCubit = context.read<ApplyToJobAddCubit>();
                    return _titleAndApplyBtn(
                      jobAddModel,
                      state,
                      () async {
                        if (jobAddModel?.id == null) return;
                        /* application content
                                    {
                                      'applyStatus': true,
                                      'notes': notesController.text,
                                    }
                                     */
                        final Map<String, dynamic>? application = await showDialog<Map<String, dynamic>?>(
                          context: context,
                          builder: (context) {
                            return ApplyToJobPopup(
                              jobAddId: (jobAddModel?.id)!,
                            );
                          },
                        );
                        if (application == null || !application['applyStatus']) return;
                        pr(application, 'application');
                        if (jobAddModel?.id == null) return;
                        applyToJobAddCubit.applyJobAdd(jobAddId: (jobAddModel?.id)!, notes: application['notes']);
                      },
                    );
                  },
                ),
                _sizer(),
                _buildInfoRow('Specialty', jobAddModel?.specialty?.name, state),
                _buildInfoRow('Job Info', jobAddModel?.jobInfo?.name, state),
                _buildInfoRow('Job Type', jobAddModel?.jobType, state),
                _buildSection('Location', jobAddModel?.location, state),
                _buildSection('Description', jobAddModel?.description, state),
                _buildSection('Responsibilities', jobAddModel?.responsibilities, state),
                _buildSection('Qualifications', jobAddModel?.qualifications, state),
                _buildSection('Experience Required', jobAddModel?.experienceRequired, state),
                _buildInfoRow('Salary Range', '\$${jobAddModel?.salaryMin} - \$${jobAddModel?.salaryMax}', state),
                _buildSection('Benefits', jobAddModel?.benefits, state),
                _buildInfoRow('Working Hours', jobAddModel?.workingHours, state),
                _buildInfoRow('Application Deadline', jobAddModel?.applicationDeadline, state),
                _buildSection('Required Documents', jobAddModel?.requiredDocuments, state),
                _buildInfoRow('Published At', (jobAddModel?.createdAt)?.split('T').first, state),
                _wrapWithLabel(
                    'Required Languages', (jobAddModel?.langs ?? []).map((lang) => lang.name ?? '').toList(), state),
                _wrapWithLabel(
                    'Required Skills', (jobAddModel?.skills ?? []).map((skill) => skill.name ?? '').toList(), state),
                ReviewList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _titleAndApplyBtn(JobAddModel? jobAddModel, ShowJobAddState state, void Function()? handleApply) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headLine(jobAddModel?.title, state),
              _headLine(jobAddModel?.hospital?.facilityName, state),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: handleApply,
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(context.secondaryHeaderColor)),
            child: const Text('Apply'),
          ),
        ),
      ],
    );
  }

  Widget _sizer() {
    return const SizedBox(height: 16);
  }

  Widget _wrapWithLabel(String title, List<String> data, ShowJobAddState state) {
    if (data.isEmpty && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title),
        const SizedBox(height: 10),
        BadgeWrap(items: data),
        _sizer(),
      ],
    );
  }

  Widget _headLine(String? title, ShowJobAddState state) {
    if (title == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Text(
      title ?? '',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: context.primaryColor,
      ),
    );
  }

  Widget _buildSection(String? title, String? content, ShowJobAddState state) {
    if (content == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title ?? ''),
        _content(content ?? ''),
        _sizer(),
      ],
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.secondaryHeaderColor),
    );
  }

  Widget _content(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }

  // Helper to build key-value rows
  Widget _buildInfoRow(String label, String? value, ShowJobAddState state) {
    if (value == null && state.responseType == ResponseEnum.success) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(label),
          Expanded(
            child: Text(
              value ?? '',
              textAlign: TextAlign.end,
              style: const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'doctorName': 'Dr. John Doe',
      'speciality': 'Cardiologist',
      'rating': 4.5,
      'content': 'Excellent service and very professional. Highly recommended!'
    },
    {
      'doctorName': 'Dr. Jane Smith',
      'speciality': 'Dermatologist',
      'rating': 4.0,
      'content': 'Very attentive and knowledgeable. Great experience!'
    },
    {
      'doctorName': 'Dr. Emily White',
      'speciality': 'Pediatrician',
      'rating': 5.0,
      'content': 'Amazing with kids and very thorough in her diagnosis.'
    },
  ];

  ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const ReplyWidget();
        } else {
          return ReviewWidget(
            doctorName: reviews[index - 1]['doctorName'],
            speciality: reviews[index - 1]['speciality'],
            rating: reviews[index - 1]['rating'],
            content: reviews[index - 1]['content'],
          );
        }
      },
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final double rating;
  final String content;

  const ReviewWidget({
    super.key,
    required this.doctorName,
    required this.speciality,
    required this.rating,
    required this.content,
  });

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
              doctorName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.secondaryHeaderColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              speciality,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            RatingBarIndicator(
              rating: rating,
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
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyWidget extends StatelessWidget {
  const ReplyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave a Reply',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.secondaryHeaderColor,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Write your reply here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle reply submission
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
