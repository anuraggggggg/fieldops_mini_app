import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/note_provider.dart';

class WorkNoteSection extends StatefulWidget {
  final String jobId;

  const WorkNoteSection({
    super.key,
    required this.jobId,
  });

  @override
  State<WorkNoteSection> createState() => _WorkNoteSectionState();
}

class _WorkNoteSectionState extends State<WorkNoteSection> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        final notes = provider.notesForJob(widget.jobId);

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Work Notes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: controller,
                  maxLines: 4,
                  maxLength: 300,
                  decoration: const InputDecoration(
                    hintText: "Enter work note...",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.saving
                        ? null
                        : () async {
                      final error = await provider.addNote(
                        jobId: widget.jobId,
                        author: "Anurag",
                        note: controller.text,
                      );

                      if (!mounted) return;

                      if (error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                          ),
                        );
                        return;
                      }

                      controller.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Note added successfully"),
                        ),
                      );
                    },
                    child: provider.saving
                        ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Text("ADD NOTE"),
                  ),
                ),

                const SizedBox(height: 24),

                const Divider(),

                const SizedBox(height: 10),

                const Text(
                  "Activity Timeline",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                if (notes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "No work notes available.",
                      ),
                    ),
                  ),

                if (notes.isNotEmpty)
                  ...notes.map(
                        (note) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text(note.author),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            Text(note.note),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat(
                                "dd MMM yyyy • hh:mm a",
                              ).format(note.createdAt),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
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
}