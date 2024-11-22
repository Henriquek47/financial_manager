import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:financial_manager/models/response/graph_model.dart';
import 'package:financial_manager/models/response/summary_model.dart';
import 'package:financial_manager/models/response/user_model.dart';
import 'package:financial_manager/services/financial/financial_service.dart';
import 'package:financial_manager/services/user/user_service.dart';
import 'package:flutter/material.dart';

class FinancialViewModel extends ChangeNotifier {
  final FinancialService financialService;
  final UserService userService;

  FinancialViewModel(
      {required this.financialService, required this.userService});

  UserModel? _user;

  UserModel? get user => _user;

  SummaryModel? _summary;

  SummaryModel? get summary => _summary;

  GraphModel? _graphModel;

  GraphModel? get graphModel => _graphModel;

  SelectFilterGraph selectFilterGraph = SelectFilterGraph.weekly;

  Future<StatusResult> getUser() async {
    try {
      _user = await userService.getUser();
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }

  Future<StatusResult> getSummaryData(int month) async {
    try {
      if (user == null) return StatusResult.failure(doNotShow: true);
      _summary = await financialService.getSummaryData(user!.id, month);
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }

  Future<StatusResult> getFinancialGraph(SelectFilterGraph selectMode) async {
    try {
      if (user == null) return StatusResult.failure(doNotShow: true);
      _graphModel = await financialService.getFinancialGraph(user!.id, selectMode.name);
      notifyListeners();
      return StatusResult.success(doNotShow: true);
    } catch (e) {
      return StatusResult.failure(doNotShow: true);
    }
  }
}

enum SelectFilterGraph{
  weekly,
  monthly,
  yearly
}
