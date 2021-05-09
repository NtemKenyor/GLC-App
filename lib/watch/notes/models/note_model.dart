class NoteModel {
  final int id;
  final String title, content, createDate, upDated;

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.createDate,
    this.upDated
  });

  factory NoteModel.fromJson(Map<String, dynamic> jsonData) {
    return NoteModel(
      id: jsonData['id'],
      title: jsonData['title'],
      content: jsonData['text'],
      createDate: jsonData['created_at'],
      upDated: jsonData['updated_at'],
    );
  }
}