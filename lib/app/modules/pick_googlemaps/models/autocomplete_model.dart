class AutocompletePrediction {
  final String? description;
  final String? placeId;

  AutocompletePrediction({this.description, this.placeId});

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
