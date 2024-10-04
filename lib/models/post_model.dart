class Post {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Post({required this.id, required this.title, required this.description, required this.imageUrl});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image'] as String,
    );
  }
}
