import 'package:fieldops_mini_app/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../detail/job_details_screen.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({
    super.key,
    required this.job,
  });

  Color _statusColor() {
    switch (job.status) {
      case "assigned":
        return Colors.orange;

      case "in_progress":
        return Colors.blue;

      case "completed":
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JobDetailsScreen(job: job),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      job.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      job.status.replaceAll("_", " ").toUpperCase(),
                    ),
                    backgroundColor:
                    _statusColor().withOpacity(.15),
                    labelStyle: TextStyle(
                      color: _statusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.person_outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(job.customerName),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.build_circle_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(job.serviceType),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      DateFormat(
                        "dd MMM yyyy • hh:mm a",
                      ).format(job.scheduledAt),
                    ),
                  ),
                ],
              ),

              const Divider(height: 24),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      job.priority.toUpperCase(),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}