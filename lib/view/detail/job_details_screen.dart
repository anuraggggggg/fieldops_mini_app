import 'package:fieldops_mini_app/controller/job_provider.dart';
import 'package:fieldops_mini_app/model/job_model.dart';
import 'package:fieldops_mini_app/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../work_note_section.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;

  const JobDetailsScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        final nextStatus = provider.getNextStatus(job.status);

        return Scaffold(
          appBar: const CommonAppBar(
            title: "Job Details",

          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(job),

                const SizedBox(height: 20),

                _infoCard(
                  title: "Customer Information",
                  children: [
                    _infoTile("Customer", job.customerName),
                    _infoTile("Phone", job.customerPhone),
                    _infoTile("Address", job.customerAddress),
                  ],
                ),

                const SizedBox(height: 16),

                _infoCard(
                  title: "Service Details",
                  children: [
                    _infoTile("Service", job.serviceType),
                    _infoTile("Description", job.description),
                    _infoTile(
                      "Scheduled",
                      DateFormat(
                        "dd MMM yyyy • hh:mm a",
                      ).format(job.scheduledAt),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _infoCard(
                  title: "Job Information",
                  children: [
                    _infoTile("Job ID", job.id),
                    _infoTile("Priority", job.priority.toUpperCase()),
                    _infoTile("Status", job.status.replaceAll("_", " ")),
                    _infoTile(
                      "Latitude",
                      job.latitude.toString(),
                    ),
                    _infoTile(
                      "Longitude",
                      job.longitude.toString(),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                WorkNoteSection(
                  jobId: job.id,
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: nextStatus == null
                        ? null
                        : () {
                      // confirmation dialog
                    },
                    child: Text(
                      nextStatus == null
                          ? "Completed"
                          : nextStatus == "in_progress"
                          ? "Start Job"
                          : "Complete Job",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headerCard(Job job) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: Text(
                job.customerName[0],
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.customerName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(job.id),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      job.status.replaceAll("_", " ").toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
