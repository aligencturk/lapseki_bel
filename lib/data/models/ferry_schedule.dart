class FerrySchedule {
  final List<String> times;
  final String direction;

  FerrySchedule({
    required this.times,
    required this.direction,
  });

  factory FerrySchedule.fromJson(Map<String, dynamic> json) {
    return FerrySchedule(
      times: (json['times'] as List).map((e) => e.toString()).toList(),
      direction: json['direction'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'times': times,
      'direction': direction,
    };
  }
}

