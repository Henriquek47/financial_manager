import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String color;
  final String name;
  final String? image;
  final bool isPublic;
  final double? totalSpent;
  final double? profit;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    this.image,
    required this.isPublic,
    this.totalSpent,
    this.profit,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      color: map['cor'] ?? '#F60B3DD',
      image: map['image'],
      isPublic: map['is_public'],
      totalSpent: map['totalSpent']?.toDouble() ?? 0.0,
      profit: map['profit'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'image': image,
      'is_public': isPublic,
    };
  }

  Color getColor() {
    return Color(int.parse('0xFF${color.substring(1)}'));
  }

  bool receipt() {
    return id == 'id de recebimento';
  }
}
