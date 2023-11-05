class Items {
  String category;
  String itemId;
  String name;
  int price;
  int quantity;

  Items(
      {required this.category,
      required this.name,
      required this.price,
      required this.quantity,
      required this.itemId});

  // Factory method to create Item objects from a Map
  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
        category: map['category'],
        name: map['item_name'],
        price: map['price'],
        quantity: map['quantity'],
        itemId: map["item_id"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'category': category,
      "item_id": itemId
    };
  }

  @override
  String toString() {
    return '{category: $category, name: $name, price: $price, quantity: $quantity}';
  }
}
