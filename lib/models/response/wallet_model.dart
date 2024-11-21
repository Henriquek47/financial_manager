class WalletModel {
  String id;
  double value;

  WalletModel({required this.id, required this.value});

factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      value: double.parse(map['value'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }
}
