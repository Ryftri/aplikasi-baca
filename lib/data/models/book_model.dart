class BookModel {
  String? id;
  String creatorId;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  BookModel({
    this.id,
    required this.creatorId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'creator_id': creatorId,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookModel(
      id: docId,
      creatorId: map['creator_id'],
      title: map['title'],
      content: map['content'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
