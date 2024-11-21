import 'package:financial_manager/models/response/wallet_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final WalletModel? wallet;
  final String token;
  final double expenses;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.wallet,
    required this.token,
    required this.expenses,
  });

  // Factory para mapear o JSON na classe UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      wallet: json['wallet'] != null ? WalletModel.fromMap(json['wallet']) : null,
      token: json['token'] ?? '',
      expenses: double.tryParse(json['expenses'] ?? "0") ?? 0,
    );
  }
}
