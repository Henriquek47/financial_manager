import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/repositories/auth_repository.dart';
import 'package:financial_manager/services/http/http_exeption.dart';
import 'package:financial_manager/services/user/user_token_service.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthViewModel({required this.authRepository});

  UserModel? user;
  bool loading = false;

  Future<StatusResult> signUp(String name, String email, String password)async{
    try {
      loading = true;
      notifyListeners();
      final userModel = await authRepository.signUp(email, name, password);
      user = userModel;
      UserTokenService.instance.setToken(user!.token);
      loading = false;
      notifyListeners();
      return StatusResult.success(messageCode: 'Cadastro efetuado com sucesso');
    } on HttpExceptionModel catch (e) {
      loading = false;
      notifyListeners();
      return StatusResult.failure(messageCode: e.message);
    } catch (e){
      return StatusResult.failure(messageCode: "Algo deu errado");
    }
  }

   Future<StatusResult> signIn(String email, String password)async{
    try {
      loading = true;
      notifyListeners();
      final userModel = await authRepository.signIn(email, password);
      user = userModel;
      UserTokenService.instance.setToken(user!.token);
      loading = false;
      notifyListeners();
      return StatusResult.success(messageCode: 'Login efetuado com sucesso');
    } on HttpExceptionModel catch (e) {
      loading = false;
      notifyListeners();
      return StatusResult.failure(messageCode: e.message);
    }
  }
}