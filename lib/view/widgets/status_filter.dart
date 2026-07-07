import 'package:fieldops_mini_app/controller/job_provider.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class StatusFilter extends StatelessWidget {
  final JobProvider provider;
  final String status;

  const StatusFilter({
    super.key,
    required this.provider,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.statusFilter == status;

    Color getStatusColor() {
      switch (status.toLowerCase()) {
        case 'assigned':
          return AppColors.statusAssigned;
        case 'in_progress':
          return AppColors.statusInProgress;
        case 'completed':
          return AppColors.statusCompleted;
        default:
          return AppColors.primary;
      }
    }

    Color getBackgroundColor() {
      if (isSelected) {
        switch (status.toLowerCase()) {
          case 'assigned':
            return AppColors.statusAssignedLight;
          case 'in_progress':
            return AppColors.statusInProgressLight;
          case 'completed':
            return AppColors.statusCompletedLight;
          default:
            return AppColors.primaryLight;
        }
      }
      return Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Text(
          status == 'All' ? 'ALL' : status.toUpperCase().replaceAll('_', ' '),
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
            color: isSelected ? getStatusColor() : AppColors.textSecondary,
          ),
        ),
        selected: isSelected,
        onSelected: (_) {
          provider.filterStatus(status);
        },
        backgroundColor: Colors.transparent,
        selectedColor: getBackgroundColor(),
        side: BorderSide(
          color: isSelected ? getStatusColor() : AppColors.border,
          width: isSelected ? 1.5 : 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        showCheckmark: false,
        elevation: 0,
      ),
    );
  }
}