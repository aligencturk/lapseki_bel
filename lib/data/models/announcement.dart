class Announcement {
  final String title;
  final String date;
  final String? description;
  final String? url;

  Announcement({
    required this.title,
    required this.date,
    this.description,
    this.url,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      title: json['title'] as String,
      date: json['date'] as String,
      description: json['description'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'url': url,
    };
  }
}
