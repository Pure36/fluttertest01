import 'package:flutter/material.dart';
import 'package:flutterdemo/models/data.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(
        firstName: 'สมชาย',
        lastName: 'นานา',
        houseNumber: '12',
        group: '2',
        supDistrict: 'สาวะถี',
        district: 'เมือง',
        province: 'ขอนแก่น')
  ];
  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    transactions.add(statement);
    notifyListeners();
  }

  void deleteTransaction() {
    transactions.removeAt;
    notifyListeners();
  }
}
