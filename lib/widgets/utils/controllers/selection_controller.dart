import 'package:bapenda_getx2/widgets/utils/helper/dropdown_model.dart';
import 'package:flutter/rendering.dart';

class SelectionController {
  String label;
  List<DropdownModel> items;
  int column;
  DropdownModel? selectedItem;
  VoidCallback? updateFunc;
  Function(DropdownModel?)? onChangeFunc;
  List<DropdownModel>? defualtItem;
  SelectionController({
    required this.label,
    required this.items,
    required this.column,
    this.selectedItem,
    this.updateFunc,
    this.onChangeFunc,
    this.defualtItem,
  });

  bool isValid = true;

  reset() {
    selectedItem = null;
    isValid = true;
  }

  onChange(DropdownModel? value) {
    selectedItem = value;
    isValid = true;
    if (onChangeFunc == null) return;
    onChangeFunc!(value);
  }

  int get totalRow {
    if (column == 0) return items.length;
    return (items.length / column).ceil();
  }

  bool checkValid() {
    isValid = selectedItem != null;
    return isValid;
  }

  updateList(List<DropdownModel> items) {
    this.items = [...?defualtItem, ...items];
    isValid = true;
    selectedItem = null;
  }

  clearItems() {
    items = [];
    isValid = true;
    selectedItem = null;
  }

  SelectionController copyWith({
    String? label,
    List<DropdownModel>? items,
    DropdownModel? selectedItem,
    int? column,
  }) {
    return SelectionController(
      label: label ?? this.label,
      items: items ?? this.items,
      selectedItem: selectedItem ?? this.selectedItem,
      column: column ?? this.column,
    );
  }
}
