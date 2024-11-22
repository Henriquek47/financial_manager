import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:financial_manager/models/response/category_model.dart';
import 'package:financial_manager/repositories/category_repository.dart';
import 'package:financial_manager/repositories/payment_repository.dart';
import 'package:flutter/material.dart';

class PaymentViewModel extends ChangeNotifier {
  final PaymentRepository paymentRepository;
  final CategoryRepository categoryRepository;

  PaymentViewModel(
      {required this.paymentRepository, required this.categoryRepository});

  String? _category;
  double _value = 0;
  List<CategoryModel> categories = [];

  String? get category => _category;
  set category(String? value) {
    _category = value;
    notifyListeners();
  }

  double get value => _value;
  set value(double value) {
    _value = value;
    notifyListeners();
  }

  Future<StatusResult> payment(String userId) async {
    try {
      if (category == null) {
        return StatusResult.failure(messageCode: "Informe a categoria");
      }
      if (value <= 0) {
        return StatusResult.failure(messageCode: "Valor invalido");
      }
      await paymentRepository.payment(category!, userId, value);
      return StatusResult.success(messageCode: "Sucesso!");
    } catch (e) {
      return StatusResult.failure(
          messageCode: "Não foi possivel enviar o valor");
    }
  }

  Future<StatusResult> rec(String userId) async {
    try {
      if (value <= 0) {
        return StatusResult.failure(messageCode: "Valor invalido");
      }
      await paymentRepository.rec(userId, value);
      return StatusResult.success(messageCode: "Sucesso!");
    } catch (e) {
      return StatusResult.failure(
          messageCode: "Não foi possivel enviar o valor");
    }
  }

  Future<StatusResult> getCategories(String userId) async {
    try {
      categories.clear();
      categories.addAll(await categoryRepository.getCategories(userId));
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }
}
