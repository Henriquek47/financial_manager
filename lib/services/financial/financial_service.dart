import 'package:financial_manager/models/response/graph_model.dart';
import 'package:financial_manager/models/response/summary_model.dart';
import 'package:financial_manager/models/response/transaction_model.dart';
import 'package:financial_manager/repositories/financial_repository.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class FinancialService extends ChangeNotifier {
  final FinancialRepository financialRepository;

  FinancialService({required this.financialRepository});

  Future<SummaryModel> getSummaryData(String userId) async {
    try {
      final token = await UserTokenService.instance.getToken();
      return await financialRepository.getSummaryData(userId, token ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<GraphModel> getFinancialGraph(String userId) async {
    try {
      final token = await UserTokenService.instance.getToken();
      return await financialRepository.getFinancialGraph(userId, token ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactions(
      DateTime startDate,
      DateTime endDate,
      String? categoryId,
      String? sortByValue,
      String? sortByDate,
      String userId,
      int offset) async {
    try {
      final token = await UserTokenService.instance.getToken();
      return await financialRepository.getTransactionsData(startDate, endDate,
          categoryId, sortByValue, sortByDate, userId, token ?? '', offset, 10);
    } catch (e) {
      rethrow;
    }
  }
}
