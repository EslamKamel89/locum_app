import 'package:flutter/material.dart';
import 'package:locum_app/core/extensions/context-extensions.dart';
import 'package:locum_app/core/router/app_routes_names.dart';
import 'package:locum_app/features/doctor/doctor_locum/domain/models/job_add_model.dart';

class JobAdWidget extends StatelessWidget {
  final JobAddModel jobAddModel;

  const JobAdWidget({
    super.key,
    required this.jobAddModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobAddModel.hospital?.facilityName ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 8),

            // Title
            Text(
              jobAddModel.title ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Specialty: ${jobAddModel.specialty?.name ?? ''}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              jobAddModel.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            // Job Type and Location
            Row(
              children: [
                Chip(
                  label: Text(jobAddModel.jobType ?? ''),
                  backgroundColor: Colors.blue[50],
                  labelStyle: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    jobAddModel.location ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutesNames.doctorJobDetailsScreen, arguments: {'id': jobAddModel.id});
              },
              child: Text(
                'Show Details',
                style: TextStyle(
                  fontSize: 14,
                  color: context.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.black54,
                ),
                const SizedBox(width: 4),
                Text(
                  jobAddModel.createdAt ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
