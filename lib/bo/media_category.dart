class MediaCategory {
  final String title;
  final String subtitle;

  MediaCategory(this.title, this.subtitle);

  factory MediaCategory.fromJson(Map<String, dynamic> json) {
    return MediaCategory(json['name'] ?? '', json['subtitle'] ?? '');
  }
}
