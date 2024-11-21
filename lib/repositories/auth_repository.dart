import 'dart:convert';

import 'package:financial_manager/core/constants/endpoints.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/services/http/http_exeption.dart';
import 'package:flutter/material.dart';

class AuthRepository extends ChangeNotifier {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<UserModel> signUp(String email, String name, String password) async {
    try {
      final response = await apiClient.postData(Endpoints.signUp,
          body: {"email": email, "name": name, "password": password});
      final body = jsonDecode(response.body);
      final user = UserModel.fromJson(body['response']);
      return user;
    } on HttpExceptionModel {
      rethrow;
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await apiClient.postData(Endpoints.signIn,
          body: {"email": email, "password": password});
      final body = jsonDecode(response.body);
      final user = UserModel.fromJson(body['response']);
      return user;
    } on HttpExceptionModel {
      rethrow;
    }
  }

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
