import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_app/core/widgets/default_drawer.dart';
import 'package:locum_app/core/widgets/main_scaffold.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';
import 'package:locum_app/features/doctor/doctor_locum/presentation/cubits/show_job_add/show_job_add_cubit.dart';

class DoctorJobAddDetailsView extends StatefulWidget {
  final int id;

  const DoctorJobAddDetailsView({
    super.key,
    required this.id,
  });

  @override
  State<DoctorJobAddDetailsView> createState() =>
      _DoctorJobAddDetailsViewState();
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
                Text(
                  jobAddModel?.title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                // Hospital Name
                Text(
                  jobAddModel?.hospital?.facilityName ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 16),

                // Specialty and Job Info
                _buildInfoRow('Specialty', jobAddModel?.specialty?.name ?? ''),
                _buildInfoRow('Job Info', jobAddModel?.jobInfo?.name ?? ''),
                _buildInfoRow('Job Type', jobAddModel?.jobType ?? ''),

                const SizedBox(height: 16),

                // Location
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.location ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Responsibilities
                const Text(
                  'Responsibilities',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.responsibilities ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Qualifications
                const Text(
                  'Qualifications',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.qualifications ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Experience Required
                const Text(
                  'Experience Required',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.experienceRequired ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                // _buildInfoRow('Experience Required', jobAddModel?.experienceRequired ?? ''),

                const SizedBox(height: 16),

                // Salary Range
                _buildInfoRow('Salary Range',
                    '\$${jobAddModel?.salaryMin} - \$${jobAddModel?.salaryMax}'),

                const SizedBox(height: 16),

                // Benefits
                const Text(
                  'Benefits',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.benefits ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Working Hours
                _buildInfoRow('Working Hours', jobAddModel?.workingHours ?? ''),

                const SizedBox(height: 16),

                // Application Deadline
                _buildInfoRow('Application Deadline',
                    jobAddModel?.applicationDeadline ?? ''),

                const SizedBox(height: 16),

                // Required Documents
                const Text(
                  'Required Documents',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobAddModel?.requiredDocuments ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 16),

                // Published At
                _buildInfoRow('Published At', jobAddModel?.createdAt ?? ''),

                const SizedBox(height: 16),

                // Required Languages
                const Text(
                  'Required Languages',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: (jobAddModel?.langs ?? [])
                      .map((lang) => Chip(
                            label: Text(lang.name ?? ''),
                            backgroundColor: Colors.blue[50],
                            labelStyle: const TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 16),

                // Required Skills
                const Text(
                  'Required Skills',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: (jobAddModel?.skills ?? [])
                      .map((skill) => Chip(
                            label: Text(skill.name ?? ''),
                            backgroundColor: Colors.blue[50],
                            labelStyle: const TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper to build key-value rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
