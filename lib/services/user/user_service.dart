import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/repositories/user_repository.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class UserService extends ChangeNotifier {
  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<UserModel> getUser() async {
    try {
      final token = await UserTokenService.instance.getToken();
      return await userRepository.getUser(token ?? '');
    } catch (e) {
      rethrow;
    }
  }
}
