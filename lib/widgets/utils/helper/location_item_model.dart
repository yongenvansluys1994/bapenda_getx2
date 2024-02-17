class LocationDropdownModel {
  final String? id;
  final String? name;
  final String? query;

  LocationDropdownModel({
    required this.id,
    required this.name,
    this.query,
  });

  factory LocationDropdownModel.fromJson(Map<String, dynamic> json) {
    return LocationDropdownModel(
      id: json["id"],
      name: json["name"],
      query: json["query"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['query'] = query;
    return data;
  }
}
