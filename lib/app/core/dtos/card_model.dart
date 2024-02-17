class CardItems {
  String? itemNumber;
  String? materialNumber;
  String? batchNumber;
  String? serialNumber;
  String? qty;
  String? materialDescription;
  List<CardImage>? image;
  String? status;
  String? mode;
  bool? isDeliveryNote;
  bool? isTagging;
  bool? isStamp;
  bool? isQuantity;

  CardItems(
      {this.itemNumber,
      this.materialNumber,
      this.batchNumber,
      this.serialNumber,
      this.qty,
      this.materialDescription,
      this.image,
      this.status,
      this.mode,
      this.isDeliveryNote,
      this.isTagging,
      this.isStamp,
      this.isQuantity});

  CardItems.fromJson(Map<String, dynamic> json) {
    itemNumber = json['item_number'];
    materialNumber = json['material_number'];
    batchNumber = json['batch_number'];
    serialNumber = json['serial_number'];
    qty = json['qty'];
    materialDescription = json['material_description'];
    if (json['image'] != null) {
      image = <CardImage>[];
      json['image'].forEach((v) {
        image?.add(CardImage.fromJson(v));
      });
    }
    status = json['status'];
    mode = json['mode'];
    isDeliveryNote = json['isDeliveryNote'];
    isTagging = json['isTagging'];
    isStamp = json['isStamp'];
    isQuantity = json['isQuantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['item_number'] = itemNumber;
    data['material_number'] = materialNumber;
    data['batch_number'] = batchNumber;
    data['serial_number'] = serialNumber;
    data['qty'] = qty;
    data['material_description'] = materialDescription;
    if (image != null) {
      data['image'] = image?.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['mode'] = mode;
    data['isDeliveryNote'] = isDeliveryNote;
    data['isTagging'] = isTagging;
    data['isStamp'] = isStamp;
    data['isQuantity'] = isQuantity;
    return data;
  }
}

class CardImage {
  String? name;

  CardImage({this.name});

  CardImage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
