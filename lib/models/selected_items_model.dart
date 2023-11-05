import 'package:flutter/material.dart';
import 'package:inventory_management/models/items_model.dart';

class SelectedItems extends ChangeNotifier {
  List<Items> selectedItems = [];
  int selectedItemCount = 0;
  int totalPrice = 0;

  void addSelectedItem(Items item) {
    selectedItems.add(item);
    selectedItemCount += item.quantity;
    totalPrice += item.quantity * item.price;
    notifyListeners();
  }

  void increaseItemQuantity(String itemId) {
    int index = selectedItems.indexWhere((item) => item.itemId == itemId);
    if (index != -1) {
      selectedItems[index].quantity++;
      selectedItemCount++;
      totalPrice += selectedItems[index].price;
      notifyListeners();
    }
  }

  int getItemQuantity(String itemId) {
    final int quantityIndex =
        selectedItems.indexWhere((element) => element.itemId == itemId);

    return selectedItems[quantityIndex].quantity;
  }

  void removeSelectedItem(String itemId) {
    int index = selectedItems
        .indexWhere((selectedItem) => selectedItem.itemId == itemId);

    if (index != -1) {
      Items removedItem = selectedItems[index];
      selectedItems.removeAt(index);
      selectedItemCount -= removedItem.quantity;
      totalPrice -= removedItem.quantity * removedItem.price;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(String itemId) {
    int index = selectedItems.indexWhere((item) => item.itemId == itemId);
    if (index != -1 && selectedItems[index].quantity > 1) {
      selectedItems[index].quantity--;
      selectedItemCount--;
      totalPrice -= selectedItems[index].price;
      notifyListeners();
    }
  }

  Map<String, dynamic> toMap() {
    List itemsMapList = selectedItems.map((item) => item.toMap()).toList();
    return {
      'selectedItems': itemsMapList,
      'selectedItemCount': selectedItemCount,
      'totalPrice': totalPrice,
    };
  }

  void clearSelectedItems() {
    selectedItems.clear();
    selectedItemCount = 0;
    totalPrice = 0;
    notifyListeners();
  }
}
