class Event {
  final String title;
  final String date;
  final String time;
  final String? description;
  final String? location;
  final String? imageUrl;

  Event({
    required this.title,
    required this.date,
    required this.time,
    this.description,
    this.location,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'description': description,
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}

