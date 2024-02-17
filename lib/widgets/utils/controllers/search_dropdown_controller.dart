import 'package:bapenda_getx2/widgets/utils/helper/dropdown_model.dart';
import 'package:flutter/rendering.dart';

class SearchDropdownController {
  String label;
  List<DropdownModel> items;
  DropdownModel? selectedItem;
  VoidCallback? updateFunc;
  Function(DropdownModel?)? onChangeFunc;
  List<DropdownModel>? defualtItem;
  SearchDropdownController({
    required this.label,
    required this.items,
    this.selectedItem,
    this.updateFunc,
    this.onChangeFunc,
    this.defualtItem,
  });

  bool isValid = true;

  onChange(DropdownModel? value) {
    selectedItem = value;
    isValid = true;
    if (onChangeFunc == null) return;
    onChangeFunc!(value);
  }

  bool checkValid() {
    isValid = selectedItem != null;
    return isValid;
  }

  updateList(List<DropdownModel> items) {
    this.items = [...?defualtItem, ...items];
    isValid = true;
  }

  clearItems() {
    items = [];
    isValid = true;
    selectedItem = null;
  }

  SearchDropdownController copyWith({
    String? label,
    List<DropdownModel>? items,
    DropdownModel? selectedItem,
  }) {
    return SearchDropdownController(
      label: label ?? this.label,
      items: items ?? this.items,
      selectedItem: selectedItem ?? this.selectedItem,
      onChangeFunc: onChangeFunc,
    );
  }
}
