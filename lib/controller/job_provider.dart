import 'package:flutter/material.dart';

import '../model/job_model.dart';
import '../services/local_storage_service.dart';
import '../services/mock_job_service.dart' as repository;


class JobProvider extends ChangeNotifier {
  bool loading = false;
  bool hasError = false;

  List<Job> jobs = [];
  List<Job> filteredJobs = [];

  String search = "";
  String statusFilter = "All";
  String priorityFilter = "All";

  Future<void> loadJobs() async {
    loading = true;
    hasError = false;
    notifyListeners();

    try {
      /// Load from Secure Storage first
      final localJobs =
      await StorageService.read(StorageService.jobsKey);

      if (localJobs != null) {
        jobs = (localJobs as List)
            .map((e) => Job.fromJson(e))
            .toList();
      } else {
        /// First launch
        jobs = await repository.fetchJobs();

        await StorageService.write(
          StorageService.jobsKey,
          jobs.map((e) => e.toJson()).toList(),
        );
      }

      applyFilters();
    } catch (e) {
      hasError = true;
    }

    loading = false;
    notifyListeners();
  }

  // ---------------- SEARCH ----------------

  void searchJobs(String query) {
    search = query;
    applyFilters();
  }

  // ---------------- FILTERS ----------------

  void filterStatus(String status) {
    statusFilter = status;
    applyFilters();
  }

  void filterPriority(String priority) {
    priorityFilter = priority;
    applyFilters();
  }

  void applyFilters() {
    filteredJobs = jobs.where((job) {
      final matchesSearch =
          search.isEmpty ||
              job.id.toLowerCase().contains(search.toLowerCase()) ||
              job.customerName
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              job.serviceType
                  .toLowerCase()
                  .contains(search.toLowerCase());

      final matchesStatus =
          statusFilter == "All" ||
              job.status == statusFilter;

      final matchesPriority =
          priorityFilter == "All" ||
              job.priority == priorityFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesPriority;
    }).toList();

    notifyListeners();
  }

  // ---------------- STATUS FLOW ----------------

  String? getNextStatus(String currentStatus) {
    switch (currentStatus) {
      case "assigned":
        return "in_progress";

      case "in_progress":
        return "completed";

      case "completed":
        return null;

      default:
        return null;
    }
  }

  bool canUpdateStatus(Job job) {
    return job.status != "completed";
  }

  Future<bool> updateJobStatus(Job job) async {
    final nextStatus = getNextStatus(job.status);

    if (nextStatus == null) {
      return false;
    }

    try {
      loading = true;
      notifyListeners();

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      job.status = nextStatus;

      /// Save updated jobs
      await StorageService.write(
        StorageService.jobsKey,
        jobs.map((e) => e.toJson()).toList(),
      );

      applyFilters();

      loading = false;
      notifyListeners();

      return true;
    } catch (e) {
      loading = false;
      notifyListeners();

      return false;
    }
  }


  int get totalJobs => jobs.length;

  int get assignedJobs =>
      jobs.where((e) => e.status == "assigned").length;

  int get inProgressJobs =>
      jobs.where((e) => e.status == "in_progress").length;

  int get completedJobs =>
      jobs.where((e) => e.status == "completed").length;
}