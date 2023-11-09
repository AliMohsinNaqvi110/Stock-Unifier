class Orders {
  String vendorName;
  String orderId;
  String status;
  DateTime date;
  int selectedItemCount;
  int totalPrice;
  List<dynamic> selectedItems;

  Orders(
      {required this.vendorName,
      required this.orderId,
      required this.date,
      required this.selectedItemCount,
      required this.totalPrice,
      required this.selectedItems,
      required this.status});
}
