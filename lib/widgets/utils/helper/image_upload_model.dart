import 'package:image_picker/image_picker.dart';

enum ImageSourceType { xfile, url }

class ImageUploadModel {
  final String id;
  final String title;
  final String? text;
  XFile? file;
  String? imageUrl;
  ImageSourceType sourceType;
  bool valid = true;

  reset() {
    valid = true;
    file = null;
  }

  ImageUploadModel({
    required this.id,
    required this.title,
    this.text,
    this.file,
    this.imageUrl,
    this.sourceType = ImageSourceType.xfile,
  });

  bool isNotEmpty() {
    return imageUrl?.isNotEmpty ?? false || file != null;
  }

  updateImage(XFile? pickImage) {
    valid = true;
    sourceType = ImageSourceType.xfile;
    file = pickImage;
  }

  bool checkValid() {
    valid = imageUrl?.isNotEmpty ?? false || file != null;
    return valid;
  }

  static ImageUploadModel emptyController() {
    return ImageUploadModel(id: "", title: "");
  }
}
