import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:financial_manager/models/response/transaction_model.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/services/financial/financial_service.dart';
import 'package:financial_manager/services/user/user_service.dart';
import 'package:flutter/material.dart';

class TransactionViewModel extends ChangeNotifier {
  final FinancialService financialService;
  final UserService userService;

  TransactionViewModel(
      {required this.financialService, required this.userService});

  UserModel? _user;

  UserModel? get user => _user;

  List<TransactionModel> transactions = [];

  final ValueNotifier<int> selectedValue = ValueNotifier(0);


  DateTime startDate = DateTime.utc(2020);
  DateTime endDate = DateTime.now();
  String? categoryId;
  String? sortByValue;
  String? sortByDate;

  Future<StatusResult> getUser() async {
    try {
      _user = await userService.getUser();
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }

  Future<StatusResult> getTransactions() async {
    try {
      if (user == null) return StatusResult.failure(doNotShow: true);
      final list = await financialService.getTransactions(startDate, endDate,
          categoryId, sortByValue, sortByDate, user!.id, transactions.length);
      transactions = [...transactions, ...list];
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }
}
