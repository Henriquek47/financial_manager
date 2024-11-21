import 'package:financial_manager/models/response/breakdown_model.dart';

class GraphModel {
  final double total;
  final List<BreakdownModel> breakdown;

  GraphModel({
    required this.total,
    required this.breakdown,
  });

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'categories': breakdown.map((category) => category.toMap()).toList(),
    };
  }

  factory GraphModel.fromJson(Map<String, dynamic> json) {
    return GraphModel(
      total: json['total']?.toDouble() ?? 0.0,
      breakdown: (json['breakdown'] as List<dynamic>?)?.map((resultJson) {
            return BreakdownModel.fromMap(
              resultJson,
            );
          }).toList() ??
          [],
    );
  }
}
