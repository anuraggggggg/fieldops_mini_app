class WorkNote {
  final String id;
  final String jobId;
  final String author;
  final String note;
  final DateTime createdAt;

  WorkNote({
    required this.id,
    required this.jobId,
    required this.author,
    required this.note,
    required this.createdAt,
  });

  factory WorkNote.fromJson(Map<String, dynamic> json) {
    return WorkNote(
      id: json["id"],
      jobId: json["jobId"],
      author: json["author"],
      note: json["note"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "jobId": jobId,
      "author": author,
      "note": note,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}