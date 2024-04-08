class BookModel {
  final int id;
  final String title;
  final String body;
  final int userId;

  BookModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.userId});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'userId': userId};
  }
}
