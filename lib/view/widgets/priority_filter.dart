import 'package:fieldops_mini_app/controller/job_provider.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class PriorityFilter extends StatelessWidget {
  final JobProvider provider;
  final String priority;

  const PriorityFilter({
    super.key,
    required this.provider,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.priorityFilter == priority;

    Color getPriorityColor() {
      switch (priority.toLowerCase()) {
        case 'high':
          return AppColors.priorityHigh;
        case 'medium':
          return AppColors.priorityMedium;
        case 'low':
          return AppColors.priorityLow;
        default:
          return AppColors.primary;
      }
    }

    Color getBackgroundColor() {
      if (isSelected) {
        switch (priority.toLowerCase()) {
          case 'high':
            return AppColors.priorityHighLight;
          case 'medium':
            return AppColors.priorityMediumLight;
          case 'low':
            return AppColors.priorityLowLight;
          default:
            return AppColors.primaryLight;
        }
      }
      return Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (priority.toLowerCase() != 'all')
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: getPriorityColor(),
                  shape: BoxShape.circle,
                ),
              ),
            if (priority.toLowerCase() != 'all')
              const SizedBox(width: 6),
            Text(
              priority == 'All' ? 'ALL' : priority.toUpperCase(),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 12,
                color: isSelected ? getPriorityColor() : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        selected: isSelected,
        onSelected: (_) {
          provider.filterPriority(priority);
        },
        backgroundColor: Colors.transparent,
        selectedColor: getBackgroundColor(),
        side: BorderSide(
          color: isSelected ? getPriorityColor() : AppColors.border,
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