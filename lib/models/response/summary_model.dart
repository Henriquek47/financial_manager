import 'package:financial_manager/models/response/category_model.dart';

class SummaryModel {
  final double total;
  final List<CategoryModel> categories;

  SummaryModel({
    required this.total,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'categories': categories.map((category) => category.toMap()).toList(),
    };
  }

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      total: json['total']?.toDouble() ?? 0.0,
      categories: (json['result'] as List<dynamic>?)?.map((resultJson) {
            return CategoryModel.fromMap(
              resultJson['category'],
            );
          }).toList() ??
          [],
    );
  }
}
