class Post {
  final String title;
  final String content;
  final String owner;

  Post({required this.title, required this.content, required this.owner});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'owner': owner,
    };
  }
}
