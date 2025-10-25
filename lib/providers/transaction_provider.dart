import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final Box<Transaction> _transactionBox = Hive.box<Transaction>('transactions');

  List<Transaction> get transactions => _transactionBox.values.toList();

  void addTransaction(Transaction transaction) {
    _transactionBox.add(transaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    final keyToRemove = _transactionBox.keys.firstWhere(
          (key) => _transactionBox.get(key)!.id == id,
      orElse: () => null,
    );
    if (keyToRemove != null) {
      _transactionBox.delete(keyToRemove);
      notifyListeners();
    }
  }
}
