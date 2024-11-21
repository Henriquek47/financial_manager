import 'dart:convert';

import 'package:financial_manager/core/constants/endpoints.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/services/http/http_exeption.dart';
import 'package:flutter/material.dart';

class UserRepository extends ChangeNotifier {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<UserModel> getUser(String token) async {
    try {
      final response = await apiClient.getData(
        Endpoints.getUser,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final body = jsonDecode(response.body);
      final user = UserModel.fromJson(body['response']);
      return user;
    } on HttpExceptionModel {
      rethrow;
    }
  }
}
