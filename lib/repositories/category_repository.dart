import 'dart:convert';

import 'package:financial_manager/core/constants/endpoints.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/services/http/api_client.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class CategoryRepository extends ChangeNotifier {
  final ApiClient apiClient;

  CategoryRepository({required this.apiClient});

  Future<List<CategoryModel>> getCategories(String userId) async {
    try {
      final list = <CategoryModel>[];
      final token = await UserTokenService.instance.getToken();
      final response =
          await apiClient.getData("${Endpoints.category}/$userId", headers: {
        'Authorization': 'Bearer $token',
      });
      final body = jsonDecode(response.body);
      for (var element in body['response']) {
        list.add(CategoryModel.fromMap(element));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
