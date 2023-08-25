import 'dart:convert';

import 'package:backend_flutter_ivo/bo/_i_bo.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ingredient implements BO {
  String? _id;
  String name;

  Ingredient(
    this._id, {
    required this.name,
  });

  @override
  String get id => _id ?? '';

  factory Ingredient.fromMap(Map<String, dynamic> json) {
    return Ingredient(json['_id'] ?? '', name: json['name'] ?? '');
  }

  @override
  String toJson() {
    return jsonEncode({
      '_id': id,
      'name': name,
    });
  }

  @override
  String toCreateJson() {
    return jsonEncode({
      'name': name,
    });
  }

  @override
  String showSubtitle() {
    return name;
  }

  @override
  String showTitle() {
    return '';
  }

  @override
  factory Ingredient.placeholder() {
    return Ingredient('', name: '');
  }

  @override
  Widget tileSubtitle() {
    // TODO: implement tileSubtitle
    throw UnimplementedError();
  }

  @override
  Widget tileTitle() {
    // TODO: implement tileTitle
    throw UnimplementedError();
  }
}
