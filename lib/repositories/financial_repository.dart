import 'dart:convert';

import 'package:financial_manager/core/constants/endpoints.dart';
import 'package:financial_manager/models/response/graph_model.dart';
import 'package:financial_manager/models/response/summary_model.dart';
import 'package:financial_manager/models/response/transaction_model.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/services/http/http_exeption.dart';
import 'package:flutter/material.dart';

class FinancialRepository extends ChangeNotifier {
  final ApiClient apiClient;

  FinancialRepository({required this.apiClient});

  Future<SummaryModel> getSummaryData(String userId, String token) async {
    try {
      final response = await apiClient.getData(
        '${Endpoints.getSummary}/$userId',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = jsonDecode(response.body);
      final summary = SummaryModel.fromJson(body['total']);
      return summary;
    } on HttpExceptionModel {
      rethrow;
    }
  }

  Future<GraphModel> getFinancialGraph(String userId, String token) async {
    try {
      final response = await apiClient.getData(
        '${Endpoints.financial}/$userId',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = jsonDecode(response.body);
      final graph = GraphModel.fromJson(body['total']);
      return graph;
    } on HttpExceptionModel {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactionsData(
      DateTime startDate,
      DateTime endDate,
      String? categoryId,
      String? sortByValue,
      String? sortByDate,
      String userId,
      String token,
      int offset,
      int limit) async {
    try {
      List<TransactionModel> transactions = [];
      final response = await apiClient.postData(
        Endpoints.getTransaction,
        queryParams: {"userId": userId, "limit": "$limit", "offset": "$offset"},
        body: {
          "startDate":
              "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
          "endDate":
              "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
          "categoryId": categoryId,
          "sortByValue": sortByValue,
          "sortByDate": sortByDate
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = jsonDecode(response.body);
      for (var element in body['response']) {
        transactions.add(TransactionModel.fromMap(element));
      }
      return transactions;
    }    catch(e){
      rethrow;
    }
  }
}
