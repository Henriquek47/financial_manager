import 'package:financial_manager/models/response/category_model.dart';

class TransactionModel {
  final String id;
  final double value;
  final String? description;
  final String userId;
  final CategoryModel? category;
  final DateTime createdAt;
  final String? receiverId;

  TransactionModel({
    required this.id,
    required this.value,
    this.description,
    required this.userId,
    required this.category,
    required this.createdAt,
    required this.receiverId,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return TransactionModel(
      id: map['id'],
      value: double.parse(map['value']),
      description: map['description'],
      userId: map['user_id'],
      category: map['category'] != null ? CategoryModel.fromMap(map['category']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      receiverId: map['receiver_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'description': description,
      'user_id': userId,
      'category_id': category!.id,
      'createdAt': createdAt.toIso8601String(),
      'receiver_id': receiverId,
    };
  }
}
