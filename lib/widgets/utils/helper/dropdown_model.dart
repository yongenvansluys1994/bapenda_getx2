import 'package:flutter/cupertino.dart';

class DropdownModel {
  final String id;
  late final String text;
  final String name;
  final String query;
  final String? urlImage;
  final String? subtitle;
  final IconData? iconData;

  DropdownModel({
    this.id = "",
    this.text = "",
    this.urlImage,
    this.subtitle,
    this.name = "",
    this.query = "",
    this.iconData,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(
      id: json["_id"] ?? "",
      text: json["text"] ?? json["name"],
      urlImage: json["urlImage"],
      subtitle: json["subtitle"],
      name: json["name"],
      query: json["query"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['text'] = text;
    data['urlImage'] = urlImage;
    data['subtitle'] = subtitle;
    data['name'] = name;
    data['query'] = query;
    return data;
  }

  @override
  String toString() {
    return id;
  }
}
