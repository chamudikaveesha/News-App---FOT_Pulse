class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final DateTime publishedAt;
  final String content;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return NewsModel(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      publishedAt: data['publishedAt']?.toDate() ?? DateTime.now(),
      content: data['content'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}