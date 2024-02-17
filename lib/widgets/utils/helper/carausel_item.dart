enum SourceType { asset, url }

class CarauselItem {
  final String? id;
  final String imageAsset;
  final String text;
  final SourceType type;

  CarauselItem({
    required this.imageAsset,
    required this.text,
    required this.type,
    this.id,
  });
}
