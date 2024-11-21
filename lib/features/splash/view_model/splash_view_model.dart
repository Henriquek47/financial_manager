import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:financial_manager/repositories/auth_repository.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  final AuthRepository authRepository;

  SplashViewModel({required this.authRepository});

  Future<StatusResult> getUser() async {
    try {
      final token = await UserTokenService.instance.getToken();
      if (token != null) {
        await authRepository.getUser(token);
        return StatusResult.success(doNotShow: true);
      } else{
        return StatusResult.failure(doNotShow: true);
      }
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }
}
