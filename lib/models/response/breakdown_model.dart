class BreakdownModel {
  String period;
  double totalSpent;

  BreakdownModel({required this.period, required this.totalSpent});

factory BreakdownModel.fromMap(Map<String, dynamic> map) {
    return BreakdownModel(
      period: map['period'],
      totalSpent: map['totalSpent']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'period': period,
      'totalSpent': totalSpent,
    };
  }
}
