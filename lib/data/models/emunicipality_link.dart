class EMunicipalityLink {
  final String title;
  final String url;
  final String iconName;

  EMunicipalityLink({
    required this.title,
    required this.url,
    required this.iconName,
  });

  factory EMunicipalityLink.fromJson(Map<String, dynamic> json) {
    return EMunicipalityLink(
      title: json['title'] as String,
      url: json['url'] as String,
      iconName: json['iconName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'iconName': iconName,
    };
  }
}

