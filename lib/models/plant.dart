class Plant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Plant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}
