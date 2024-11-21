import 'package:financial_manager/core/constants/endpoints.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class PaymentRepository extends ChangeNotifier {
  final ApiClient apiClient;

  PaymentRepository({required this.apiClient});

  Future<void> payment(String categoryId, String userId, double value) async {
    try {
      final token = await UserTokenService.instance.getToken();
      await apiClient.postData(Endpoints.transaction, body: {
        "userId": userId,
        "receiverId": null,
        "value": value,
        "categoryId": categoryId
      }, headers: {
        'Authorization': 'Bearer $token',
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rec(String userId, double value) async {
    try {
      final token = await UserTokenService.instance.getToken();
      await apiClient.postData(Endpoints.transaction, body: {
        "userId": userId,
        "receiverId": userId,
        "value": value,
      }, headers: {
        'Authorization': 'Bearer $token',
      });
    } catch (e) {
      rethrow;
    }
  }
}
