class Vendor {
  final String name;
  final int balance;
  final int dues;
  final String distributorUid;

  Vendor({required this.name, required this.balance, required this.dues, required this.distributorUid});

  @override
  String toString() {
    return 'Vendor{name: $name, balance: $balance, dues: $dues, distributorUid: $distributorUid}';
  }
}
