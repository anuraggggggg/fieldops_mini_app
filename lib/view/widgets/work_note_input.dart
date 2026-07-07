import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/note_provider.dart';

class WorkNoteInput extends StatefulWidget {
  final String jobId;

  const WorkNoteInput({
    super.key,
    required this.jobId,
  });

  @override
  State<WorkNoteInput> createState() => _WorkNoteInputState();
}

class _WorkNoteInputState extends State<WorkNoteInput> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> saveNote() async {
    if (!formKey.currentState!.validate()) return;

    final provider = context.read<NoteProvider>();

    final error = await provider.addNote(
      jobId: widget.jobId,
      author: "Anurag",
      note: controller.text,
    );

    if (!mounted) return;

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    controller.clear();
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Work note added"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
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

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: controller,
                    maxLines: 4,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      hintText: "Enter work note...",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? "";

                      if (text.isEmpty) {
                        return "Note is required";
                      }

                      if (text.length < 5) {
                        return "Minimum 5 characters";
                      }

                      if (text.length > 300) {
                        return "Maximum 300 characters";
                      }

                      return null;
                    },
                    onChanged: (_) {
                      setState(() {});
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${controller.text.trim().length}/300",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                      provider.saving ? null : saveNote,
                      child: provider.saving
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Save Note"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}