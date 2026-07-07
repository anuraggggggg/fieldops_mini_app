import '../data/dummy_jobs.dart';
import '../model/job_model.dart';

Future<List<Job>> fetchJobs() async {

  await Future.delayed(
    const Duration(milliseconds:900),
  );

  return dummyJobs;

}