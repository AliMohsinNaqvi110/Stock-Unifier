import 'package:flutter/material.dart';

class DashboardStats extends ChangeNotifier {
 int monthlySales = 0;
 int itemCount = 0;
 int profitEarned = 0;
 int inventoryCost = 0;
 int pendingPayment = 0;

 getInvData(List<dynamic> snapshot) {
   itemCount = snapshot.length;
   snapshot.map((e) => {
   inventoryCost += int.parse(e.price)
  });
   notifyListeners();
 }
 getSalesData(Map<String,dynamic> json) {
   profitEarned = json["profit_earned"];
   monthlySales = json["total_sales"];
   pendingPayment = json["pending_payments"];
   notifyListeners();
 }
}
