import 'package:flutter/material.dart';

import '../model/work_note_model.dart';

class NoteProvider extends ChangeNotifier {
  bool _saving = false;

  bool get saving => _saving;

  final List<WorkNote> _notes = [];

  List<WorkNote> get notes => List.unmodifiable(_notes);

  List<WorkNote> notesForJob(String jobId) {
    final jobNotes =
    _notes.where((e) => e.jobId == jobId).toList();

    jobNotes.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return jobNotes;
  }

  Future<String?> addNote({
    required String jobId,
    required String author,
    required String note,
  }) async {
    if (_saving) return "Please wait...";

    final trimmed = note.trim();

    if (trimmed.isEmpty) {
      return "Note cannot be empty";
    }

    if (trimmed.length < 5) {
      return "Minimum 5 characters required";
    }

    if (trimmed.length > 300) {
      return "Maximum 300 characters allowed";
    }

    _saving = true;
    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    _notes.insert(
      0,
      WorkNote(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        jobId: jobId,
        author: author,
        note: trimmed,
        createdAt: DateTime.now(),
      ),
    );

    _saving = false;
    notifyListeners();

    return null;
  }
}