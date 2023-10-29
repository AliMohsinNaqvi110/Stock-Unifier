
class Sale {
  final int id;
  final int itemCount;
  final int totalCost;
  final DateTime soldDate;
  final String vendorName;

  Sale(
      {required this.id,
      required this.itemCount,
      required this.totalCost,
      required this.soldDate,
      required this.vendorName});
}
