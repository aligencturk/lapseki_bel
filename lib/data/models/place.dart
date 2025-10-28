class Place {
  final String name;
  final String description;
  final String mapsUrl;
  final String? imageUrl;
  final double? latitude;
  final double? longitude;

  Place({
    required this.name,
    required this.description,
    required this.mapsUrl,
    this.imageUrl,
    this.latitude,
    this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String,
      description: json['description'] as String,
      mapsUrl: json['mapsUrl'] as String,
      imageUrl: json['imageUrl'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'mapsUrl': mapsUrl,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

